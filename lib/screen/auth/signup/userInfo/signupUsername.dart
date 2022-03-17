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

class SignupUsername extends StatefulWidget {
  const SignupUsername({Key? key}) : super(key: key);

  @override
  State<SignupUsername> createState() => _SignupUsernameState();
}

class _SignupUsernameState extends State<SignupUsername> {
  //username
  String username = "";
  late TextEditingController _usernameController ;
  //btn
  bool isButtonActive = false;
  bool isUsername = true;
  String errMsg = "This user name is already exists, try another one.";
  //form
  final _formKey = GlobalKey<FormState>();
  //database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState(){
    super.initState();

    _usernameController = TextEditingController();

    _usernameController.addListener(() {
      final isusernameNotEmpty = _usernameController.text.isNotEmpty ;

      setState(() {
        isButtonActive = isusernameNotEmpty;
      });
    });

  }

  @override
  void dispose(){
    _usernameController.dispose();

    super.dispose();
  }
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Palette.backgroundColor,

      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        elevation: 0,//no shadow
        automaticallyImplyLeading: false,//no arrow
      ),
      //fix overload error
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
                      padding: EdgeInsets.symmetric( vertical: 10),
                      // color: Colors.blue,
                      child:Center(
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
                      child: Column(
                          children:[
                            Column(
                            children: [

                              /*username*/
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  //function
                                  onChanged: (val){
                                    /*change the val of pass*/
                                    setState(() {
                                      username = val;
                                    });
                                  },
                                  /*value*/
                                  validator: (val){
                                    if(val!.isEmpty){
                                      return "username should not be empty";
                                    }else if(
                                    val.contains('&')||
                                        val.contains("#")||
                                        val.contains("*")||
                                        val.contains("!")||
                                        val.contains("%")||
                                        val.contains("~")||
                                        val.contains("`")||
                                        val.contains("@")||
                                        val.contains("^")||
                                        val.contains("(")||
                                        val.contains(")")||
                                        val.contains("+")||
                                        val.contains("=")||
                                        val.contains("{")||
                                        val.contains("[")||
                                        val.contains("}")||
                                        val.contains("]")||
                                        val.contains("|")||
                                        val.contains(":")||
                                        val.contains(";")||
                                        val.contains("<")||
                                        val.contains(">")||
                                        val.contains(",")||
                                        val.contains(".")||
                                        val.contains("?")||
                                        val.contains("\$")
                                    ){
                                      return "Username should not have spatial characteristics but _ or -.";
                                    }else if(!isUsername){
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
                                  gradient: isButtonActive
                                      ? LinearGradient(
                                      colors: [
                                        Palette.buttonColor,
                                        Palette.nameColor,
                                      ]
                                  ):LinearGradient(
                                      colors: [
                                        Palette.buttonDisableColor,
                                        Palette.nameDisablColor,
                                      ]
                                  ),
                                ),
                                /*button*/
                                child: ButtonTheme(
                                  height: 50.0,
                                  minWidth: 350,
                                  child: FlatButton(
                                    onPressed: isButtonActive
                                      ?()async{
                                          /*add to database*/
                                          try {

                                            final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
                                                .collection('users')
                                                .where('username', isEqualTo: username.toLowerCase()).get();
                                                // .get;
                                            final valid = await snapshot.docs.isEmpty;
                                            if (valid) {
                                              // username not exists
                                              var uid =   FirebaseAuth.instance.currentUser!.uid;
                                              print(uid);
                                              await _firestore.collection("users").doc(uid).update({
                                                'username': username.toLowerCase(),
                                              });

                                              /*go to sign up page*/
                                              Navigator.pushNamed(context, '/photo');
                                            }
                                            else {
                                                Alert(
                                                  context: context,
                                                  title: "Something went wrong!" ,
                                                  desc: errMsg,
                                                ).show();
                                                print(errMsg);
                                              }

                                          }catch(e){
                                            Alert(
                                              context: context,
                                              title: "Something went wrong!" ,
                                              desc: e.toString(),

                                            ).show();
                                            print(e);
                                          }

                                      }:null,
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

