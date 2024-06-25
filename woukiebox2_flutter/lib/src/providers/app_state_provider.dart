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
import 'package:woukiebox2/src/util/user.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';
import 'package:windows_taskbar/windows_taskbar.dart';

class AppStateProvider extends ChangeNotifier {
  // Need to control this for e.g. deleting/leaving groups and auto selecting when creating group.
  int? _selectedChat;
  int? _currentUser;
  int _selectedPage = 0;
  final HashMap<int, User> _users = HashMap<int, User>();
  final HashMap<int, GroupChat> _chats = HashMap<int, GroupChat>();
  final HashMap<int, DateTime> _lastRead = HashMap<int, DateTime>();

  final List<NetworkChatMessage> _messages = List.empty(growable: true);
  final List<int> _friends = List.empty(growable: true);
  final List<int> _outgoingFriendRequests = List.empty(growable: true);
  final List<int> _incomingFriendRequests = List.empty(growable: true);

  // Used when loading users, to make sure we don't trigger loading a user when one is already being loaded
  final Set<int> _loadingUsers = <int>{};

  late final PreferenceProvider _preferenceProvider;

  HashMap<int, User> get users => _users;
  HashMap<int, GroupChat> get chats => _chats;
  HashMap<int, DateTime> get lastRead => _lastRead;

  List<NetworkChatMessage> get globalMessages => _messages;
  List<int> get friends => _friends;
  List<int> get outgoingFriendRequests => _outgoingFriendRequests;
  List<int> get incomingFriendRequests => _incomingFriendRequests;
  int? get currentUser => _currentUser;
  int? get selectedChat => _selectedChat;
  int get selectedPage => _selectedPage;

  void setSelectedGroup(value) {
    _selectedChat = value;
    if (kDebugMode) print("Selected group $value");
    readChat(value);
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
    User sender,
    NetworkChatMessage message,
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
        _selectedChat = null;
      } else {
        _selectedPage = 1;
        _selectedChat = group;
        readChat(group);
      }

      notifyListeners();
    });
  }

  Future<void> readChat(int chat) async {
    await client.sockets.sendStreamMessage(ReadChatClient(chat: chat));
  }

  resetData() {
    _currentUser = null;
    _messages.clear();
    _selectedChat = null;
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
        id: chat.id!,
        users: chat.users,
        name: chat.name,
        owners: chat.owners,
        creator: chat.creator,
        lastMessage: chat.lastMessage,
      );
    }
  }

  chatMessage(NetworkChatMessage message) async {
    User? user = _users[message.sender];
    if (user == null) return;

    switch (message.action) {
      case MessageType.AddFriends:
        _chats[message.chat]?.users.addAll(message.targets!);

        if (isChatSelected() && _selectedChat == message.chat) {
          readChat(message.chat);
        }

        break;
      case MessageType.Kick:
        removeUser(
          message.targets!.first,
          message.chat,
          message.sentAt!,
          null,
        );
        break;
      case MessageType.Leave:
        removeUser(
          message.sender!,
          message.chat,
          message.sentAt!,
          message.targets,
        );
        break;
      case MessageType.Promote:
        chats[message.chat]?.owners.add(message.targets!.first);

        if (isChatSelected() && _selectedChat == message.chat) {
          readChat(message.chat);
        }
        break;
      case MessageType.Rename:
        _chats[message.chat]?.name = message.message!;
        break;
      default:
    }

    if (message.chat == 0) {
      _messages.add(message);
    } else {
      _chats[message.chat]?.messages.add(message);
      _chats[message.chat]?.lastMessage = message.sentAt!;

      if (_selectedChat == message.chat && _selectedPage == 1) {
        readChat(message.chat);
      }
    }

    notifyListeners();

    bool focused = kIsWeb || await windowManager.isFocused();

    if (!_preferenceProvider.recieveNotifications) return;

    // No notifications from your own messages
    if (message.sender == currentUser) return;

    if (focused && !_preferenceProvider.sameChatNotifications) {
      bool onSelected = _selectedPage == 1 && message.chat == _selectedChat;
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
      _users[user.id] = User(
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

  joinMessage(JoinChatServer message) {
    // TODO: log global join messages

    _users[message.sender.id] = User(
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
    User? user = _users[message.sender];
    if (user == null) return;

    // We only want to print name and colour changes to the chat
    // TODO: log global profile changes
    // if (message.username != null || message.colour != null) {
    //   _messages.add(
    //     ProfileMessage(
    //       oldUsername: user.username,
    //       oldColour: user.colour,
    //       newUsername: message.username,
    //       newColour: message.colour,
    //       senderId: message.sender,
    //       sentAt: message.sentAt,
    //     ),
    //   );
    // }

    user.bio = message.bio ?? user.bio;
    user.colour = message.colour ?? user.colour;
    user.username = message.username ?? user.username;
    user.image = message.image ?? user.image;

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
        _users[userId] = User(
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
      id: message.chat.id!,
      users: message.chat.users,
      name: message.chat.name,
      owners: message.chat.owners,
      creator: message.chat.creator,
      lastMessage: message.chat.lastMessage,
    );

    if (message.chat.creator == _currentUser) {
      _selectedChat = message.chat.id;
      _selectedPage = 1;

      readChat(message.chat.id!);
    }

    notifyListeners();
  }

  // call when needing to load more message history
  Future<void> loadNextBucket(int? chat) async {
    if (chat == 0 || chat == null) return;

    GroupChat? groupChat = _chats[chat];
    if (groupChat == null) return;

    // null to load latest bucket
    int? bucket;
    if (groupChat.messages.isEmpty) {
      if (groupChat.bucketsLoading.contains(-1)) return;
    } else {
      bucket = groupChat.messages.first.bucket! - 1;
    }

    if (bucket == 0 || groupChat.bucketsLoading.contains(bucket)) return;

    groupChat.bucketsLoading.add(bucket ?? -1);

    List<NetworkChatMessage>? chatMessages =
        await client.crud.getBucket(chat, bucket);

    // We double check if the group chat still exists in case we logged out
    // Add new messages to the group
    if (_chats[chat] != null &&
        chatMessages != null &&
        chatMessages.isNotEmpty) {
      groupChat.messages.insertAll(0, chatMessages.reversed);
      notifyListeners();
    }

    groupChat.bucketsLoading.remove(bucket);
  }

  void lastReadServer(LastReadServer message) {
    _lastRead.clear();
    _lastRead.addAll(message.readData);
    notifyListeners();
  }

  void readChatServer(ReadChatServer message) {
    _lastRead[message.chat] = message.readAt;
    notifyListeners();
  }

  bool isGlobalChatSelected() {
    return _selectedPage == 0;
  }

  bool isChatSelected() {
    return _selectedPage == 1 && chats.containsKey(_selectedChat);
  }

  void removeUser(
      int kickedUser, int chat, DateTime sentAt, List<int>? newOwners) {
    User? user = _users[kickedUser];
    if (user == null) return;

    if (chat == 0) {
      _users[kickedUser]?.visible = false;
    } else {
      GroupChat? groupChat = _chats[chat];
      if (groupChat == null) return;

      if (kickedUser == currentUser) {
        _selectedChat = null;
        _chats.remove(groupChat.id);
      } else {
        groupChat.lastMessage = sentAt;
        groupChat.owners = newOwners ?? groupChat.owners;
        groupChat.users.remove(kickedUser);
      }
    }

    notifyListeners();
  }
}
