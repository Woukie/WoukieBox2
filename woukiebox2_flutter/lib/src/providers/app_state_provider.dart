import 'dart:collection';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';
import 'package:woukiebox2/main.dart';
import 'package:woukiebox2/src/providers/preference_provider.dart';
import 'package:woukiebox2/src/util/assets.dart';
import 'package:woukiebox2/src/util/written_message.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';
import 'package:windows_taskbar/windows_taskbar.dart';

class AppStateProvider extends ChangeNotifier {
  int? _currentUser;
  final HashMap<int, User> _users = HashMap<int, User>();
  final List<dynamic> _messages = List.empty(growable: true);
  final List<int> _friends = List.empty(growable: true);
  final List<int> _outgoingFriendRequests = List.empty(growable: true);
  final List<int> _incomingFriendRequests = List.empty(growable: true);

  // Used when loading users, to make sure we don't trigger loading a user when one is already being loaded
  final Set<int> _loadingUsers = <int>{};

  late final PreferenceProvider _preferenceProvider;

  HashMap<int, User> get users => _users;
  List<dynamic> get messages => _messages;
  List<int> get friends => _friends;
  List<int> get outgoingFriendRequests => _outgoingFriendRequests;
  List<int> get incomingFriendRequests => _incomingFriendRequests;
  int? get currentUser => _currentUser;

  final player = AudioPlayer();
  final _winNotifyPlugin = WindowsNotification(
    applicationId:
        r"{6D809377-6AF0-444B-8957-A3773F02200E}\WoukieBox2\WoukieBox2.exe",
  );

  Future<String> messageNotification(User sender, ChatMessage message) async {
    return '''
      <toast>
        <visual>
          <binding template="ToastGeneric">
            <text hint-maxLines="1">${sender.username} #${sender.id}</text>
            <text>${message.message}</text>
            <image placement='appLogoOverride' src='
              ${(sender.image == "" ? await getImageFileFromAssets("anonymous-profile.png") : await DefaultCacheManager().getSingleFile(sender.image)).absolute.path}' 
              ${sender.image != "" ? "hint-crop='circle'" : ""}
            />
          </binding>
        </visual>
        <audio silent='true'/>
      </toast>
    ''';
  }

  AppStateProvider(BuildContext context) {
    _preferenceProvider =
        Provider.of<PreferenceProvider>(context, listen: false);
  }

  resetData() {
    _currentUser = null;
    _messages.clear();
    _loadingUsers.clear();
    _users.clear();
    _friends.clear();
    _incomingFriendRequests.clear();
    _outgoingFriendRequests.clear();

    notifyListeners();
  }

  chatMessage(ChatMessage message) async {
    User? user = _users[message.sender];
    if (user == null) return; // This will never happen. But who knows?

    // We do this to preserve the details at the time of the message. If we only have a reference to the user.id, then sender and color would update
    _messages.add(
      WrittenMessage(
        user.id,
        user.username,
        message.message,
        user.colour,
        user.image,
      ),
    );

    notifyListeners();

    // No notifications from your own messages
    if (message.sender == currentUser) return;

    bool windowFocused = kIsWeb || await windowManager.isFocused();

    MessageSoundMode soundMode = _preferenceProvider.messageSoundMode;
    if (soundMode == MessageSoundMode.all ||
        (soundMode == MessageSoundMode.unfocussed && !windowFocused)) {
      await player.play(AssetSource("audio/recieve-message.mp3"));
    }

    if (!kIsWeb && _preferenceProvider.taskbarFlashing) {
      WindowsTaskbar.setFlashTaskbarAppIcon(
        mode: TaskbarFlashMode.all | TaskbarFlashMode.timernofg,
        timeout: const Duration(milliseconds: 500),
      );
    }

    if (!kIsWeb && !windowFocused && _preferenceProvider.desktopNotifications) {
      NotificationMessage notificationMessage =
          NotificationMessage.fromCustomTemplate("ToastGeneric");
      _winNotifyPlugin.showNotificationCustomTemplate(
          notificationMessage, await messageNotification(user, message));
    }
  }

  roomMembers(RoomMembers message) {
    _users.forEach((id, user) {
      user.visible = false;
    });

    for (User user in message.users) {
      _users[user.id] = user;
    }

    notifyListeners();
  }

  leaveMessage(LeaveMessage message) {
    User? user = _users[message.id];
    if (user == null) return; // This will never happen. But who knows?

    _messages.add(
      WrittenLeaveMessage(
        message.id,
        user.username,
        user.colour,
      ),
    );

    _users[message.id]?.visible = false;
    notifyListeners();
  }

  joinMessage(JoinMessage message) {
    _messages.add(
      WrittenJoinMessage(
        message.user.id,
        message.user.username,
        message.user.colour,
      ),
    );

    _users[message.user.id] = message.user;
    notifyListeners();
  }

  selfIdentifier(SelfIdentifier message) {
    _currentUser = message.id;
    notifyListeners();
  }

  updateProfile(UpdateProfile message) {
    User? user = _users[message.sender];
    // The server never sends a null sender, and all users are tracked. But who knows?
    if (user == null) return;

    // We only want to print name and colour changes to the chat
    if (message.username != null || message.colour != null) {
      _messages.add(
        WrittenProfileMessage(
          message.sender!,
          user.username,
          user.colour,
          message.username,
          message.colour,
        ),
      );
    }

    _users.update(
      message.sender!, // We know there's a user with this id
      (user) => user.copyWith(
        bio: message.bio,
        colour: message.colour,
        username: message.username,
        image: message.image,
      ),
    );

    notifyListeners();
  }

  void friendList(FriendList message) {
    _friends.clear();
    _friends.addAll(message.friends);

    _outgoingFriendRequests.clear();
    _outgoingFriendRequests.addAll(message.outgoingFriendRequests);

    _incomingFriendRequests.clear();
    _incomingFriendRequests.addAll(message.incomingFriendRequests);

    notifyListeners();
  }

  Future<void> scheduleGetUser(int userId) async {
    if (_loadingUsers.contains(userId)) return;
    _loadingUsers.add(userId);

    User? user = await client.crud.getUser(userId);
    print(user);

    // We double check the loading users array in case we have logged out, which clears the set
    if (_loadingUsers.contains(userId)) {
      if (user != null) {
        _users[userId] = user;
        notifyListeners();
      }

      _loadingUsers.remove(userId);
    }
  }
}
