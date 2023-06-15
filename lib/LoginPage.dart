// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:book_demo/api_server.dart';
import 'package:book_demo/components/my_button.dart';
import 'package:book_demo/components/my_textfielf.dart';
import 'package:book_demo/components/my_toast.dart';
import 'package:book_demo/models/local_tools.dart';
import 'package:book_demo/models/utl.dart';
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

    if (nameController.text.length == 0) {
      Toast.show('请输入用户名');
      return;
    }

    if (pwdController.text.length == 0) {
      Toast.show('请输入密码');
      return;
    }

    ApiService.userLogin(url, data).then((value) {
      if (value.code == 0) {
        User user = User.fromJson(value.data);
        // LoggerTools.share(' longin done >> push /home 000 ${user.name}');
        LocalTools.shared.save(user).then((value) {
          // LoggerTools.share(' save done');
          Navigator.of(context).pushNamed('/home');
        });
        // LoggerTools.share(' longin done >> push /home 111 ${user.name}');
      }
    }).catchError((onError) {
      print(' err: $onError');
    });
  }

  String title = '欢迎来到 NBA';

  @override
  Widget build(BuildContext context) {
    print(' -- LoginPage rendering ...');
    return Scaffold(
      backgroundColor: const Color(0xFF01579B),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.network(
                  height: 80,
                  'https://res.nba.cn/resource/mat1/chinanba/images/nbalogo/nba-icon.png?20220224'),
              const SizedBox(
                height: 50,
              ),
              Text(
                title,
                style: const TextStyle(color: Colors.white60, fontSize: 16),
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
                  children: const [
                    Text(
                      '忘记密码? ',
                      style: TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              YRButton(
                onTap: () {
                  _loginUser(context);
                },
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
                        color: Colors.grey[50],
                      ),
                    ),
                    const Text(
                      ' 或者, 其他方式 ',
                      style: TextStyle(color: Colors.white60),
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
