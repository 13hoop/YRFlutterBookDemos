import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:transparent_image/transparent_image.dart';

class CustomeBanner extends StatefulWidget {
  final List<String> _images;
  final double height;
  // final ValueChanged<int> onTap;
  final Curve curve;

  const CustomeBanner(
    this._images, {
    this.height = 220,
    // this.onTap,
    this.curve = Curves.linear,
  });

  @override
  State<CustomeBanner> createState() => _CustomeBannerState();
}

class _CustomeBannerState extends State<CustomeBanner> {
  PageController _pageController = PageController();
  int _currIdx = 0;

  // 定时器
  Timer? _timer;
  _initTimer() {
    if (_timer == null) {
      _timer = Timer.periodic(Duration(seconds: 2), (t) {
        _currIdx += 1;
        _pageController.animateToPage(_currIdx,
            duration: Duration(milliseconds: 300), curve: widget.curve);
      });
    }
  }

  /// 点击到图片的时候取消定时任务
  _cancelTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
      _initTimer();
    }
  }

  @override
  void initState() {
    super.initState();
    _currIdx = widget._images.length * 2;
    _pageController = PageController(initialPage: _currIdx);
    _initTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [_buildPageView(), _buildIndactor()],
    );
  }

  // Widget _buildTitle() {
  //   var count = widget._images.length;
  //   return Positioned(
  //       bottom: 16,
  //       child: Text(
  //         '$_currIdx',
  //         style: TextStyle(color: Colors.amber),
  //       ));
  // }

  Widget _buildIndactor() {
    var count = widget._images.length;
    return Positioned(
        bottom: 16,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: widget._images.map((elm) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: ClipOval(
                child: Container(
                  width: 8,
                  height: 8,
                  color: elm == widget._images[_currIdx % count]
                      ? Color(0xFF01579B)
                      : Colors.grey,
                ),
              ),
            );
          }).toList(),
        ));
  }

  Widget _buildPageView() {
    var count = widget._images.length;
    return Container(
      height: widget.height,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (idx) {
          setState(() {
            _currIdx = idx;
            if (idx == 0) {
              _currIdx = count;
              _changePage();
            }
          });
        },
        itemBuilder: (context, index) {
          return GestureDetector(
            onPanDown: (d) {
              _cancelTimer();
            },
            onTap: () {},
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: widget._images[index % count],
            ),
          );
        },
      ),
    );
  }

  _changePage() {
    Timer(Duration(milliseconds: 350), () {
      _pageController.jumpToPage(_currIdx);
    });
  }
}
