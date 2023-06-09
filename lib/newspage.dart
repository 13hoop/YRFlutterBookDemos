import 'package:book_demo/api_server.dart';
import 'package:book_demo/models/home_news_model.dart';
import 'package:book_demo/models/player_models.dart';
import 'package:book_demo/models/utl.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'components/my_banner.dart';
import 'components/my_empty.dart';
import 'components/my_webview.dart';

class NBANewsPage extends StatefulWidget {
  const NBANewsPage({super.key});

  @override
  State<NBANewsPage> createState() => _NBANewsPageState();
}

class _NBANewsPageState extends State<NBANewsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    loadData();
    _setupScrollController();
  }

  void _setupScrollController() {
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        LoggerTools.share(' 触发 上拉刷新');
        loadHomeData();
      }
    });
  }

  void loadData() {
    loadBannerData();
    loadPlayers();
    loadHomeData();
  }

  void loadPlayers() {
    print(' loadPlayers ');
    ApiService.queryPlayers().then((list) {
      setState(() {
        categorys = list ?? [];
      });
    });
  }

  void loadHomeData() {
    var page = currPage + 1;
    List<HomeNewsModel> temp = contentList;
    ApiService.queryHomes(page).then((rsp) {
      if (rsp.data is List<HomeNewsModel>) {
        var list = rsp.data;
        temp.addAll(list);
        currPage += 1;
      }

      setState(() {
        contentList = temp;
      });
    }).catchError((err) {});
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

  // banner列表
  late List<NewsModel> bannerList = [];
  late List<String> _images = [];

  // 球员列表
  late List<PlayerModels> categorys = [];

  // 新闻列表
  late List<HomeNewsModel> contentList = [];
  int currPage = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.exit_to_app_outlined),
              onPressed: () {
                ApiService.userLogout();
              },
            ),
            title: Text('News')),
        body: SafeArea(
            child: _images.isNotEmpty
                ? _buildContent()
                : EmptyPage(onTap: loadData)));
  }

  Widget _buildContent() {
    return RefreshIndicator(
      onRefresh: () async {
        currPage = 0;
        loadHomeData();
      },
      child: Column(
        children: [CustomeBanner(_images), Expanded(child: _buildList())],
      ),
    );
  }

  String getPlayerImgUrl(PlayerModels model) {
    if (model.playerProfile?.playerId != null) {
      String playerId = model.playerProfile?.playerId as String;
      return 'https://res.nba.cn/media/img/players/head/260x190/${playerId}.png';
    }
    return 'https://res.nba.cn/resource/mat1/chinanba/images/nbalogo/nba-icon.png?20220224';
  }

  Widget _buildCategory() {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categorys.map((item) {
            return GestureDetector(
                onTap: () {
                  String code = item.playerProfile?.code ?? '';
                  String name = item.playerProfile?.displayName ?? '';
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return WebviewPage(
                        title: name, 'https://m.china.nba.cn/players/#!/$code');
                  }));
                },
                child: Container(
                    margin: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        ClipOval(
                          child: Container(
                            width: 100,
                            height: 100,
                            // padding: EdgeInsets.all(8),
                            color: Colors.blueGrey,
                            child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: getPlayerImgUrl(item)),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(item.playerProfile?.displayName ?? '--')
                      ],
                    )));
          }).toList(),
        ),
      );
    });
  }

  Widget _buildLoadMoreIndicator() {
    return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: CircularProgressIndicator(),
        ));
  }

  late ScrollController _scrollController;

  Widget _buildList() {
    return Container(
        decoration: const BoxDecoration(color: Color(0xFF01579B)),
        child: contentList.isNotEmpty
            ? ListView.builder(
                controller: _scrollController,
                itemCount: contentList.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildCategory();
                  }

                  // LoggerTools.share('$index ~ ${contentList.length}');
                  if (index == contentList.length) {
                    return _buildLoadMoreIndicator();
                  }

                  return Container(
                    margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black26),
                    child: GestureDetector(
                      onTap: () {
                        var model = contentList[index];
                        // print(' >> clicked: id = ${model.newsId}');
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
                                image: contentList[index].thumbnailY2X ??
                                    'https://res.nba.cn/resource/mat1/chinanba/images/nbalogo/nba-icon.png?20220224'),
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
                                    contentList[index].publishTime ??
                                        '----/--/--',
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
                })
            : EmptyPage(onTap: () {
                loadHomeData();
              }));
  }
}
