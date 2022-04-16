import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/*pages */
import 'package:gp1_7_2022/screen/auth/signup_login.dart';
import 'package:gp1_7_2022/screen/auth/signup/userAuth/signup.dart';
/*colors */
import 'package:gp1_7_2022/config/palette.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EditBio extends StatefulWidget {
  final uid;
  const EditBio({Key? key, this.uid}) : super(key: key);

  @override
  _EditBioState createState() => _EditBioState();
}

class _EditBioState extends State<EditBio> {
  //bio
  String bio = "";
  late TextEditingController _bioController;
  //database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //button
  bool isButtonActive = false;
  //form
  final _formKey = GlobalKey<FormState>();
  //user id
  var uid = FirebaseAuth.instance.currentUser!.uid;
  /*user data*/
  var userData = {};
  //for key go up
  final focus = FocusNode();

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
            if (userData['bio'].toString().isNotEmpty) {
              bio = userData['bio'].toString();
              _bioController =
                  TextEditingController(text: userData['bio'].toString());
              isButtonActive = true;
            } else
              bio = "";
          });

          _bioController.addListener(() {
            final isbioNotEmpty = _bioController.text.isNotEmpty;

            setState(() {
              isButtonActive = isbioNotEmpty;
            });
          });
        } else
          Navigator.of(context).popAndPushNamed('/Signup_Login');
      }
    } catch (e) {
      Alert(
        context: context,
        title: "Something went wrong!",
        desc: e.toString(),
      ).show();
    }
  }

  @override
  void initState() {
    super.initState();
    //getting user info
    getData();

    //this to know if the user full the bio filed to disabile the button
    _bioController = TextEditingController();
  }

//this method > for controler > for naem
  @override
  void dispose() {
    _bioController.dispose();

    super.dispose();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
        onWillPop: () async{
      Navigator.pushNamed(context, '/editProfile');
      return true;
    },

    child: Scaffold(
      key: _scaffoldKey,
      backgroundColor: Palette.backgroundColor,

      //header
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        elevation: 0, //no shadow
        automaticallyImplyLeading: false, //no arrow

        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(
                  textColor: Palette.textColor,
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed('/editProfile');
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontSize: 18),
                  ),
                  shape:
                      CircleBorder(side: BorderSide(color: Colors.transparent)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Text(
                    "Edit Bio",
                    style: TextStyle(
                      color: Palette.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                FlatButton(
                  textColor: Palette.link,
                  onPressed: userData['bio'].toString().compareTo(bio) != 0
                      ? editBio
                      : null,
                  child: Text(
                    "Save",
                    style: TextStyle(
                        fontSize: 18,
                        color: userData['bio'].toString().compareTo(bio) != 0
                            ? Palette.link
                            : Palette.grey),
                  ),
                  shape:
                      CircleBorder(side: BorderSide(color: Colors.transparent)),
                ),
              ],
            ),
            //line
            Divider(
              height: 1,
            ),
          ],
        ),
      ),

      //fix overload error
      resizeToAvoidBottomInset: false,

      //body
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
                    /*form*/
                    Form(
                      child: Column(children: [
                        Column(
                          children: [
                            /*bio*/
                            Form(
                              key: _formKey,
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  /*to make the keyboard go up */
                                  focusNode: focus,
                                  autofocus: true,

                                  /*go next when submitted*/
                                  onFieldSubmitted: (value) {
                                    if (userData['bio']
                                            .toString()
                                            .compareTo(bio) !=
                                        0) editBio();
                                  },

                                  //function
                                  onChanged: (val) {
                                    /*change the val of pass*/
                                    setState(() {
                                      bio = val;
                                    });
                                  },

                                  /*value*/
                                  validator: (val) {
                                    if (val!.isEmpty) {}
                                    if (val.length > 161) {
                                      return "Create a shorter bio under 160 characters.";
                                    }
                                    if ((val.contains('&') ||
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
                                        val.contains("/"))) {
                                      return "bio should not contain special characters. only '-', '_' and '.'.";
                                    }
                                    return null;
                                  },
                                  /*controller for button enable*/
                                  controller: _bioController,

                                  //design
                                  decoration: InputDecoration(
                                    /*hint*/
                                    hintText: "Bio",
                                    hintStyle: TextStyle(
                                        fontSize: 18.0, color: Palette.grey),
                                  ),
                                ),
                              ),
                            ),
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
    ),
    );
  }

  void editBio() async {
    if (_formKey.currentState!.validate()) {
      /*go to sign up page*/
      Navigator.pushNamed(context, '/editProfile');

      /*add to database*/
      try {
        var uid = FirebaseAuth.instance.currentUser!.uid;
        print(uid);
        await _firestore.collection("users").doc(uid).update({
          'bio': bio,
        });
      } catch (e) {
        Alert(
          context: context,
          title: "Something went wrong!",
          desc: e.toString(),
        ).show();
        print(e);
      }
    }
  }
}
