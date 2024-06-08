import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  int? selectedGroup;

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
            elevation: 0,
            child: SizedBox(
              width: 256, // Same as minWidth of extended navigation rails
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: groupChats.length,
                  itemBuilder: (context, index) {
                    GroupChat groupChat = groupChats[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Card(
                        margin: EdgeInsets.zero,
                        color: Theme.of(context).colorScheme.surfaceContainer,
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
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Text(
                "${appStateProvider.currentUser}",
                overflow: TextOverflow.fade,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
