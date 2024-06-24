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
import 'package:woukiebox2_client/woukiebox2_client.dart' as protocol;
import 'package:windows_taskbar/windows_taskbar.dart';

class AppStateProvider extends ChangeNotifier {
  // Need to control this for e.g. deleting/leaving groups and auto selecting when creating group.
  int? _selectedChat;
  int? _currentUser;
  int _selectedPage = 0;
  final HashMap<int, protocol.UserClient> _users =
      HashMap<int, protocol.UserClient>();
  final HashMap<int, GroupChat> _chats = HashMap<int, GroupChat>();
  final HashMap<int, DateTime> _lastRead = HashMap<int, DateTime>();

  final List<BaseMessage> _messages = List.empty(growable: true);
  final List<int> _friends = List.empty(growable: true);
  final List<int> _outgoingFriendRequests = List.empty(growable: true);
  final List<int> _incomingFriendRequests = List.empty(growable: true);

  // Used when loading users, to make sure we don't trigger loading a user when one is already being loaded
  final Set<int> _loadingUsers = <int>{};

  late final PreferenceProvider _preferenceProvider;

  HashMap<int, protocol.UserClient> get users => _users;
  HashMap<int, GroupChat> get chats => _chats;
  HashMap<int, DateTime> get lastRead => _lastRead;

  List<BaseMessage> get globalMessages => _messages;
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
    protocol.UserClient sender,
    protocol.ChatMessageServer message,
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
    await client.sockets.sendStreamMessage(protocol.ReadChatClient(chat: chat));
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

