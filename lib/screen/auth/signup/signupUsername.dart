import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/*pages */
import 'package:gp1_7_2022/screen/auth/signup_login.dart';
import 'package:gp1_7_2022/screen/auth/signup/signup.dart';
/*colors */
import 'package:gp1_7_2022/config/palette.dart';

class SignupUsername extends StatelessWidget {
  const SignupUsername({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,

      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        elevation: 0,//no shadow
        automaticallyImplyLeading: false,//no arrow
      ),
      //fix overlode error
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(

          children: [

            /*first column*/
            Expanded(
              child: Container(
                margin:  EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    /*Enter your email*/
                    Container(
                      padding: EdgeInsets.symmetric( vertical: 10),
                      // color: Colors.red,
                      child:Center(
                        child: Text(
                          "Create Username",
                          style: TextStyle(
                            fontSize: 30,
                            color: Palette.textColor,
                          ),
                        ),
                      ),
                    ),

                    /*enter your email so that you */
                    Container(
                      padding: EdgeInsets.symmetric( vertical: 10),
                      // color: Colors.blue,
                      child:Center(
                        child: Text(
                          "Pick a username for your new account.",
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

                                    /*background color*/
                                    fillColor: Palette.lightgrey,
                                    filled: true,

                                    /*hint*/
                                    border: OutlineInputBorder(),
                                    hintText: "Username",
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
                                    Navigator.pushNamed(context, '/Profile_Page');
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
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        //Already have an account?
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                            color: Palette.grey,
                          ),
                        ),
                        //Log in
                        InkWell(
                          child: new Text(
                            'Log In.',
                            style: TextStyle(
                              color: Palette.link,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () => Navigator.pushNamed(context, '/login'),
                        ),


                      ]
                  ),
                )
              ],
            )
            //end of log in?
          ],
        ),
      ),
    );
  }
}

