import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toast {
  static void show(String msg) {
    // 根据msg长度进行简单的时间适配
    double factor = 0.5;
    double flag = msg.length * 0.06 + 0.5;
    int timeInSecForIosWeb = (factor * flag).round();

    // 去掉已有的
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: msg,
        backgroundColor: Colors.black54,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: timeInSecForIosWeb);
  }
}
