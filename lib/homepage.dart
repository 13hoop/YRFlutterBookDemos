import 'package:book_demo/LoginPage.dart';
import 'package:book_demo/api_server.dart';
import 'package:book_demo/components/my_banner.dart';
import 'package:book_demo/components/my_empty.dart';
import 'package:book_demo/components/my_webview.dart';
import 'package:book_demo/countDemo.dart';
import 'package:book_demo/models/home_news_model.dart';
import 'package:book_demo/models/local_tools.dart';
import 'package:book_demo/models/utl.dart';
import 'package:book_demo/team_page.dart';
import 'package:flutter/material.dart';
import 'package:book_demo/widge_demo.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.sports_baseball), label: 'Teams'),
    const BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Profile'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.auto_awesome), label: 'widget'),
  ];

  // 是否登陆
  bool _isLogin = false;

  final List<Widget> _pages = [
    NBANewsPage(),
    const TeamPage(),
    const MyHomePage(
      title: 'xxxx',
    ),
    const WidgetDemo()
  ];

  int _selectIndex = 0;
  void _navigationBottomBar(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // _isLogin = Share
    LocalTools.shared.isLogin().then((value) => {_isLogin = value});
  }

  @override
  Widget build(BuildContext context) {
    return _isLogin
        ? Scaffold(
            body: _pages[_selectIndex],
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: _selectIndex,
                onTap: _navigationBottomBar,
                type: BottomNavigationBarType.fixed,
                items: items),
          )
        : LoginPage();
  }
}

class NBANewsPage extends StatefulWidget {
  const NBANewsPage({super.key});

  @override
  State<NBANewsPage> createState() => _NBANewsPageState();
}

class _NBANewsPageState extends State<NBANewsPage> {
  @override
  void initState() {
    super.initState();
    loadBannerData();
    loadHomeData();
  }

  void loadData() {
    loadBannerData();
    loadHomeData();
  }

  void loadHomeData() {
    var page = currPage + 1;
    List<HomeNewsModel> temp = contentList;
    ApiService.queryHomes(page).then((rsp) {
      if (rsp.data is List<HomeNewsModel>) {
        var list = rsp.data;
        temp.addAll(list);
      }
    });

    setState(() {
      contentList = temp;
    });
  }

  void loadBannerData() {
    ApiService.queryNews().then((rsp) {
      bannerList = rsp.data;
      List<String> list = [];
      for (var element in bannerList) {
        list.add(element.thumb);
      }
      // print(' NBANewsPage >> $list');
      setState(() {
        _images = list;
      });
    });
  }

  late List<NewsModel> bannerList = [];
  late List<String> _images = [];
  late List<HomeNewsModel> contentList = [];
  int currPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: _images.length > 0
                ? _buildContent()
                : EmptyPage(onTap: loadData)));
  }

  Widget _buildContent() {
    return Column(
      children: [CustomeBanner(_images), Expanded(child: _buildList())],
    );
  }

  Widget _buildList() {
    return Container(
        decoration: const BoxDecoration(color: Color(0xFF01579B)),
        child: ListView.builder(
            itemCount: contentList.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black26),
                child: GestureDetector(
                  onTap: () {
                    var model = contentList[index];
                    print(' >> clicked: id = ${model.newsId}');
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return WebviewPage(
                          'https://m.china.nba.cn/article/index.htm?articleId=${model.newsId}');
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        FadeInImage.memoryNetwork(
                            width: 100,
                            placeholder: kTransparentImage,
                            image: contentList[index].thumbnailY2X ?? ''),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                children: [
                                  Text(
                                    contentList[index].title ?? '',
                                    maxLines: 2,
                                    style: TextStyle(color: Colors.white70),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                contentList[index].publishTime ?? '----/--/--',
                                style: TextStyle(color: Colors.white30),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
