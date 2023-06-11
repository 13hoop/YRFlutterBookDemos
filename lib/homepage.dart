import 'package:book_demo/countDemo.dart';
import 'package:book_demo/team_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Teams'),
    BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Profile'),
  ];

  List<Widget> _pages = [
    HomePage(),
    TeamPage(),
    MyHomePage(
      title: 'xxxx',
    )
  ];

  int _selectIndex = 0;
  void _navigationBottomBar(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[1],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectIndex,
          onTap: _navigationBottomBar,
          type: BottomNavigationBarType.fixed,
          items: items),
    );
  }
}
