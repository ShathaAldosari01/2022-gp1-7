import 'package:flutter/material.dart';
/*pages */
import 'package:gp1_7_2022/screen/signup_login.dart';
import 'package:gp1_7_2022/screen/signup.dart';
import 'package:gp1_7_2022/screen/login.dart';
import 'package:gp1_7_2022/screen/Profile_Page.dart';
void main() {
  runApp(
      MaterialApp(
          initialRoute: "/",
          routes: {
            "/": (context) => Signup_Login(),
            "/signup": (context)=> Signup(),
            '/login':(context)=>Login(),
            '/Profile_Page':(context) => Profile_page(),

          }
      )
  );
}
