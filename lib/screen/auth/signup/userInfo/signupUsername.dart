import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/*colors */
import 'package:gp1_7_2022/config/palette.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignupUsername extends StatefulWidget {
  const SignupUsername({Key? key}) : super(key: key);

  @override
  State<SignupUsername> createState() => _SignupUsernameState();
}

class _SignupUsernameState extends State<SignupUsername> {
  //username
  String username = "";
  late TextEditingController _usernameController;
  //btn
  bool isButtonActive = false;
  bool isUsername = true;
  String errMsg = "This user name is already exists, try another one.";
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
          setState(() {
            if (userData['username'].toString().isNotEmpty) {
              username = userData['username'].toString();
              _usernameController =
                  TextEditingController(text: userData['username'].toString());
              isButtonActive = true;
            } else
              username = "";
          });

          _usernameController.addListener(() {
            final isnameNotEmpty = _usernameController.text.isNotEmpty;

            setState(() {
              isButtonActive = isnameNotEmpty;
            });
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

    _usernameController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();

    super.dispose();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Palette.backgroundColor,

      /*header*/
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,

        //no shadow
        elevation: 0,

        /*back arrow */
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Palette.textColor),
          onPressed: () => Navigator.pushNamed(context, '/signupBirthday'),
        ),
      ),

      //fix overload error
      resizeToAvoidBottomInset: false,

      /*body*/
      body: Container(
        child: Column(
          children: [
            /*first column*/
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /*Enter your email*/
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      // color: Colors.red,
                      child: Center(
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
                      padding: EdgeInsets.symmetric(vertical: 10),
                      // color: Colors.blue,
                      child: Center(
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
                      key: _formKey,
                      child: Column(children: [
                        Column(
                          children: [
                            /*username*/
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                /*go next when submitted*/
                                onFieldSubmitted: (value) {
                                  if (isButtonActive) goQues1Page();
                                },

                                //function
                                onChanged: (val) {
                                  /*change the val of pass*/
                                  setState(() {
                                    username = val;
                                  });
                                },
                                /*value*/
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "username should not be empty";
                                  } else if (val.contains('&') ||
                                      val.contains("#") ||
                                      val.contains("*") ||
                                      val.contains("!") ||
                                      val.contains("%") ||
                                      val.contains("~") ||
                                      val.contains("`") ||
                                      val.contains("@") ||
                                      val.contains("^") ||
                                      val.contains("(") ||
                                      val.contains(")") ||
                                      val.contains("+") ||
                                      val.contains("=") ||
                                      val.contains("{") ||
                                      val.contains("[") ||
                                      val.contains("}") ||
                                      val.contains("]") ||
                                      val.contains("|") ||
                                      val.contains(":") ||
                                      val.contains(";") ||
                                      val.contains("<") ||
                                      val.contains(">") ||
                                      val.contains(",") ||
                                      val.contains("?") ||
                                      val.contains("/") ||
                                      val.contains(" ")) {
                                    return "Username should not have space or spatial characteristics but _ or -.";
                                  } else if (!isUsername) {
                                    return errMsg;
                                  }
                                  return null;
                                },
                                /*controller for button enable*/
                                controller: _usernameController,

                                //design
                                decoration: InputDecoration(
                                  /*background color*/
                                  fillColor: Palette.lightgrey,
                                  filled: true,

                                  /*hint*/
                                  border: OutlineInputBorder(),
                                  hintText: "Username",
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
                            /*end of email*/

                            /*next button*/
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 50.0,
                              /*button colors*/
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
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
                                  onPressed:
                                      isButtonActive ? goQues1Page : null,
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
                          ],
                        ),
                      ]),
                    ),
                    /*/form*/
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  goQues1Page() async {
    if (_formKey.currentState!.validate()) {
      /*add to database*/
      try {
        final QuerySnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .where('username', isEqualTo: username.toLowerCase())
                .get();
        // .get;
        final valid = await snapshot.docs.isEmpty;

        if (valid) {
          // username not exists
          var uid = FirebaseAuth.instance.currentUser!.uid;
          print(uid);
          await _firestore.collection("users").doc(uid).update({
            'username': username.toLowerCase(),
          });

          /*deactivate the button*/
          setState(() {
            isButtonActive = false;
          });

          /*go to sign up page*/
          Navigator.pushNamed(context, '/photo');
        } else if (username.isNotEmpty &&
            username.toLowerCase().compareTo(userData['username'].toString()) ==
                0) {
          /*go to sign up page*/
          Navigator.pushNamed(context, '/photo');
        } else {
          print(snapshot.docs);
          Alert(
            context: context,
            title: "Invalid input!",
            desc: errMsg,
          ).show();
          print(errMsg);
        }
      } catch (e) {
        Alert(
          context: context,
          title: "Invalid input!",
          desc: e.toString(),
        ).show();
        print(e);
      }
    }
  }
}
