import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: 250,
          padding: const EdgeInsets.all(12),
          child: const Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: CircleAvatar(),
                  ),
                  Expanded(
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 0,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Name...",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 12),
                child: Card(
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "Bio...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
