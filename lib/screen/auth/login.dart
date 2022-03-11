import 'package:flutter/material.dart';
import 'package:gp1_7_2022/screen/auth/signup_login.dart';
import 'package:gp1_7_2022/screen/auth/login.dart';
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
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        foregroundColor: Palette.textColor,
        elevation: 0,//no shadow
        /*back arowe */
        leading: IconButton(
          icon: Icon(
              Icons.arrow_back, color: Palette.textColor
          ),
          onPressed: () => Navigator.pushNamed(context, '/'),
        ),
      ),
      //fix overlode error
      resizeToAvoidBottomInset: false,
      body:Column(
        children:[
          Expanded(
            flex:7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment:MainAxisAlignment.end ,

              children: [
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Center(
                    child:Text(
                      "Odyssey",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 50,
                        color: Palette.link,
                        fontFamily: 'Handlee',
                        letterSpacing: 2,
                      ),
                    ),
                  ),

                ),

                /*email*/
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                  child: TextFormField(
                    //design
                    decoration: InputDecoration(

                      /*background color*/
                      fillColor: Palette.lightgrey,
                      filled: true,

                      /*hint*/
                      border: OutlineInputBorder(),
                      hintText: "Email address",
                      hintStyle: TextStyle(
                          fontSize: 18.0,
                          color: Palette.grey
                      ),

                      /*Border*/
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Palette.midgrey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Palette.midgrey,
                          width: 2.0,
                        ),
                      ),
                    ),

                    //function
                    onChanged: (val){

                    },
                  ),
                ),
                /*end of email*/

                /*Password*/
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                  child: TextFormField(
                    //design
                    decoration: InputDecoration(

                      /*background color*/
                      fillColor: Palette.lightgrey,
                      filled: true,

                      /*hint*/
                      border: OutlineInputBorder(),
                      hintText: "Password",
                      hintStyle: TextStyle(
                          fontSize: 18.0,
                          color: Palette.grey
                      ),

                      /*Border*/
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Palette.midgrey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Palette.midgrey,
                          width: 2.0,
                        ),
                      ),
                    ),
                    obscureText: true,
                    //function
                    onChanged: (val){

                    },
                  ),
                ),
                /*end of email*/

              ],
    ),
          ),
          Expanded(
            flex: 7,

              child:Column(

                children: [

                  Align(
                    alignment: Alignment.topRight,
                    child:
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      child: Text('Forgot password?',
                  style: TextStyle(
                      fontSize: 17,
                    color: Palette.link,
                      fontWeight: FontWeight.bold,
                  ),
                  ),
                    ),
    ),

                /*log in button*/
                  Container(
                    margin: EdgeInsets.symmetric( horizontal:50, vertical: 10),
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
                        /*go to Profile_Page page*/
                        Navigator.of(context).pushNamed('/Profile_Page');
                      },
                        child: Text('Log in',
                          style: TextStyle(
                            color: Palette.backgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  /*end of log in button */
             ],
              ),
          ),
        Expanded(
          flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Divider(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[

                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Palette.grey,
                          ),
                        ),

                        FlatButton(
                          // color: Colors.red,
                          padding: EdgeInsets.fromLTRB(0, 0,30, 0),
                          onPressed: (){
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                            "  Sign up. ",
                            style: TextStyle(
                              color: Palette.link,
                            ),
                          ),
                        ),

                      ]
                  ),
                )
              ],

            )
        )
      ],
      ),
    );
  }
}
