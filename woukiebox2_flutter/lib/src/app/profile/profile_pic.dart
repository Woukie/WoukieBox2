import 'dart:io';

import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final String? url;
  final bool? local;
  final bool offline;

  const ProfilePic({
    super.key,
    this.url,
    this.local,
    this.offline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ClipPath(
          clipper: StatusClip(),
          child: offline
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Color.fromARGB(160, 141, 141, 141),
                      BlendMode.saturation,
                    ),
                    child: Avatar(url: url, local: local),
                  ),
                )
              : Avatar(url: url, local: local),
        ),
        Padding(
          padding: const EdgeInsets.all(3),
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: offline ? Colors.grey : Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.url,
    required this.local,
  });

  final String? url;
  final bool? local;

  @override
  Widget build(BuildContext context) {
    if (url != null && url != "") {
      if (local != null && local!) {
        return CircleAvatar(
          radius: 20,
          foregroundImage: FileImage(File(url!)),
        );
      }

      return CircleAvatar(
        radius: 20,
        foregroundImage: NetworkImage(url!),
      );
    }

    return const Icon(
      size: 40,
      Icons.person,
    );
  }
}

class StatusClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(Rect.fromCircle(
          center: Offset(size.width - 8, size.height - 8), radius: 8))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
