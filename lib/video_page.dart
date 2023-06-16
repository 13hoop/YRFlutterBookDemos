import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ViedeoPage extends StatefulWidget {
  const ViedeoPage({super.key});

  @override
  State<ViedeoPage> createState() => _ViedeoPageState();
}

class _ViedeoPageState extends State<ViedeoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }

  Widget _build() {
    return MaterialApp(
      title: 'video',
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('video'),
            bottom: const TabBar(
              tabs: <Tab>[
                Tab(icon: Icon(Icons.mood)),
                Tab(text: 'Text Only'),
                Tab(icon: Icon(Icons.star), text: 'Star'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
