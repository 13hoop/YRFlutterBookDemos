import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> dataList = ['我的帖子', '我的问答', '我的分享', '我的关注', '我的粉丝'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF01579B),
      child: SafeArea(child: _buidContent()),
    );
  }

  Widget _buidContent() {
    return Column(
      children: [
        Center(
            child: ClipOval(
                child: Container(
          width: 100,
          height: 100,
          child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image:
                  'https://res.nba.cn/resource/mat1/chinanba/images/nbalogo/nba-icon.png?20220224'),
        ))),
        const SizedBox(
          height: 60,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                    title: Text(
                      dataList[index],
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }
}
