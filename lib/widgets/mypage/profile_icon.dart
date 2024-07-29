import 'dart:io';
import 'package:flutter/material.dart';
import 'package:simple_sns_app/utils/url_utils.dart';

class ProfileIcon extends StatelessWidget {
  final String? iconImageUrl;
  final File? imageFile;

  const ProfileIcon({
    super.key,
    this.iconImageUrl,
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

    if (iconImageUrl == null) {
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
        child: FittedBox(
            fit: BoxFit.cover,
            child: Image.network(
                replaceLocalhostWithNetworkBaseUrl(iconImageUrl!))),
      ),
    );
  }
}
