import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FinalGamePage extends StatefulWidget {
  const FinalGamePage({super.key});

  @override
  State<FinalGamePage> createState() => _FinalGamePageState();
}

class _FinalGamePageState extends State<FinalGamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finals'),
      ),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return Card(
              shadowColor: Colors.grey.withOpacity(0.6),
              margin: EdgeInsets.all(8),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GameCard(),
                    Icon(
                      Icons.compare_arrows_sharp,
                      size: 44,
                    ),
                    GameCard(),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class GameCard extends StatelessWidget {
  const GameCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Column(
        children: [
          Text(
            'LAL',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
          ),
          Text('120'),
          Image.network(
            'https://res.nba.cn/media/img/teams/logos/DEN_logo.png',
            width: 80,
          ),
        ],
      ),
    );
  }
}
