import 'dart:io';
import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  final String iconImageUrl;
  const ProfileIcon({
    super.key,
    required this.iconImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    if (iconImageUrl.isEmpty) {
      return const ClipOval(
        child: Icon(
          Icons.person,
          size: 80,
        ),
      );
    }

    Widget imageWidget;
    if (iconImageUrl.startsWith('http')) {
      imageWidget = Image.network(iconImageUrl);
    } else {
      imageWidget = Image.file(File(iconImageUrl));
    }

    return ClipOval(
      child: SizedBox(
        width: 80,
        height: 80,
        child: FittedBox(
          fit: BoxFit.cover,
          child: imageWidget,
        ),
      ),
    );
  }
}
