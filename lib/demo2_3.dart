// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';

class Demo23 extends StatefulWidget {
  const Demo23({Key? key}) : super(key: key);

  @override
  _Demo23State createState() => _Demo23State();
}

class _Demo23State extends State<Demo23> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          TapBoxA(),
          SizedBox(
            width: 8,
          ),
          TapBoxA()
        ],
      ),
    ));
  }
}

class TapBoxA extends StatefulWidget {
  const TapBoxA({super.key});

  @override
  _TapBoxAState createState() => _TapBoxAState();
}

class _TapBoxAState extends State<TapBoxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            color: _active ? Colors.lightGreen[700] : Colors.grey[600]),
        child: Center(
            child: Text(
          _active ? 'Active' : 'Inactive',
          style: TextStyle(fontSize: 32.0, color: Colors.white),
        )),
      ),
    );
  }
}
