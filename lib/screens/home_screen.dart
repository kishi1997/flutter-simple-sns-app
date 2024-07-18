import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/navigation/app_bottom_navigation.dart';
import 'package:simple_sns_app/screens/message/room_list_screen.dart';
import 'package:simple_sns_app/screens/mypage/mypage_screen.dart';
import 'package:simple_sns_app/screens/post/post_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pageList = <Widget>[
    PostListScreen(),
    RoomListScreen(),
    MypageScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pageList,
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
