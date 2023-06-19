import 'package:book_demo/models/player_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:transparent_image/transparent_image.dart';

import '../api_server.dart';
import '../models/home_news_model.dart';
import 'my_webview.dart';

class YRListView extends StatefulWidget {
  final VideoCategory category;
  const YRListView({super.key, required this.category});

  @override
  State<YRListView> createState() => _YRListViewState();
}

class _YRListViewState extends State<YRListView>
    with AutomaticKeepAliveClientMixin {
  // 新闻列表
  late List<HomeNewsModel> _contentList = [];
  int currPage = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    loadContent();
  }

  void loadContent() {
    var page = currPage + 1;
    List<HomeNewsModel> temp = _contentList;
    LoggerTools.share(
        ' >> ${widget.category.title}-${widget.category.category}');
    ApiService.queryVideoList(widget.category.category, page).then((rsp) {
      if (rsp.data is List<HomeNewsModel>) {
        var list = rsp.data;
        temp.addAll(list);
        currPage += 1;
      }

      setState(() {
        _contentList = temp;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        // controller: _scrollController,
        itemCount: _contentList.length,
        itemBuilder: (context, index) {
          // LoggerTools.share('$index ~ ${contentList.length}');
          if (index == _contentList.length) {
            return _buildLoadMoreIndicator();
          }

          return Container(
            margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.black26),
            child: GestureDetector(
              onTap: () {
                var model = _contentList[index];
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
                        image: _contentList[index].thumbnailY2X ??
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
                                _contentList[index].title ?? '',
                                maxLines: 2,
                                style: TextStyle(color: Colors.white70),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            _contentList[index].publishTime ?? '----/--/--',
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
        });
  }

  Widget _buildLoadMoreIndicator() {
    return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: CircularProgressIndicator(),
        ));
  }
}
