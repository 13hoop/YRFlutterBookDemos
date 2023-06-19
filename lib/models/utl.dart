import 'package:flutter/material.dart';

class Rsp {
  int code;
  String msg;
  dynamic data;

  Rsp({required this.code, required this.data, required this.msg});

  factory Rsp.fromJson(Map<String, dynamic> json) {
    var code = json['code'] ?? -1;
    var data = json['data'];
    var msg = code == 0 ? 'success' : 'fail';
    return Rsp(code: code, data: data, msg: msg);
  }
}

class User {
  final String name;
  final int u_id;
  final String? avatar;

  const User(this.avatar, {required this.name, required this.u_id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['avatar'], name: json['name'], u_id: json['u_id']);
  }
}

class UserManeger with ChangeNotifier {}

class NewsModel {
  late int id;
  late String newsId;
  late String editor;
  late String title;
  late String subtitle;
  late String category;
  late String thumb;
  late int atype;
  late String h5;
  late String offTime;
  late int waitTime;
  late String publishTime;

  NewsModel();

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    var model = NewsModel();
    model.id = json['id'];
    model.newsId = json['news_id'];
    model.editor = json['editor'];
    model.title = json['title'];
    model.subtitle = json['subtitle'];
    model.category = json['category'];
    model.thumb = json['thumb'];
    model.atype = json['atype'];
    model.h5 = json['h5'];
    model.offTime = json['off_time'];
    model.waitTime = json['wait_time'];
    model.publishTime = json['publish_time'];
    return model;
  }
}
