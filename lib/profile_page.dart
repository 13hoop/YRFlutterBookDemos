import 'package:book_demo/api_server.dart';
import 'package:book_demo/models/local_tools.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'models/utl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> dataList = ['我的帖子', '我的问答', '我的分享', '我的关注', '我的粉丝'];

  late User _user;
  @override
  void initState() {
    super.initState();
    LocalTools.shared.getUser().then((value) {
      setState(() {
        _user = value as User;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF01579B),
      child: SafeArea(child: _buidContent()),
    );
  }

  Widget _buidContent() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Center(
              child: ClipOval(
                  child: Container(
            width: 100,
            height: 100,
            child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage, image: _user.avatar ?? 'null'),
          ))),
          Center(
            child: Text(_user.name),
          ),
          const SizedBox(
            height: 60,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  primary: false,
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
          ),
          const SizedBox(
            height: 60,
          ),
          Container(
            width: 100,
            child: OutlinedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                onPressed: () {
                  ApiService.userLogout();
                },
                child: Text('退出登陆')),
          )
        ],
      ),
    );
  }
}
