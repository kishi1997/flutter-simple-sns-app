import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/header/app_header.dart';

class MypageScreen extends StatelessWidget {
  const MypageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppHeader(title: 'マイページ'),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('仮のマイページ', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
