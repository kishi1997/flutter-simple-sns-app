import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/navigation/app_bottom_navigation.dart';
import 'package:simple_sns_app/screens/mypage/mypage_screen.dart';
import 'package:simple_sns_app/screens/post/post_list_screen.dart';
import 'package:simple_sns_app/screens/room/room_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  static const List<Widget> _pageList = <Widget>[
    PostListScreen(),
    RoomListScreen(),
    MypageScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pageList.map((Widget page) {
          return Navigator(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => page,
              );
            },
          );
        }).toList(),
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
