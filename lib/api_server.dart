// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final Dio _dio = Dio();

  static Future<Rsp> post(String url, Object? data) async {
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

  static Future<http.Response> post02(String url, Map<String, dynamic> data) {
    return http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data));
  }

  static Future<http.Response> get(String url, Map<String, dynamic> data) {
    return http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
  }
}

class Rsp {
  int code;
  String msg;
  dynamic data;

  Rsp({required this.code, required this.data, required this.msg});

  factory Rsp.fromJson(Map<String, dynamic> json) {
    var code = json['code'] ?? -1;
    var data = json['data'];
    var msg = json['msg'] ?? "fail";
    return Rsp(code: code, data: data, msg: msg);
  }
}

class User {
  final String name;
  final int u_id;
  final String? avatar;

  const User(this.avatar, {required this.name, required this.u_id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User('avatar', name: json['name'], u_id: json['u_id']);
  }
}
