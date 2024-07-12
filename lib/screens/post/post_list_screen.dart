import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/header/app_header.dart';

// 仮の投稿一覧ページ
class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppHeader(title: '投稿一覧'),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('仮の投稿一覧ページ', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
