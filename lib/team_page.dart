import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:book_demo/models/basketball_models.dart';
import 'package:transparent_image/transparent_image.dart';

import 'components/my_webview.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPage();
}

class _TeamPage extends State<TeamPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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
    super.build(context);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/game');
              },
              icon: const Icon(Icons.tv)),
          title: const Text('Team')),
      body: FutureBuilder(
          future: quryTeams(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: dataSource.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        var model = dataSource[index];
                        // print(' >> clicked: id = ${model.newsId}');
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return WebviewPage(
                              title: model.name,
                              'https://m.china.nba.cn/${model.name.toLowerCase()}');
                        }));
                      },
                      child: Container(
                        margin:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[100]),
                        child: Row(
                          children: [
                            FadeInImage.memoryNetwork(
                                width: 50,
                                height: 50,
                                placeholder: kTransparentImage,
                                image:
                                    'https://res.nba.cn/media/img/teams/logos/${dataSource[index].abbreviation}_logo.png'),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${dataSource[index].abbreviation} (${dataSource[index].id}) - ${dataSource[index].name} ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black.withAlpha(200)),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.assessment),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      dataSource[index].full_name,
                                      style: const TextStyle(
                                          color: Colors.black54, fontSize: 16),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.assistant_photo_outlined),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(dataSource[index].city,
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
