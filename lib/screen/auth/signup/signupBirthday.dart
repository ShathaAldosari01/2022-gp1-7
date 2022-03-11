import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';//for date
import 'package:intl/intl.dart';
/*extra */
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';

/*pages */
import 'package:gp1_7_2022/screen/auth/signup_login.dart';
import 'package:gp1_7_2022/screen/auth/signup/signup.dart';
/*colors */
import 'package:gp1_7_2022/config/palette.dart';

class SignupBirthday extends StatefulWidget {
  const SignupBirthday({Key? key}) : super(key: key);

  @override
  State<SignupBirthday> createState() => _SignupBirthdayState();
}

class _SignupBirthdayState extends State<SignupBirthday> {
  DateTime now = DateTime.now();
  String _dataFormate = DateFormat.yMMMMd('en_US').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,

      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        foregroundColor: Palette.textColor,
        elevation: 0,//no shadow
        automaticallyImplyLeading: false,//no arrow
      ),
      //fix overloade error
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            /*first column*/
            Expanded(
              child: Container(
                margin:  EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    /*ceke icon */
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: double.infinity,),
                          ShaderMask(
                            blendMode: BlendMode.srcATop,
                            shaderCallback: (bounds)=>
                                LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Palette.buttonColor,
                                      Palette.nameColor,
                                    ]
                                ).createShader(bounds),
                            child: Icon(
                              Icons.cake_outlined,
                              size: 100,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    /*end of the cake icon*/

                    /*Enter your email*/
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      // color: Colors.red,
                      child:Center(
                        child: Text(
                          "Add Your Birthday",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            color: Palette.textColor,
                          ),
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric( vertical: 10),
                      child: Center(
                        child:  Text(
                          "This won't be part of your public profile.",
                          style: new TextStyle(
                            fontSize: 18,
                            color: Palette.textColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),



                    /*form*/
                    Form(
                      child: Column(
                          children:[ Column(
                            children: [

                              /*date*/
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  //Clickable and not editable
                                  readOnly: true,

                                  //design
                                  decoration: InputDecoration(

                                    /*background color*/
                                    fillColor: Palette.lightgrey,
                                    filled: true,

                                    /*hint*/
                                    border: OutlineInputBorder(),
                                    hintText: "$_dataFormate",
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
                              /*end of date*/

                            ],
                          ),]
                      ),
                    ),
                    /*end form*/
                  ],
                ),
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Text(
                    'Use your own birthday.',
                    style: TextStyle(
                      color: Palette.grey,
                    ),
                  ),
                ),

                /*next button*/
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
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
                      Navigator.pushNamed(context, '/signupUsername');
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

                /* Cupertino Date Picker*/
                SizedBox(
                  height: 180,
                  child: CupertinoDatePicker(
                    initialDateTime: now,
                    backgroundColor: Palette.backgroundColor,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (n)=>
                        setState(() {
                          now = n;
                          _dataFormate = DateFormat.yMMMMd('en_US').format(n);
                        }),
                  ),
                )
                /*end date*/

              ],
            ),

          ],
        ),
      ),
    );
  }
}

