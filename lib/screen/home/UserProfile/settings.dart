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
  //get user id
  var uid = FirebaseAuth.instance.currentUser!.uid;
  User? current = FirebaseAuth.instance.currentUser;

//database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.backgroundColor,

        appBar: AppBar(

          leading: IconButton(
            icon: const Icon(
                Icons.arrow_back, color: Colors.black
            ),
            onPressed: () => Navigator.pushNamed(context, '/Profile_Page'),
          ),
          elevation: 0,
          backgroundColor: Palette.backgroundColor,
        ),

      body: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
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
                      onPressed: (){
                        Navigator.of(context).popAndPushNamed('/question1');
                      },
                      child:Text(
                        "Edit questions",
                        style: TextStyle(
                            color: Palette.textColor,
                            fontSize: 18
                        ),
                      )
                  ),
                ),
              ),

              //icon
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: IconButton(
                      onPressed: (){
                        Navigator.of(context).popAndPushNamed('/question1');
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Palette.textColor,
                        size: 24,
                      )
                  ),
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
            margin: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10),
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
                onPressed: (){
                  Alert(
                      context: context,
                      title: "Delete is permanent" ,
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
                                  fontSize: 18
                              ),
                            ),
                            onPressed: (){
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
                                fontSize: 18
                              ),
                            ),
                          onPressed: () async {
                            //go to sign up log in page
                            Navigator.pushNamed(context, '/Signup_Login');
                            //delete user
                            current!.delete();
                            //delete user info in the database
                            var delete = await FirebaseFirestore.instance.collection('users').doc(uid).delete();
                            await FirebaseAuth.instance.signOut();
                          },

                        )
                      ]
                  ).show();

                    },
                child: Text('delete account',
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
