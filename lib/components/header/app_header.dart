import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

class AppHeaderWithActions extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final String buttonText;
  final bool isFormValid;
  final VoidCallback onPressed;

  const AppHeaderWithActions({
    super.key,
    required this.title,
    required this.buttonText,
    required this.isFormValid,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      backgroundColor: Theme.of(context).primaryColor,
      actions: [
        TextButton(
          onPressed: isFormValid ? onPressed : null,
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: isFormValid
                  ? Colors.white
                  : const Color.fromARGB(108, 255, 255, 255),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(color: Colors.lightGreen, fontSize: 16.0),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
