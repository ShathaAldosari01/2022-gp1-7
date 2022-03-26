import 'package:flutter/material.dart';
/*pages */
import 'package:gp1_7_2022/screen/auth/signup/userAuth/signup.dart';
import 'package:gp1_7_2022/screen/auth/Login/login.dart';
/*colors */
import 'package:gp1_7_2022/config/palette.dart';

class Signup_Login extends StatefulWidget {
  const Signup_Login({Key? key}) : super(key: key);

  @override
  _Signup_LoginState createState() => _Signup_LoginState();
}

class _Signup_LoginState extends State<Signup_Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      //fix overload error
      resizeToAvoidBottomInset: false,
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /*add space in front */
          SizedBox(
            height: 40,
          ),
          /*logo*/
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Container(
              // color: Colors.amber,
              child: Center(
                child: Image.asset('assets/logoWithName.png',
                height: 200,
                  width: 300),
              ),
            ),
          ),
          /*شعار*/
          Container(
            margin: EdgeInsets.fromLTRB(0,10,0,30),
            child: Center(
              child:Text(
                "A journey full of adventures",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Palette.link,
                  // fontFamily: 'Anton',
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          /*شعارend */

          /*sign up button*/
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
            alignment: Alignment.center,
            width: double.infinity,
            height: 50.0,
            /*button colors*/
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              gradient: LinearGradient(
                  colors: [
                    Palette.buttonColor,
                    Palette.nameColor,
                  ]
              ),
            ),
            /*button*/
            child: ButtonTheme(
              height: 50.0,
              minWidth: 350,
              child: FlatButton(onPressed: (){
                /*go to sign up page*/
                Navigator.pushNamed(context, '/signup');
              },
                child: Text('Create a new account',
                  style: TextStyle(
                    color: Palette.backgroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          /*end of sign up button */

          /*log in button*/
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10),
            alignment: Alignment.center,
            width: double.infinity,
            height: 50.0,
            /*button*/
            child: ButtonTheme(
              height: 50.0,
              child: FlatButton(onPressed: (){
                /*go to sign up page*/
                Navigator.pushNamed(context, '/login');
              },
                child: Text('Log in',
                  style: TextStyle(
                    color: Palette.buttonColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          /*end of sign up button */


        ],
      ),

    );
  }
}

