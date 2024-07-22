import 'package:flutter/material.dart';

class PostButton extends StatelessWidget {
  final bool isFormValid;
  final VoidCallback onPressed;

  const PostButton({
    super.key,
    required this.isFormValid,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isFormValid ? onPressed : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isFormValid
              ? Colors.white
              : const Color.fromARGB(108, 255, 255, 255),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: const Text(
          "投稿",
          style: TextStyle(color: Colors.lightGreen, fontSize: 16.0),
        ),
      ),
    );
  }
}
