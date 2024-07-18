import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/header/app_header.dart';

class RoomListScreen extends StatelessWidget {
  const RoomListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppHeader(title: 'ルーム一覧ページ'),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('仮のルーム一覧ページ', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
