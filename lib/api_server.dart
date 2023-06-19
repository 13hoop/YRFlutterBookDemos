// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:ffi';
import 'package:book_demo/models/local_tools.dart';
import 'package:book_demo/models/utl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:book_demo/models/home_news_model.dart';
import 'package:logger/logger.dart';

import 'models/player_models.dart';

class ApiService {
  static final Dio _dio = Dio();

  // 获取视频列表
  static Future<Rsp> queryVideoList(int category, int page) async {
    _dio.options.baseUrl = 'https://m.china.nba.cn';
    _dio.options.headers = {'Content-Type': 'application/json; charset=UTF-8'};

    LoggerTools.share(' -- [queryVideoList]-->> /news/list ?? ${category}');
    try {
      Response rsp = await _dio.get('/cms/v1/news/list', queryParameters: {
        'column_id': category,
        'page_size': 10,
        'page_no': page
      });

      var origin = Rsp.fromJson(rsp.data);
      if (origin.data is List) {
        var list = origin.data;
        List<HomeNewsModel> temp = [];
        for (var elm in list) {
          if (elm is Map<String, dynamic>) {
            var obj = HomeNewsModel.fromJson(elm);
            temp.add(obj);
          }
        }
        origin.data = temp;
      }

      return origin;
    } catch (e) {
      print('ApiService catch err: $e');
      return Rsp(code: -1, data: e, msg: e.toString());
    }
  }

  // 请求视频分类
  static Future<Rsp> queryVdieoCategory() async {
    _dio.options.baseUrl = 'http://127.0.0.1:5555';
    _dio.options.headers = {'Content-Type': 'application/json; charset=UTF-8'};

    try {
      Response rsp = await _dio.get('/videoCategory');
      LoggerTools.share('/videoCategory ??  ${rsp}');
      var origin = Rsp.fromJson(rsp.data);
      if (origin.data is List) {
        var list = origin.data;
        List<VideoCategory> temp = [];
        for (var elm in list) {
          VideoCategory model = VideoCategory.fromJson(elm);
          temp.add(model);
        }
        origin.data = temp;
      }
      return origin;
    } catch (e) {
      LoggerTools.share('catch err: $e');
      return Rsp(code: -1, data: e, msg: e.toString());
    }
  }

  // 获取球员
  static Future<List<PlayerModels>?> queryPlayers() async {
    _dio.options.baseUrl = 'https://m.china.nba.cn';
    _dio.options.headers = {'Content-Type': 'application/json; charset=UTF-8'};

    try {
      Response rsp = await _dio.get('/stats2/league/playerstats.json',
          queryParameters: {'season': '2022'});

      var list = rsp.data['payload']['players'];

      if (list is List) {
        List<PlayerModels> temp = [];
        for (var elm in list) {
          PlayerModels model = PlayerModels.fromJson(elm);
          temp.add(model);
        }

        return Future.value(temp);
      }

      return Future.value(null);
    } catch (e) {
      LoggerTools.share('catch err: $e');
      return Future.value(null);
    }
  }

  // 退出登录
  static userLogout() {
    LocalTools.shared.remove();
    LoggerTools.share('userLogout');
  }

  // 登陆获取user信息
  static Future<Rsp> userLogin(String url, Object? data) async {
    _dio.options.baseUrl = 'http://127.0.0.1:5555';
    _dio.options.headers = {'Content-Type': 'application/json; charset=UTF-8'};

    try {
      Response rsp = await _dio.post(url, data: data);
      LoggerTools.share(' $rsp');
      return Rsp.fromJson(rsp.data);
    } catch (e) {
      LoggerTools.share('catch err: $e');
      return Rsp(code: -1, data: e, msg: e.toString());
    }
  }

  // 获取新闻
  static Future<Rsp> queryHomes(int page) async {
    _dio.options.baseUrl = 'https://m.china.nba.cn';
    _dio.options.headers = {'Content-Type': 'application/json; charset=UTF-8'};

    try {
      Response rsp = await _dio.get('/cms/v1/news/list',
          queryParameters: {'page_size': 10, 'page_no': page});

      var origin = Rsp.fromJson(rsp.data);
      if (origin.data is List) {
        var list = origin.data;
        List<HomeNewsModel> temp = [];
        for (var elm in list) {
          if (elm is Map<String, dynamic>) {
            var obj = HomeNewsModel.fromJson(elm);
            temp.add(obj);
          }
        }
        origin.data = temp;
        LoggerTools.share('/news/list ?? ${page} ${temp.length}');
      }

      return origin;
    } catch (e) {
      print('ApiService catch err: $e');
      return Rsp(code: -1, data: e, msg: e.toString());
    }
  }

  // 获取新闻
  static Future<Rsp> queryNews() async {
    _dio.options.baseUrl = 'https://m.china.nba.cn';
    _dio.options.headers = {'Content-Type': 'application/json; charset=UTF-8'};

    try {
      Response rsp = await _dio.get('/cms/v1/news/config',
          queryParameters: {'category': 'news_rotation'});
      // print('ApiService queryNews >> $rsp');
      var origin = Rsp.fromJson(rsp.data);

      // print('origin.data is List ?? ${origin.code} - ${origin.msg} - ${origin.data}');
      if (origin.data['news_rotation'] is List) {
        var list = origin.data['news_rotation'];
        List<NewsModel> temp = [];
        for (var elm in list) {
          if (elm is Map<String, dynamic>) {
            var obj = NewsModel.fromJson(elm);
            temp.add(obj);
            print(obj.title);
          }
        }
        origin.data = temp;
      }

      return origin;
    } catch (e) {
      print('ApiService catch err: $e');
      return Rsp(code: -1, data: e, msg: e.toString());
    }
  }

  // 原生 http = post
  static Future<http.Response> post(String url, Map<String, dynamic> data) {
    return http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data));
  }

  // 原生 http = get
  static Future<http.Response> get(String url, Map<String, dynamic> data) {
    return http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
  }
}

class LoggerTools {
  static void share(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (_instance == null) {
      print(' == static instance test: signal ? ');
      Logger instance = Logger(
          printer: PrettyPrinter(
        stackTraceBeginIndex: 1,
        methodCount: 2,
        errorMethodCount: 5,
        lineLength: 50,
        colors: true,
        printEmojis: true,
        printTime: false,
      ));

      _instance = instance;
      instance.log(Level.debug, message);
    }

    var instance = _instance ?? Logger();
    instance.log(Level.debug, message);
  }

  static Logger? _instance;
}
