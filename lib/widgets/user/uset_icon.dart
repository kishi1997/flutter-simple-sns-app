import 'package:flutter/material.dart';

class BuildUserIcon extends StatelessWidget {
  final String? iconImageUrl;

  const BuildUserIcon({
    super.key,
    this.iconImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    if (iconImageUrl != null) {
      return const CircleAvatar(
        child: Icon(Icons.person),
      );
    }
    return CircleAvatar(
      backgroundImage: NetworkImage(iconImageUrl!),
    );
  }
}
