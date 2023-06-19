import 'package:book_demo/LoginPage.dart';
import 'package:book_demo/finals_page.dart';
import 'package:book_demo/homepage.dart';
import 'package:book_demo/info_page.dart';
import 'package:book_demo/models/local_tools.dart';
import 'package:book_demo/profile_page.dart';
import 'package:book_demo/team_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'newspage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocalTools>(
        create: (_) {
          return LocalTools.shared;
        },
        child: _buildMaterialApp());
  }

  Widget _buildMaterialApp() {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        // '/count': (context) => MyHomePage(
        //       title: 'title',
        //     ),
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/team': (context) => TeamPage(),
        '/game': (context) => FinalGamePage(),
        '/news': (context) => NBANewsPage(),
        '/profile': (context) => ProfilePage(),
        '/infopage': (context) => ProfileInfoPage(),
      },
      initialRoute: '/home',
    );
  }
}
