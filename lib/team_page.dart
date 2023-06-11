import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPage();
}

class _TeamPage extends State<TeamPage> {
  List<Team> dataSource = [];

  Future quryTeams() async {
    var respose = await http.get(Uri.https('balldontlie.io', 'api/v1/teams'));
    var json = jsonDecode(respose.body);

    for (var elm in json['data']) {
      final team = Team(
          id: elm['id'],
          name: elm['name'],
          full_name: elm['full_name'],
          city: elm['city'],
          abbreviation: elm['abbreviation']);
      dataSource.add(team);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: quryTeams(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: dataSource.length,
                  itemBuilder: (context, index) {
                    return Text(dataSource[index].full_name);
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class Team {
  final int id;
  final String name;
  final String full_name;
  final String city;
  final String abbreviation;

  Team(
      {required this.id,
      required this.name,
      required this.full_name,
      required this.city,
      required this.abbreviation});
}
