import 'dart:io';

import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final String? url;
  final bool? local;
  final bool showIndicator;
  final bool imageEffects;
  final bool offline;

  const ProfilePic({
    super.key,
    this.url,
    this.local,
    this.showIndicator = true,
    this.imageEffects = true,
    required this.offline,
  });

  @override
  Widget build(BuildContext context) {
    return showIndicator
        ? Stack(
            alignment: Alignment.bottomRight,
            children: [
              ClipPath(
                clipper: StatusClip(),
                child: offline && imageEffects
                    ? Opacity(
                        opacity: 0.6,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
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
          )
        : Avatar(url: url, local: local);
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
    if (url != null && url != "" && url != "null") {
      // To support web
      ImageProvider<Object> image = (local != null && local!
          ? FileImage(File(url!))
          : NetworkImage(url!)) as ImageProvider<Object>;

      return Container(
        constraints: const BoxConstraints(
          minHeight: 40,
          minWidth: 40,
          maxWidth: 40,
          maxHeight: 40,
        ),
        foregroundDecoration: BoxDecoration(
          image: DecorationImage(
            image: image,
            fit: BoxFit.cover,
          ),
          shape: BoxShape.circle,
        ),
      );
    }

    final TextStyle fontStyle = TextStyle(
      inherit: false,
      fontSize: 40,
      color: Theme.of(context).colorScheme.secondary,
      fontFamily: Icons.person.fontFamily,
      package: Icons.person.fontPackage,
      height: 1.0,
      leadingDistribution: TextLeadingDistribution.even,
    );

    return SizedBox(
      width: 40,
      height: 40,
      child: Center(
        child: RichText(
          overflow: TextOverflow.visible,
          text: TextSpan(
            style: fontStyle,
            text: String.fromCharCode(Icons.person.codePoint),
          ),
        ),
      ),
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
