import 'dart:io';
import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  final String iconImageUrl;
  final File? imageFile;

  const ProfileIcon({
    super.key,
    required this.iconImageUrl,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    if (imageFile != null) {
      return ClipOval(
        child: SizedBox(
          width: 80,
          height: 80,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image.file(imageFile!),
          ),
        ),
      );
    }

    if (iconImageUrl.isEmpty) {
      return const ClipOval(
        child: Icon(
          Icons.person,
          size: 80,
        ),
      );
    }

    return ClipOval(
      child: SizedBox(
        width: 80,
        height: 80,
        child: FittedBox(fit: BoxFit.cover, child: Image.network(iconImageUrl)),
      ),
    );
  }
}
