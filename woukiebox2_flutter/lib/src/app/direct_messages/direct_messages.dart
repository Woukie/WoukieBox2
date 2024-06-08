import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/app/chatroom/message_box/message_box.dart';
import 'package:woukiebox2/src/app/chatroom/messages/messages.dart';
import 'package:woukiebox2/src/app/profile/profile_pic.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2/src/util/group_chat.dart';

class DirectMessages extends StatefulWidget {
  const DirectMessages({
    super.key,
  });

  @override
  State<DirectMessages> createState() => _DirectMessagesState();
}

class _DirectMessagesState extends State<DirectMessages> {
  int? _selectedGroup;

  @override
  Widget build(BuildContext context) {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);

    final List<GroupChat> groupChats =
        appStateProvider.groupChats.values.toList();

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Card(
            margin: const EdgeInsets.only(right: 12),
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            child: SizedBox(
              width: 256, // Same as minWidth of extended navigation rails
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                  itemCount: groupChats.length,
                  itemBuilder: (context, index) {
                    GroupChat groupChat = groupChats[index];
                    bool selected = groupChat.id == _selectedGroup;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Card(
                        margin: EdgeInsets.zero,
                        elevation: selected ? 1 : 0,
                        color: selected
                            ? Theme.of(context).colorScheme.surfaceContainer
                            : null,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            setState(() {
                              _selectedGroup = groupChat.id;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            child: Row(
                              children: [
                                ProfilePic(url: groupChat.image),
                                const Padding(
                                  padding: EdgeInsets.only(right: 12),
                                ),
                                Expanded(
                                  child: Text(
                                    softWrap: false,
                                    groupChat.name,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Card(
                    color: Theme.of(context).colorScheme.surfaceContainerLow,
                    margin: EdgeInsets.zero,
                    elevation: 1,
                    child: _selectedGroup == null
                        ? Container()
                        : Messages(
                            messages: groupChats[_selectedGroup!].messages,
                          ),
                  ),
                ),
                MessageBox(target: _selectedGroup ?? 0)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
