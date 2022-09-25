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

class name extends StatefulWidget {
  const name({Key? key}) : super(key: key);

  @override
  State<name> createState() => _nameState();
}

class _nameState extends State<name> {
  //name
  String name = "";
  late TextEditingController _nameController;
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
            if (userData['name'].toString().isNotEmpty) {
              name = userData['name'].toString();
              _nameController =
                  TextEditingController(text: userData['name'].toString());
              isButtonActive = true;
            } else
              name = "";
          });

          _nameController.addListener(() {
            final isnameNotEmpty = _nameController.text.isNotEmpty;

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

    //this to know if the user full the name filed to disabile the button
    _nameController = TextEditingController();
  }

//this method > for controler > for naem
  @override
  void dispose() {
    _nameController.dispose();

    super.dispose();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Palette.backgroundColor,

      //header
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        elevation: 0, //no shadow
        automaticallyImplyLeading: false, //no arrow
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
                    /*enter your name*/
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      // color: Colors.red,
                      child: Center(
                        child: Text(
                          "Enter Your Name",
                          style: TextStyle(
                            fontSize: 30,
                            color: Palette.textColor,
                          ),
                        ),
                      ),
                    ),

                    /*add your name so friends can find you */
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      // color: Colors.blue,
                      child: Center(
                        child: Text(
                          "Add your name so friends can find you.",
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
                      child: Column(children: [
                        Column(
                          children: [
                            /*name*/
                            Form(
                              key: _formKey,
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  /*go next when submitted*/
                                  onFieldSubmitted: (value) {
                                    if (isButtonActive) goBirthPage();
                                  },

                                  //function
                                  onChanged: (val) {
                                    /*change the val of pass*/
                                    setState(() {
                                      name = val;
                                    });
                                  },

                                  /*value*/
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "name should not be empty";
                                    }
                                    if (val.length > 35) {
                                      return "Create a shorter name under 35 characters.";
                                    }
                                    /*name should not be only space*/
                                    int count = 0;
                                    val.runes.forEach((int rune) {
                                      var character=new String.fromCharCode(rune);
                                      if(character.compareTo(" ")!=0){
                                        count++;
                                      };
                                    });
                                    if(count==0){
                                      return "The name should not be only space!";
                                    }
                                    /*end check space*/
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
                                        val.contains('"') ||
                                        val.contains("?") ||
                                        val.contains("/"))) {
                                      return "name should not contain symbol. only '-', '_' and '.'.";
                                    }
                                    return null;
                                  },
                                  /*controller for button enable*/
                                  controller: _nameController,

                                  //design
                                  decoration: InputDecoration(
                                    /*background color*/
                                    fillColor: Palette.lightgrey,
                                    filled: true,

                                    /*hint*/
                                    border: OutlineInputBorder(),
                                    hintText: "Name",
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
                            ),

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
                                child: TextButton(
                                  onPressed:
                                      isButtonActive ? goBirthPage : null,
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

  goBirthPage() async {
    if (_formKey.currentState!.validate()) {
      /*add to database*/
      try {
        var uid = FirebaseAuth.instance.currentUser!.uid;
        print(uid);
        await _firestore.collection("users").doc(uid).update({
          'name': name,
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
    }
  }
}
