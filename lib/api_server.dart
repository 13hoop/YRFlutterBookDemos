// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:book_demo/models/utl.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:book_demo/models/home_news_model.dart';

class ApiService {
  static final Dio _dio = Dio();

  // 登陆获取user信息
  static Future<Rsp> userLogin(String url, Object? data) async {
    _dio.options.baseUrl = 'http://127.0.0.1:5555';
    _dio.options.headers = {'Content-Type': 'application/json; charset=UTF-8'};

    try {
      Response rsp = await _dio.post(url, data: data);
      print('ApiService >> $rsp');
      return Rsp.fromJson(rsp.data);
    } catch (e) {
      print('ApiService catch err: $e');
      return Rsp(code: -1, data: e, msg: e.toString());
    }
  }

  static Future<Rsp> queryHomes(int page) async {
    _dio.options.baseUrl = 'https://m.china.nba.cn';
    _dio.options.headers = {'Content-Type': 'application/json; charset=UTF-8'};

    try {
      Response rsp = await _dio.get('/cms/v1/news/list',
          queryParameters: {'page_size': 10, 'page_no': page});
      var origin = Rsp.fromJson(rsp.data);

      print('/news/list ?? ${origin.data}');

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
