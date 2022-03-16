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
  String name="";
  //database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //name
  late TextEditingController _nameController ;
  //
  bool isButtonActive = false;
  //form
  final _formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();

    _nameController = TextEditingController();

    _nameController.addListener(() {
      final isnameNotEmpty = _nameController.text.isNotEmpty ;

      setState(() {
        isButtonActive = isnameNotEmpty;
      });
    });

  }

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

                    /*enter your name*/
                    Container(
                      padding: EdgeInsets.symmetric( vertical: 10),
                      // color: Colors.red,
                      child:Center(
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
                      padding: EdgeInsets.symmetric( vertical: 10),
                      // color: Colors.blue,
                      child:Center(
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
                                    /*controller for button enble*/
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
                              ),



                              /*next button*/
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 50.0,
                                /*button colors*/
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                  gradient: isButtonActive?
                                  LinearGradient(
                                      colors: [
                                        Palette.buttonColor,
                                        Palette.nameColor,
                                      ]
                                  )
                                      : LinearGradient(
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
                                    onPressed:isButtonActive
                                        ? () async {

                                      /*add to database*/
                                      try {

                                        var uid =   FirebaseAuth.instance.currentUser!.uid;
                                        print(uid);
                                        await _firestore.collection("users").doc(uid).update({
                                          'name': name,
                                        });

                                        /*go to sign up page*/
                                        Navigator.pushNamed(context, '/signupBirthday');

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

