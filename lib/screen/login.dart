import 'package:flutter/material.dart';
import 'package:gp1_7_2022/screen/signup_login.dart';
import 'package:gp1_7_2022/screen/login.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("login"),
      ),
    );
  }
}
