import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'models/local_tools.dart';
import 'models/utl.dart';

class ProfileInfoPage extends StatefulWidget {
  const ProfileInfoPage({super.key});

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  late User? _user;

  @override
  void initState() {
    super.initState();
    LocalTools.shared.getUser().then((value) {
      setState(() {
        _user = value as User;
        print(' >> exist User: ${value.name} / ${value.avatar}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //1
      body: CustomScrollView(
        slivers: <Widget>[
          //2
          const SliverPersistentHeader(
              pinned: true, delegate: _MySliverAppBar(expamdedHeight: 240)),
          //3
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                return listCardView(title: 'title', desc: 'desc');
              },
              childCount: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Container(
      color: const Color(0xFF01579B),
      child: SafeArea(
          child: Material(
        child: CustomScrollView(
          slivers: [
            const SliverPersistentHeader(
                pinned: true, delegate: _MySliverAppBar(expamdedHeight: 230)),
            SliverList(
                delegate: SliverChildListDelegate([
              const SizedBox(
                height: 16,
              ),
              listCardView(title: '用户名', desc: 'desc'),
              listCardView(title: '性别', desc: 'desc'),
              listCardView(title: '电话', desc: 'desc'),
              listCardView(title: '个人简介', desc: 'desc')
            ]))
          ],
        ),
      )),
    );
  }

  Widget listCardView({required String title, required desc}) {
    return Card(
      // color: Colors.black38,
      margin: const EdgeInsets.all(8.0),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
                fit: FlexFit.tight,
                child: Container(
                  child: Text('$title:'),
                  constraints: BoxConstraints(minHeight: 24),
                )),
            Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Text(
                  desc,
                  style: const TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}

class _MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expamdedHeight;

  const _MySliverAppBar({required this.expamdedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          alignment: Alignment.topLeft,
          decoration: const BoxDecoration(
              // borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(10),
              //     bottomRight: Radius.circular(10)),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color(0xFF01579B),
                Color(0xff8360c3),
              ])),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              )),
        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expamdedHeight,
            child: const Text(
              'profile info',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 23),
            ),
          ),
        ),
        Positioned(
            child: Opacity(
          opacity: (1 - shrinkOffset / expamdedHeight),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: SizedBox(
                    height: MediaQuery.of(context).size.width / 3,
                    width: MediaQuery.of(context).size.width / 3,
                    child: ClipOval(
                        child: SizedBox(
                      width: 100,
                      height: 100,
                      child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image:
                              'https://res.nba.cn/resource/mat1/chinanba/images/nbalogo/nba-icon.png?20220224'),
                    ))),
              ),
            ],
          ),
        ))
      ],
    );
  }

  @override
  double get maxExtent => expamdedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
