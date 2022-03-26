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

class EditName extends StatefulWidget {
  final uid;
  const EditName({Key? key, this.uid}) : super(key: key);

  @override
  _EditNameState createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  //name
  String name="";
  late TextEditingController _nameController ;
  //database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //button
  bool isButtonActive = false;
  //form
  final _formKey = GlobalKey<FormState>();
  //user id
  var uid= FirebaseAuth.instance.currentUser!.uid;
  /*user data*/
  var userData = {};

  /* get data method */
  getData() async {
    try {
      if (uid != null) {
        //we have uid
        var userSnap = await FirebaseFirestore.instance.collection('users').doc(
            uid).get();
        if(userSnap.data()!=null) {
          //we have user data
          userData = userSnap.data()!;
          setState(() {
            if(userData['name'].toString().isNotEmpty){
              name = userData['name'].toString();
              _nameController = TextEditingController(text:userData['name'].toString());
              isButtonActive= true;
            }else name ="";
          });

          _nameController.addListener(() {
            final isnameNotEmpty = _nameController.text.isNotEmpty ;

            setState(() {
              isButtonActive = isnameNotEmpty;
            });
          });

        }else
          Navigator.of(context).popAndPushNamed('/Signup_Login');
      }
    }
    catch(e){
      Alert(
        context: context,
        title: "Something went wrong!",
        desc: e.toString(),
      ).show();
    }

  }

  @override
  void initState(){
    super.initState();
    //getting user info
    getData();

    //this to know if the user full the name filed to disabile the button
    _nameController = TextEditingController();

  }
//this method > for controler > for naem
  @override
  void dispose(){
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
        elevation: 0,//no shadow
        automaticallyImplyLeading: false,//no arrow

        title:Column(
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
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                  shape: CircleBorder(
                      side: BorderSide(
                          color: Colors.transparent
                      )
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Text(
                    "Edit Name",
                    style: TextStyle(
                      color: Palette.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                FlatButton(
                  textColor: Palette.link,
                  onPressed: isButtonActive && userData['name'].toString().compareTo(name)!=0
                      ? () async {
                    /*go to sign up page*/
                    Navigator.pushNamed(context, '/editProfile');

                    /*add to database*/
                    try {

                      var uid =   FirebaseAuth.instance.currentUser!.uid;
                      print(uid);
                      await _firestore.collection("users").doc(uid).update({
                        'name': name,
                      });



                    }catch(e){
                      Alert(
                        context: context,
                        title: "Something went wrong!" ,
                        desc: e.toString(),

                      ).show();
                      print(e);
                    }


                  }:null,
                  child: Text("Save", style: TextStyle(fontSize: 18, color: userData['name'].toString().compareTo(name)!=0?Palette.link:Palette.grey),),
                  shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
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
                margin:  EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    /*form*/
                    Form(
                      child: Column(
                          children:[ Column(
                            children: [

                              /*name*/
                              Form(
                                key: _formKey,
                                child:
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: TextFormField(

                                    //function
                                    onChanged: (val){
                                      /*change the val of pass*/
                                      setState(() {
                                        name = val;
                                      });
                                    },

                                    /*value*/
                                    validator: (val){
                                      if(val!.isEmpty){
                                        return "name should not be empty";
                                      }
                                      return null;
                                    },
                                    /*controller for button enable*/
                                    controller: _nameController,

                                    //design
                                    decoration: InputDecoration(
                                      hintText: "Name",
                                      hintStyle: TextStyle(
                                          fontSize: 18.0,
                                          color: Palette.grey
                                      ),


                                    ),

                                  ),
                                ),
                              ),



                            ],
                          ),]
                      ),
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
}

