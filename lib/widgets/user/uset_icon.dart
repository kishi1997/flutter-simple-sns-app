import 'package:flutter/material.dart';

Widget buildUserIcon(String? iconImageUrl) {
  if (iconImageUrl == null) {
    return const CircleAvatar(
      child: Icon(Icons.person),
    );
  }
  return CircleAvatar(
    backgroundImage: NetworkImage(iconImageUrl),
  );
}
