import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:book_demo/models/basketball_models.dart';

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

  // void pushToFinals() {
  //   Navigator.pushNamed(context,  routeName)
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/game');
              },
              icon: Icon(Icons.tv)),
          title: Text('NBA')),
      body: FutureBuilder(
          future: quryTeams(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: dataSource.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: 8, left: 8, right: 8),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[100]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dataSource[index].abbreviation +
                                ' (' +
                                dataSource[index].id.toString() +
                                ')',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black.withAlpha(200)),
                          ),
                          Row(
                            children: [
                              Icon(Icons.assessment),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                dataSource[index].full_name,
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.assistant_photo_outlined),
                              SizedBox(
                                width: 8,
                              ),
                              Text(dataSource[index].city,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                    );
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
