import 'package:book_demo/LoginPage.dart';
import 'package:book_demo/api_server.dart';
import 'package:book_demo/components/my_banner.dart';
import 'package:book_demo/components/my_empty.dart';
import 'package:book_demo/components/my_webview.dart';
import 'package:book_demo/countDemo.dart';
import 'package:book_demo/models/home_news_model.dart';
import 'package:book_demo/models/local_tools.dart';
import 'package:book_demo/models/utl.dart';
import 'package:book_demo/profile_page.dart';
import 'package:book_demo/team_page.dart';
import 'package:flutter/material.dart';
import 'package:book_demo/widge_demo.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'newspage.dart';
import 'video_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.sports_baseball), label: 'Teams'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.video_library), label: 'video'),
    const BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Profile'),
  ];

  // 是否登陆
  bool _isLogin = false;

  final List<Widget> _pages = [
    const NBANewsPage(),
    const TeamPage(),
    const ViedeoPage(),
    const ProfilePage(),
  ];

  int _selectIndex = 0;
  void _navigationBottomBar(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    LocalTools.shared.isLogin();
    // .then((value) {
    //   setState(() {
    //     _isLogin = value;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalTools>(builder: (context, model, _) {
      LoggerTools.share(' nofity response --> ${model.isLoginStatus}');
      _isLogin = model.isLoginStatus;
      return _buidPage();
    });

    // return _buidPage();
  }

  // 如果登陆, 则展示首页; 否则, 为登陆
  Widget _buidPage() {
    LoggerTools.share(' ->> _buidPage login is $_isLogin');

    if (_isLogin) {
      return Scaffold(
        body: _pages[_selectIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectIndex,
            onTap: _navigationBottomBar,
            type: BottomNavigationBarType.fixed,
            items: items),
      );
    } else {
      return LoginPage();
    }
  }
}
