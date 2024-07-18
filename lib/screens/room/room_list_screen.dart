import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/header/app_header.dart';

class MypageScreen extends StatelessWidget {
  const MypageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppHeader(title: 'room一覧ページ'),
    );
  }
}
