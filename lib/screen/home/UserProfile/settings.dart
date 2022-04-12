import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
/*pages */
/*colors */
import 'package:gp1_7_2022/config/palette.dart';
import 'package:gp1_7_2022/screen/auth/signup/userAuth/signupConfirmationCode.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
//database
import 'package:cloud_firestore/cloud_firestore.dart';

class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  //database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //get user id
  var uid = FirebaseAuth.instance.currentUser!.uid;
  User? current = FirebaseAuth.instance.currentUser;
  /*user data*/
  var userData = {};
  DateTime now = DateTime.now();
  DateTime birthday = DateTime.now();
  int adult = 1;

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
          //set img path to path
          setState(() {
            birthday = userData['birthday'].toDate();
            int yearDiff = now.year - birthday.year;
            int monthDiff = now.month - birthday.month;
            int dayDiff = now.day - birthday.day;
            if (yearDiff > 18 ||
                yearDiff == 18 && monthDiff >= 0 && dayDiff >= 0)
              adult = 1;
            else
              adult = 0;
          });

          await _firestore.collection("users").doc(uid).update({
            'isAdult': adult,
            if (adult == 0) "questions.married": 0,
            if (adult == 0) "questions.children": 0
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushNamed(context, '/Profile_Page'),
        ),
        elevation: 0,
        backgroundColor: Palette.backgroundColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*edit questions*/
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //text
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                  child: TextButton(
                      onPressed: () {
                        /*go to sign up page*/
                        if (adult == 1)
                          Navigator.pushNamed(context, '/question1');
                        else
                          Navigator.pushNamed(context, '/gender');
                      },
                      child: Text(
                        "Edit Preferences",
                        style:
                            TextStyle(color: Palette.textColor, fontSize: 18),
                      )),
                ),
              ),

              //icon
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: IconButton(
                    onPressed: () {
                      /*go to sign up page*/
                      if (adult == 1)
                        Navigator.pushNamed(context, '/question1');
                      else
                        Navigator.pushNamed(context, '/gender');
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Palette.textColor,
                      size: 24,
                    )),
              ),
            ],
          ),

          /*line*/
          Divider(
            height: 4,
            color: Palette.grey,
          ),

          /*delete account*/
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
            alignment: Alignment.center,
            width: double.infinity,
            height: 50.0,
            /*button colors*/
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              gradient: LinearGradient(colors: [
                Palette.buttonColor,
                Palette.nameColor,
              ]),
            ),
            /*button*/
            child: ButtonTheme(
              height: 50.0,
              minWidth: 350,
              child: FlatButton(
                onPressed: () {
                  Alert(
                      context: context,
                      title: "Delete is permanent",
                      //change me latter
                      //Your profile, post, video, comments, likes and followers will be permanently deleted.
                      desc: "Your profile will be permanently deleted.",
                      buttons: [
                        DialogButton(
                          color: Palette.grey,
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Palette.backgroundColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        DialogButton(
                          color: Palette.red,
                          child: const Text(
                            "Delete",
                            style: TextStyle(
                                color: Palette.backgroundColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          onPressed: () async {
                            //delete user
                            current!.delete();
                            await FirebaseAuth.instance.signOut();
                            //delete user info in the database
                            var delete = await FirebaseFirestore.instance
                                .collection('users')
                                .doc(uid)
                                .delete();
                            //go to sign up log in page
                            await Navigator.pushNamed(context, '/');
                          },
                        )
                      ]).show();
                },
                child: Text(
                  'Delete account',
                  style: TextStyle(
                    color: Palette.backgroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