  initGroupChats(protocol.ChatsServer message) async {
    _chats.clear();

    for (protocol.Chat chat in message.chats) {
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

  chatMessage(protocol.ChatMessageServer message) async {
    protocol.UserClient? user = _users[message.sender];
    if (user == null) return; // This will never happen. But who knows?

    if (message.chat == 0) {
      ChatMessage writtenMessage = ChatMessage(
        username: user.username,
        color: user.colour,
        image: user.image,
        bucket: 0,
        message: message.message,
        senderId: user.id,
        sentAt: message.sentAt,
      );

      _messages.add(writtenMessage);
    } else {
      ChatMessage writtenMessage = ChatMessage(
        bucket: message.bucket!,
        senderId: message.sender,
        message: message.message,
        sentAt: message.sentAt,
      );

      _chats[message.chat]?.messages.add(writtenMessage);
      _chats[message.chat]?.lastMessage = message.sentAt;

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

  roomMembers(protocol.RoomMembersServer message) {
    _users.forEach((id, user) {
      user.visible = false;
    });

    for (protocol.UserServer user in message.users) {
      _users[user.id] = protocol.UserClient(
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

  leaveMessage(protocol.LeaveChatServer message) {
    protocol.UserClient? user = _users[message.sender];
    if (user == null) return; // This will never happen. But who knows?

    if (message.chat == 0) {
      _messages.add(
        LeaveMessage(
          colour: user.colour,
          senderId: message.sender,
          username: user.username,
          sentAt: message.sentAt,
        ),
      );

      _users[message.sender]?.visible = false;
    } else {
      GroupChat? chat = _chats[message.chat];
      if (chat == null) return;

      if (message.sender == currentUser) {
        _selectedChat = null;
        _chats.remove(chat.id);
      } else {
        chat.lastMessage = message.sentAt;
        chat.owners = message.owners ?? chat.owners;
        chat.users.remove(message.sender);
        chat.messages.add(
          LeaveMessage(
            colour: user.colour,
            senderId: message.sender,
            username: user.username,
            sentAt: message.sentAt,
          ),
        );
      }
    }

    notifyListeners();
  }

  joinMessage(protocol.JoinChatServer message) {
    _messages.add(
      JoinMessage(
        username: message.sender.username,
        colour: message.sender.colour,
        senderId: message.sender.id,
        sentAt: message.sentAt,
      ),
    );

    _users[message.sender.id] = protocol.UserClient(
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

  selfIdentifier(protocol.SelfIdentifierServer message) {
    _currentUser = message.id;
    notifyListeners();
  }

  updateProfile(protocol.UpdateProfileServer message) {
    protocol.UserClient? user = _users[message.sender];
    // The server never sends a null sender, and all users are tracked. But who knows?
    if (user == null) return;

    // We only want to print name and colour changes to the chat
    if (message.username != null || message.colour != null) {
      _messages.add(
        ProfileMessage(
          oldUsername: user.username,
          oldColour: user.colour,
          newUsername: message.username,
          newColour: message.colour,
          senderId: message.sender,
          sentAt: message.sentAt,
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

  void friendList(protocol.FriendListServer message) {
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

    protocol.UserServer? user = await client.crud.getUser(userId);

    // We double check the loading users array in case we have logged out, which clears the set
    if (_loadingUsers.contains(userId)) {
      if (user != null) {
        _users[userId] = protocol.UserClient(
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

  Future<void> createChat(protocol.CreateChatServer message) async {
    _chats[message.chat.id!] = GroupChat(
      message.chat.id!,
      message.chat.users,
      message.chat.name,
      message.chat.owners,
      message.chat.creator,
      message.chat.lastMessage,
    );

    if (message.chat.creator == _currentUser) {
      _selectedChat = message.chat.id;
      _selectedPage = 1;

      readChat(message.chat.id!);
    }

    notifyListeners();
  }

  void renameChat(protocol.RenameChat message) {
    _chats[message.chat]?.name = message.name;
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
      ChatMessage chatMessage = groupChat.messages.firstWhere((message) {
        return message is ChatMessage;
      }) as ChatMessage;
      bucket = chatMessage.bucket;

      // cannot do -= for null safety
      bucket = bucket - 1;
    }

    if (bucket == 0 || groupChat.bucketsLoading.contains(bucket)) return;

    groupChat.bucketsLoading.add(bucket ?? -1);

    List<protocol.ChatMessage>? chatMessages =
        await client.crud.getBucket(chat, bucket);

    // We double check if the group chat still exists in case we logged out
    // Add new messages to the group
    if (_chats[chat] != null &&
        chatMessages != null &&
        chatMessages.isNotEmpty) {
      List<ChatMessage> newMessages = chatMessages
          .map(
            (message) => ChatMessage(
              bucket: message.bucket,
              message: message.message,
              senderId: message.senderId,
              sentAt: message.sentAt,
            ),
          )
          .toList();

      groupChat.messages.insertAll(0, newMessages.reversed);
      notifyListeners();
    }

    groupChat.bucketsLoading.remove(bucket);
  }

  void lastReadServer(protocol.LastReadServer message) {
    _lastRead.clear();
    _lastRead.addAll(message.readData);
    notifyListeners();
  }

  void readChatServer(protocol.ReadChatServer message) {
    _lastRead[message.chat] = message.readAt;
    notifyListeners();
  }

  void kickChatMember(protocol.KickChatMemberServer message) {
    if (message.target == currentUser) {
      chats.remove(message.chat);
      if (_selectedChat == message.chat) _selectedChat = 0;
    } else {
      chats[message.chat]?.users.remove(message.target);
      chats[message.chat]?.lastMessage = message.sentAt;

      if (isChatSelected() && _selectedChat == message.chat) {
        readChat(message.chat);
      }
    }

    notifyListeners();
  }

  void promoteChatMember(protocol.PromoteChatMemberServer message) {
    chats[message.chat]?.owners.add(message.target);
    chats[message.chat]?.lastMessage = message.sentAt;

    if (isChatSelected() && _selectedChat == message.chat) {
      readChat(message.chat);
    }

    notifyListeners();
  }

  void addChatMembers(protocol.AddChatMembersServer message) {
    _chats[message.chat]?.users.addAll(message.users);
    chats[message.chat]?.lastMessage = message.sentAt;

    if (isChatSelected() && _selectedChat == message.chat) {
      readChat(message.chat);
    }

    notifyListeners();
  }

  bool isGlobalChatSelected() {
    return _selectedPage == 0;
  }

  bool isChatSelected() {
    return _selectedPage == 1 && chats.containsKey(_selectedChat);
  }
}
