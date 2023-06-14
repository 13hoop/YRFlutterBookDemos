// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:book_demo/models/basketball_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WidgetDemo extends StatefulWidget {
  const WidgetDemo({super.key});

  @override
  State<WidgetDemo> createState() => _WidgetDemoState();
}

class _WidgetDemoState extends State<WidgetDemo> {
  final List<Chip> _tags = [];

  bool _isLoading = true;

  Future quryTeams() async {
    print(' --- start');
    try {
      var respose = await http.get(Uri.https('balldontlie.io', 'api/v1/teams'));
      var json = jsonDecode(respose.body);

      for (var elm in json['data']) {
        final team = Team(
            id: elm['id'],
            name: elm['name'],
            full_name: elm['full_name'],
            city: elm['city'],
            abbreviation: elm['abbreviation']);

        _tags.add(Chip(
          label: Text(team.abbreviation),
          avatar: const Icon(Icons.sports_basketball),
        ));
      }
      print(' --- end ${_tags.length}');

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      // 展示错误
      print(' --- end $e');

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print(' --- init state --');
    quryTeams();
  }

  @override
  Widget build(BuildContext context) {
    print(' rendering ');
    return SafeArea(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: _tags,
            ),
    ));
  }
}
