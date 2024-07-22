import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/header/app_header.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppHeader(title: '投稿作成ページ'),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('仮の投稿作成マイページ', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
