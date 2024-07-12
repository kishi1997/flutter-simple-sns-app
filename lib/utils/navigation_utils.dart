import 'package:flutter/material.dart';

void navigateToPageReplacement(
  BuildContext context,
  Widget page,
) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}
