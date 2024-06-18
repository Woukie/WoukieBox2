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
import 'package:woukiebox2/src/util/group_chat.dart';
import 'package:woukiebox2/src/util/written_message.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';
import 'package:windows_taskbar/windows_taskbar.dart';

class AppStateProvider extends ChangeNotifier {
  // Need to control this for e.g. deleting/leaving groups and auto selecting when creating group.
  int? _selectedGroup;
  int? _currentUser;
  int _selectedPage = 0;
  final HashMap<int, UserClient> _users = HashMap<int, UserClient>();
  final HashMap<int, GroupChat> _chats = HashMap<int, GroupChat>();
  final HashMap<int, DateTime> _lastRead = HashMap<int, DateTime>();

  final List<dynamic> _messages = List.empty(growable: true);
  final List<int> _friends = List.empty(growable: true);
  final List<int> _outgoingFriendRequests = List.empty(growable: true);
  final List<int> _incomingFriendRequests = List.empty(growable: true);

  // Used when loading users, to make sure we don't trigger loading a user when one is already being loaded
  final Set<int> _loadingUsers = <int>{};

  late final PreferenceProvider _preferenceProvider;

  HashMap<int, UserClient> get users => _users;
  HashMap<int, GroupChat> get chats => _chats;
  HashMap<int, DateTime> get lastRead => _lastRead;

  List<dynamic> get messages => _messages;
  List<int> get friends => _friends;
  List<int> get outgoingFriendRequests => _outgoingFriendRequests;
  List<int> get incomingFriendRequests => _incomingFriendRequests;
  int? get currentUser => _currentUser;
  int? get selectedGroup => _selectedGroup;
  int get selectedPage => _selectedPage;

  void setSelectedGroup(value) {
    _selectedGroup = value;
    if (kDebugMode) print("Selected group $value");
    notifyListeners();
  }

  void setSelectedPage(value) {
    _selectedPage = value;
    notifyListeners();
  }

  final player = AudioPlayer();
  final _winNotifyPlugin = WindowsNotification(
    applicationId:
        r"{6D809377-6AF0-444B-8957-A3773F02200E}\WoukieBox2\WoukieBox2.exe",
  );

  Future<String> messageNotification(
    UserClient sender,
    ChatMessageServer message,
  ) async {
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
    _winNotifyPlugin
        .initNotificationCallBack((NotificationCallBackDetails details) {
      int? group = int.tryParse(details.argrument ?? "");

      // It can be null :)
      // ignore: unnecessary_null_comparison
      if (details.userInput == null || group == null) return;

      windowManager.restore();
      windowManager.focus();

      if (group == 0) {
        // Switch to global
        _selectedPage = 0;
        _selectedGroup = null;
      } else {
        _selectedPage = 1;
        _selectedGroup = group;
      }

      notifyListeners();
    });
  }

  Future<void> readChat(int chat) async {
    _lastRead[chat] = DateTime.now().toUtc();
    notifyListeners();
    await client.sockets.sendStreamMessage(ReadChatClient(chat: chat));
    if (kDebugMode) print("Read chat $chat");
  }

  resetData() {
    _currentUser = null;
    _messages.clear();
    _selectedGroup = null;
    _selectedPage = 0;
    _loadingUsers.clear();
    _lastRead.clear();
    _chats.clear();
    _users.clear();
    _friends.clear();
    _incomingFriendRequests.clear();
    _outgoingFriendRequests.clear();

    notifyListeners();
  }

  initGroupChats(ChatsServer message) async {
    _chats.clear();

    for (Chat chat in message.chats) {
      if (chat.id == null) continue;

      _chats[chat.id!] = GroupChat(
        chat.id!,
        chat.users,
        chat.name,
        chat.owners,
        chat.creator,
        chat.lastMessage,
      );
    }
  }

  chatMessage(ChatMessageServer message) async {
    UserClient? user = _users[message.sender];
    if (user == null) return; // This will never happen. But who knows?

    if (message.chat == 0) {
      WrittenGlobalMessage writtenMessage = WrittenGlobalMessage(
        user.id,
        user.username,
        message.message,
        user.colour,
        user.image,
        message.sentAt,
      );

      _messages.add(writtenMessage);
    } else {
      WrittenChatMessage writtenMessage = WrittenChatMessage(
          message.sender, message.message, message.bucket!, message.sentAt);

      _chats[message.chat]?.messages.add(writtenMessage);
      _chats[message.chat]?.lastMessage = message.sentAt;

      readChat(message.chat);
      if (_selectedGroup == message.chat && _selectedPage == 1) {}
    }

    notifyListeners();

    bool focused = kIsWeb || await windowManager.isFocused();

    if (!_preferenceProvider.recieveNotifications) return;

    // No notifications from your own messages
    if (message.sender == currentUser) return;

    if (focused && !_preferenceProvider.sameChatNotifications) {
      bool onSelected = _selectedPage == 1 && message.chat == _selectedGroup;
      bool onGlobal = _selectedPage == 0 && message.chat == 0;

      if (onSelected || onGlobal) return;
    }

    // In-app notifications locked to enabled for web
    if (!kIsWeb && (focused && (!_preferenceProvider.inAppNotifications))) {
      return;
    }

    if (message.chat == 0 && !_preferenceProvider.globalNotifications) return;

    if (_preferenceProvider.notificationSounds) {
      await player.play(AssetSource("audio/recieve-message.mp3"));
    }

    if (!kIsWeb && _preferenceProvider.desktopNotifications) {
      NotificationMessage notificationMessage =
          NotificationMessage.fromCustomTemplate(
        "ToastGeneric",
        launch: "${message.chat}",
      );
      _winNotifyPlugin.showNotificationCustomTemplate(
        notificationMessage,
        await messageNotification(user, message),
      );
    }

    if (!kIsWeb && _preferenceProvider.taskbarFlashing) {
      WindowsTaskbar.setFlashTaskbarAppIcon(
        mode: TaskbarFlashMode.all | TaskbarFlashMode.timernofg,
        timeout: const Duration(milliseconds: 500),
      );
    }
  }

