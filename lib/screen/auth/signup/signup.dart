import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/*pages */
import 'package:gp1_7_2022/screen/auth/signup_login.dart';
import 'package:gp1_7_2022/screen/auth/signup/signup.dart';
/*colors */
import 'package:gp1_7_2022/config/palette.dart';
import 'package:gp1_7_2022/screen/services/auth.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final AuthService _auth = AuthService();

  // text field state
  String email = "",
         password= "";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      padding: EdgeInsets.symmetric( vertical: 10),
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
                                    //change the val of email
                                    setState(() {
                                      email = val;
                                    });
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
                                  child: FlatButton(
                                    onPressed:() async {
                                      print(email);
                                    /*go to sign up page*/
                                    Navigator.pushNamed(context, '/confirmationCode');
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