import 'package:flutter/material.dart';
/*pages */
import 'package:gp1_7_2022/screen/signup.dart';
import 'package:gp1_7_2022/screen/login.dart';
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
      appBar: AppBar(
        // title: Text(''),
        backgroundColor: Palette.backgroundColor,
        centerTitle: false,
        elevation: 0.0,
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Image.asset('assets/logoWithName.png'),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            // padding: EdgeInsets.all(25),
            child: ButtonTheme(
              height: 50.0,
              child: RaisedButton(onPressed: (){
                Navigator.pushNamed(context, '/signup');
              },

                child: Text('Create new account',
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25,vertical: 5),
            // padding: EdgeInsets.all(25),
            child: ButtonTheme(
              height: 50.0,
              child: FlatButton(onPressed: (){
                Navigator.pushNamed(context, '/login');
              },

                child: Text('Log in',
                  style: TextStyle(
                    color: Palette.buttonColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                color: Palette.backgroundColor,
              ),
            ),
          ),

        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){},
      //   child: Text("Click me!"),
      // ),
    );
  }
}

