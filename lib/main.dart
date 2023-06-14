import 'package:book_demo/LoginPage.dart';
import 'package:book_demo/finals_page.dart';
import 'package:book_demo/homepage.dart';
import 'package:book_demo/demo2_3.dart';
import 'package:book_demo/team_page.dart';
import 'package:flutter/material.dart';

import 'countDemo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        '/count': (context) => MyHomePage(
              title: 'title',
            ),
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/team': (context) => TeamPage(),
        '/game': (context) => FinalGamePage()
      },
      initialRoute: '/login',
    );
  }
}
