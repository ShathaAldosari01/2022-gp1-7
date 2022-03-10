import 'package:flutter/material.dart';
import 'package:gp1_7_2022/screen/Profile_Page.dart';
/*pages */
import 'package:gp1_7_2022/screen/auth/signup_login.dart';
import 'package:gp1_7_2022/screen/auth/signup/signup.dart';
import 'package:gp1_7_2022/screen/auth/login.dart';
import 'package:gp1_7_2022/screen/auth/signup/signupConfirmationCode.dart';
import 'package:gp1_7_2022/screen/auth/signup/signupPassword.dart';
import 'package:gp1_7_2022/screen/auth/signup/signupBirthday.dart';


void main() {
  runApp(
      MaterialApp(
          initialRoute: "/",
          routes: {
            "/": (context) => Signup_Login(),
            "/signup": (context)=> Signup(),
            '/login':(context)=>Login(),
            '/Profile_Page':(context) => Profile_page(),
            '/confirmationCode':(context) => ConfirmationCode(),
            '/signupPassword':(context) => signupPassword(),
            '/signupBirthday':(context) => SignupBirthday(),



          }
      )
  );
}
