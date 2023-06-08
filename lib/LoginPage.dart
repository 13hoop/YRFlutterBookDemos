import 'dart:convert';
import 'dart:js';

import 'package:book_demo/api_server.dart';
import 'package:book_demo/components/my_button.dart';
import 'package:book_demo/components/my_textfielf.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final nameController = TextEditingController();
  final pwdController = TextEditingController();

  LoginPage({super.key});

  _loginUser(BuildContext context) {
    var data = <String, String>{
      'name': nameController.text,
      'pwd': pwdController.text
    };
    var url = '/login';

    // var rsp = ApiService.post(url, data);
    // var user = User.fromJson(rsp as Map<String, dynamic>);

    // try {
    //   final rsp = await ApiService.post(url, data);
    //   if (rsp.statusCode == 200) {
    //     print(jsonDecode(rsp.body));
    //     var user = User.fromJson(jsonDecode(rsp.body));
    //     return user;
    //   } else {
    //     title = '密码或者用户名错误';
    //     return null;
    //   }
    // } catch (e) {
    //   print(e);
    //   return null;
    // }

    // 登录成功， 跳转首页
    Navigator.pushNamed(context, '/');
  }

  String title = '欢迎来到 怪物猎人-曙光!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Icon(
                Icons.cabin,
                size: 100,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                title,
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),
              const SizedBox(
                height: 24,
              ),
              YRTextFiled(
                controller: nameController,
                hintText: '用户名',
                obscureText: false,
              ),
              const SizedBox(
                height: 16,
              ),
              YRTextFiled(
                controller: pwdController,
                hintText: '密码',
                obscureText: true,
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '忘记密码?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              YRButton(
                onTap: _loginUser(context),
              ),
              const SizedBox(
                height: 128,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Text(
                      '或者, 其他方式',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
