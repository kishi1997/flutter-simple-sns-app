import 'package:flutter/material.dart';
import 'package:simple_sns_app/utils/url_utils.dart';

class UserIcon extends StatelessWidget {
  final String? iconImageUrl;

  const UserIcon({
    super.key,
    this.iconImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    if (iconImageUrl != null) {
      return CircleAvatar(
        backgroundImage:
            NetworkImage(replaceLocalhostWithNetworkBaseUrl(iconImageUrl!)),
      );
    }
    return const CircleAvatar(
      child: Icon(Icons.person),
    );
  }
}
