import 'package:book_demo/api_server.dart';
import 'package:book_demo/components/my_empty.dart';
import 'package:book_demo/components/my_list.dart';
import 'package:book_demo/models/home_news_model.dart';
import 'package:book_demo/models/player_models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ViedeoPage extends StatefulWidget {
  const ViedeoPage({super.key});

  @override
  State<ViedeoPage> createState() => _ViedeoPageState();
}

class _ViedeoPageState extends State<ViedeoPage>
    with SingleTickerProviderStateMixin {
  List<VideoCategory> _categoryList = [];
  int _currIdx = 0;

  late TabController _controller;

  @override
  void initState() {
    super.initState();

    loadVideoCategory();
  }

  void loadVideoCategory() {
    ApiService.queryVdieoCategory().then((e) {
      if (e.code == 0) {
        if (e.data is List<VideoCategory>) {
          setState(() {
            _categoryList = e.data;
          });
          _controller = TabController(length: _categoryList.length, vsync: this)
            ..addListener(() {
              // 点击tab时或滑动tab回调一次
              if (_controller.indexIsChanging) {
                setState(() {
                  _currIdx = _controller.index;
                  LoggerTools.share(' >> {$_currIdx}');
                });
              }
            });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _categoryList.isNotEmpty
          ? _buildContent()
          : EmptyPage(onTap: () {
              loadVideoCategory();
            }),
    );
  }

  Widget _buildContent() {
    return MaterialApp(
      title: 'video',
      home: DefaultTabController(
        initialIndex: 0,
        length: _categoryList.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('video'),
            bottom: TabBar(
              onTap: (value) {},
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.black38),
              controller: _controller,
              tabs: _categoryList.map((e) {
                return Tab(text: e.title);
              }).toList(),
            ),
          ),
          body: TabBarView(
              controller: _controller,
              children: _categoryList.map((e) {
                return _buildListViewContent();
              }).toList()),
        ),
      ),
    );
  }

  Widget _buildListViewContent() {
    VideoCategory model = _categoryList[_currIdx];
    LoggerTools.share(' loadContent >> ${model.title} -> ${model.category}');
    return YRListView(category: model);

    // return Container(
    //   color: Colors.black12,
    //   alignment: Alignment.center,
    //   child: Text(model.title, textScaleFactor: 2),
    // );
  }

  @override
  void dispose() {
    // 释放资源
    _controller.dispose();
    super.dispose();
  }
}
