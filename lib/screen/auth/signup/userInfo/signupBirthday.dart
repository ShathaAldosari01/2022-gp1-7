import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
/*colors */
import 'package:gp1_7_2022/config/palette.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignupBirthday extends StatefulWidget {
  const SignupBirthday({Key? key}) : super(key: key);

  @override
  State<SignupBirthday> createState() => _SignupBirthdayState();
}

class _SignupBirthdayState extends State<SignupBirthday> {
  //date
  DateTime birthday =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String _dataFormate = DateFormat.yMMMMd('en_US').format(DateTime.now());
  //date controller
  late TextEditingController _birthdayController;
  //button
  bool isButtonActive = false;
  //form
  final _formKey = GlobalKey<FormState>();
  //database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //user id
  var uid = FirebaseAuth.instance.currentUser!.uid;
  /*user data*/
  var userData = {};

  /* get data method */
  getData() async {
    try {
      if (uid != null) {
        //we have uid
        var userSnap =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (userSnap.data() != null) {
          //we have user data
          userData = userSnap.data()!;

          //use value
          setState(() {
            if (userData['birthday'].toString().isNotEmpty) {
              birthday = userData['birthday'].toDate();
              _dataFormate = DateFormat.yMMMMd('en_US')
                  .format(userData['birthday'].toDate());
              isButtonActive = true;
            }
          });
        } else
          Navigator.of(context).popAndPushNamed('/Signup_Login');
      }
    } catch (e) {
      Alert(
        context: context,
        title: "Invalid input!",
        desc: e.toString(),
      ).show();
    }
  }

  @override
  void initState() {
    super.initState();
    //getting user info
    getData();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Palette.backgroundColor,

      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        foregroundColor: Palette.textColor,
        elevation: 0, //no shadow
        /*back arrow */
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Palette.textColor),
          onPressed: () => Navigator.pushNamed(context, '/name'),
        ),
      ),

      //fix over load error
      resizeToAvoidBottomInset: false,

      /*body*/
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /*first column*/
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /*cake icon */
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: double.infinity,
                          ),
                          ShaderMask(
                            blendMode: BlendMode.srcATop,
                            shaderCallback: (bounds) => LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Palette.buttonColor,
                                  Palette.nameColor,
                                ]).createShader(bounds),
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

                    /*Enter your birthday*/
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      // color: Colors.red,
                      child: Center(
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
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Text(
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
                      key: _formKey,
                      child: Column(children: [
                        Column(
                          children: [
                            /*date*/
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                //Clickable and not editable
                                readOnly: true,

                                //function
                                onChanged: (val) {
                                  /*change the val of date*/
                                  setState(() {
                                    _dataFormate = val;
                                  });
                                },

                                /*value*/
                                validator: (val) {
                                  DateTime timeNow = DateTime.now();
                                  DateTime oldest = new DateTime(
                                      timeNow.year + 100,
                                      timeNow.month,
                                      timeNow.day);
                                  bool isNotoldest = birthday.isBefore(oldest);
                                  DateTime younge = new DateTime(
                                      timeNow.year - 12,
                                      timeNow.month,
                                      timeNow.day);
                                  bool isfuture = birthday.isAfter(younge);
                                  if (val!.isEmpty) {
                                    setState(() {
                                      isButtonActive = false;
                                    });
                                    return "You should enter your birthday to sign up.";
                                  } else if (isNotoldest) {
                                    setState(() {
                                      isButtonActive = false;
                                    });
                                    return "date should not be empty";
                                  } else if (isfuture) {
                                    setState(() {
                                      isButtonActive = false;
                                    });
                                    return "You should be at least 12 years old to sign up.";
                                  }
                                  setState(() {
                                    isButtonActive = true;
                                  });
                                  return null;
                                },

                                //design
                                decoration: InputDecoration(
                                  /*background color*/
                                  fillColor: Palette.lightgrey,
                                  filled: true,

                                  /*hint*/
                                  border: OutlineInputBorder(),
                                  hintText: "$_dataFormate",
                                  hintStyle: TextStyle(
                                      fontSize: 18.0, color: Palette.grey),

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
                              ),
                            ),
                            /*end of date*/
                          ],
                        ),
                      ]),
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
                    gradient: isButtonActive
                        ? LinearGradient(colors: [
                            Palette.buttonColor,
                            Palette.nameColor,
                          ])
                        : LinearGradient(colors: [
                            Palette.buttonDisableColor,
                            Palette.nameDisablColor,
                          ]),
                  ),
                  /*button*/
                  child: ButtonTheme(
                    height: 50.0,
                    minWidth: 350,
                    child: FlatButton(
                      onPressed: isButtonActive
                          ? () async {
                              /*add to database*/
                              try {
                                var uid =
                                    FirebaseAuth.instance.currentUser!.uid;
                                await _firestore
                                    .collection("users")
                                    .doc(uid)
                                    .update({
                                  'birthday': birthday,
                                });

                                /*deactivate the button*/
                                setState(() {
                                  isButtonActive = false;
                                });

                                /*go to sign up page*/
                                Navigator.pushNamed(context, '/signupBirthday');
                              } catch (e) {
                                Alert(
                                  context: context,
                                  title: "Invalid input!",
                                  desc: e.toString(),
                                ).show();
                                print(e);
                              }
                              /*go to sign up page*/
                              Navigator.pushNamed(context, '/signupUsername');
                            }
                          : null,
                      child: Text(
                        'Next',
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
                    key: UniqueKey(),
                    initialDateTime: birthday,
                    backgroundColor: Palette.backgroundColor,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (n) {
                      DateTime timeNow = DateTime.now();
                      DateTime oldest = new DateTime(
                          timeNow.year - 100, timeNow.month, timeNow.day);
                      bool isoldest = birthday.isBefore(oldest);
                      DateTime younge = new DateTime(
                          timeNow.year - 12, timeNow.month, timeNow.day);
                      bool isfuture = birthday.isAfter(younge);

                      setState(() {
                        isButtonActive = !isfuture && !isoldest;
                      });

                      setState(() {
                        birthday = n;
                        _dataFormate = DateFormat.yMMMMd('en_US').format(n);
                      });
                    },
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
