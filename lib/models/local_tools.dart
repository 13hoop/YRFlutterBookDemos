import 'dart:async';
import 'dart:ffi';
import 'package:book_demo/api_server.dart';
import 'package:book_demo/models/utl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalTools {
  static LocalTools shared = LocalTools();

  Future<bool> isLogin() async {
    LoggerTools.share('>> isLogin');
    var rsp = await getUser();
    if (rsp != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    int? val1 = await prefs.getInt('u_id');
    String? val2 = await prefs.getString('name');
    String? val3 = await prefs.getString('avater');

    print(' LocalTools >> get user ${val2}');
    if (val1 != null && val2 != null) {
      int id = val1;
      String name = val2;
      return User(val3, name: val2, u_id: id);
    } else {
      return null;
    }
  }

  Future<void> save(User user) {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setInt('u_id', user.u_id);
    // await prefs.setString('name', user.name);
    // if (user.avatar != null) {
    //   await prefs.setString('avater', user.avatar ?? '');
    // }

    // LoggerTools.share('>> save user 000');
    final completer = Completer<void>();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('u_id', user.u_id);
      prefs.setString('name', user.name);
      if (user.avatar != null) {
        prefs.setString('avater', user.avatar ?? '');
      }
      // LoggerTools.share('>> save user 2222');
      completer.complete(); // 完成操作
    }).catchError((err) {
      completer.completeError(err); // 完成操作并返回错误
    });
    // LoggerTools.share('>> save user 111 ${user.name}');
    return completer.future;
  }

  void remove() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
