import 'package:book_demo/LoginPage.dart';
import 'package:book_demo/countDemo.dart';
import 'package:book_demo/team_page.dart';
import 'package:flutter/material.dart';
import 'package:book_demo/widge_demo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.sports_baseball), label: 'Teams'),
    const BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Profile'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.auto_awesome), label: 'widget'),
  ];

  // 是否登陆
  final bool _isLogin = false;

  final List<Widget> _pages = [
    LoginPage(),
    const TeamPage(),
    const MyHomePage(
      title: 'xxxx',
    ),
    const WidgetDemo()
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
  }

  @override
  Widget build(BuildContext context) {
    return _isLogin
        ? Scaffold(
            body: _pages[_selectIndex],
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: _selectIndex,
                onTap: _navigationBottomBar,
                type: BottomNavigationBarType.fixed,
                items: items),
          )
        : LoginPage();
  }
}