  roomMembers(RoomMembersServer message) {
    _users.forEach((id, user) {
      user.visible = false;
    });

    for (UserServer user in message.users) {
      _users[user.id] = UserClient(
        id: user.id,
        username: user.username,
        bio: user.bio,
        colour: user.colour,
        image: user.image,
        verified: user.verified,
        visible: true,
      );
    }

    notifyListeners();
  }

  leaveMessage(LeaveChatServer message) {
    UserClient? user = _users[message.sender];
    if (user == null) return; // This will never happen. But who knows?

    if (message.chat == 0) {
      _messages.add(
        WrittenLeaveMessage(
          message.sender,
          user.username,
          user.colour,
          message.sentAt,
        ),
      );

      _users[message.sender]?.visible = false;
    } else {
      GroupChat? chat = _chats[message.chat];
      if (chat == null) return;

      if (message.sender == currentUser) {
        _selectedGroup = null;
        _chats.remove(chat.id);
      } else {
        chat.lastMessage = message.sentAt;
        chat.owners = message.owners ?? chat.owners;
        chat.users.remove(message.sender);
        chat.messages.add(
          WrittenLeaveMessage(
            message.sender,
            user.username,
            user.colour,
            message.sentAt,
          ),
        );
      }
    }

    notifyListeners();
  }

  joinMessage(JoinChatServer message) {
    _messages.add(
      WrittenJoinMessage(
        message.sender.id,
        message.sender.username,
        message.sender.colour,
        message.sentAt,
      ),
    );

    _users[message.sender.id] = UserClient(
      id: message.sender.id,
      username: message.sender.username,
      bio: message.sender.bio,
      colour: message.sender.colour,
      image: message.sender.image,
      verified: message.sender.verified,
      visible: true,
    );

    notifyListeners();
  }

  selfIdentifier(SelfIdentifierServer message) {
    _currentUser = message.id;
    notifyListeners();
  }

  updateProfile(UpdateProfileServer message) {
    UserClient? user = _users[message.sender];
    // The server never sends a null sender, and all users are tracked. But who knows?
    if (user == null) return;

    // We only want to print name and colour changes to the chat
    if (message.username != null || message.colour != null) {
      _messages.add(
        WrittenProfileMessage(
          message.sender,
          user.username,
          user.colour,
          message.username,
          message.colour,
        ),
      );
    }

    _users.update(
      message.sender,
      (user) => user.copyWith(
        bio: message.bio,
        colour: message.colour,
        username: message.username,
        image: message.image,
      ),
    );

    notifyListeners();
  }

  void friendList(FriendListServer message) {
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

    UserServer? user = await client.crud.getUser(userId);

    // We double check the loading users array in case we have logged out, which clears the set
    if (_loadingUsers.contains(userId)) {
      if (user != null) {
        _users[userId] = UserClient(
          id: user.id,
          username: user.username,
          bio: user.bio,
          colour: user.colour,
          image: user.image,
          verified: user.verified,
          visible: _users[userId]?.visible ?? false,
        );

        notifyListeners();
      }

      _loadingUsers.remove(userId);
    }
  }

  Future<void> createChat(CreateChatServer message) async {
    _chats[message.chat.id!] = GroupChat(
      message.chat.id!,
      message.chat.users,
      message.chat.name,
      message.chat.owners,
      message.chat.creator,
      message.chat.lastMessage,
    );

    if (message.chat.creator == _currentUser) {
      _selectedGroup = message.chat.id;
      _selectedPage = 1;

      readChat(message.chat.id!);
    }

    notifyListeners();
  }

  void renameChat(RenameChat message) {
    _chats[message.chat]?.name = message.name;
    notifyListeners();
  }

  // call when needing to load more message history
  Future<void> loadNextBucket(int chat) async {
    if (chat == 0) return;

    GroupChat? groupChat = _chats[chat];
    if (groupChat == null) return;

    // null to load latest bucket
    int? bucket;
    if (groupChat.messages.isEmpty) {
      if (groupChat.bucketsLoading.contains(-1)) return;
    } else {
      bucket = groupChat.messages.firstWhere((message) {
        return message is WrittenChatMessage;
      })!.bucket;

      // cannot do -= for null safety
      bucket = bucket! - 1;
    }

    if (bucket == 0 || groupChat.bucketsLoading.contains(bucket)) return;

    groupChat.bucketsLoading.add(bucket ?? -1);

    List<ChatMessage>? chatMessages = await client.crud.getBucket(chat, bucket);

    // We double check if the group chat still exists in case we logged out
    // Add new messages to the group
    if (_chats[chat] != null &&
        chatMessages != null &&
        chatMessages.isNotEmpty) {
      List<WrittenChatMessage> newMessages = chatMessages
          .map(
            (message) => WrittenChatMessage(message.senderId, message.message,
                message.bucket, message.sentAt),
          )
          .toList();

      groupChat.messages.insertAll(0, newMessages.reversed);
      notifyListeners();
    }

    groupChat.bucketsLoading.remove(bucket);
  }

  void lastReadServer(LastReadServer message) {
    _lastRead.clear();
    _lastRead.addAll(message.readData);
    notifyListeners();
  }
}
