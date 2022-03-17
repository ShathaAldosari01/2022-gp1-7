import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
/*pages */
/*colors */
import 'package:gp1_7_2022/config/palette.dart';
import 'package:gp1_7_2022/Widgets/follow_button.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:gp1_7_2022/screen/auth/signup_login.dart';


class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.backgroundColor,

        appBar: AppBar(

          leading: IconButton(
            icon: const Icon(
                Icons.arrow_back, color: Colors.black
            ),
            onPressed: () => Navigator.pushNamed(context, '/'),
          ),
          elevation: 0,
          backgroundColor: Palette.backgroundColor,
        ),

      body:


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
    child: FlatButton(onPressed: (){

     FirebaseAuth.instance.currentUser!.delete();
     Navigator.pushNamed(context, '/');
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

    );
  }
}
