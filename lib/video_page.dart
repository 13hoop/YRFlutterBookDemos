import 'package:book_demo/api_server.dart';
import 'package:book_demo/components/my_empty.dart';
import 'package:book_demo/models/player_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ViedeoPage extends StatefulWidget {
  const ViedeoPage({super.key});

  @override
  State<ViedeoPage> createState() => _ViedeoPageState();
}

class _ViedeoPageState extends State<ViedeoPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  List<VideoCategory> _categoryList = [];
  int _currIdx = 0;

  late TabController _controller;

  @override
  bool get wantKeepAlive => true;

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
              setState(() {
                _currIdx = _controller.index;
              });
            });
        }
      }
      loadContent(_currIdx);
    });
  }

  void loadContent(int index) {
    LoggerTools.share(' >> $index');
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
              controller: _controller,
              tabs: _categoryList.map((e) {
                return Tab(text: e.title);
              }).toList(),
            ),
          ),
          body: TabBarView(
              controller: _controller,
              children: _categoryList.map((e) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(e.title, textScaleFactor: 5),
                );
              }).toList()),
        ),
      ),
    );
  }
}
