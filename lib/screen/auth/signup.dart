import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/*pages */
import 'package:gp1_7_2022/screen/auth/signup_login.dart';
import 'package:gp1_7_2022/screen/auth/signup.dart';
/*colors */
import 'package:gp1_7_2022/config/palette.dart';

class Signup extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,

      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        foregroundColor: Palette.textColor,
        elevation: 0,//no shadow
      ),

      body: Container(
        child: Column(
          
          children: [
            
            /*first column*/
            Expanded(
              child: Container(
                margin:  EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    /*Enter your email*/
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      // color: Colors.red,
                      child:Center(
                        child: Text(
                          "Enter Your Email",
                          style: TextStyle(
                            fontSize: 30,
                            color: Palette.textColor,
                          ),
                        ),
                      ),
                    ),

                    /*enter your email so that you */
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      // color: Colors.blue,
                      child:Center(
                        child: Text(
                          "Enter your email to register in Odyssey.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Palette.grey,
                          ),
                        ),
                      ),
                    ),

                    /*form*/
                    Form(
                        child: Column(
                          children:[ Column(
                            children: [

                              /*email*/
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  //design
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Email address",
                                  ),
                                  //function
                                  onChanged: (val){

                                  },
                                ),
                              ),


                              /*next button*/
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
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
                                    child: Text('Next',
                                      style: TextStyle(
                                        color: Palette.backgroundColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              /*end of next button */

                            ],
                          ),]
                        ),
                    ),
                    /*/form*/
                  ],
                ),
              ),
            ),
            
            
              /*log out?*/
                Column(
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
                            "Already have an account?",
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
                              "Log in ",
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
          ],
        ),
      ),
    );

  }
}