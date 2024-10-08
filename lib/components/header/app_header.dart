import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const AppHeader({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: actions);
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
