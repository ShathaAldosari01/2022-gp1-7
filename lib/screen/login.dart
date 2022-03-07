import 'package:flutter/material.dart';
import 'package:gp1_7_2022/screen/signup_login.dart';
import 'package:gp1_7_2022/screen/login.dart';
import 'package:gp1_7_2022/screen/Profile_Page.dart';
import 'package:gp1_7_2022/config/palette.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("login"),
      ),
      body:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

      Container(
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        // padding: EdgeInsets.all(25),
        child: ButtonTheme(
          height: 50.0,
          child: RaisedButton(onPressed: (){
            Navigator.of(context).pushNamed('/Profile_Page');
          },

            child: Text('profile page',
              style: TextStyle(
                color: Palette.backgroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            color: Palette.buttonColor,
          ),
        ),
      ),
    ]
    ),
    );
  }
}
