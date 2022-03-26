import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp1_7_2022/screen/auth/signup/userInfo/photo/storageMethods.dart';
import 'package:gp1_7_2022/screen/auth/signup/userInfo/photo/utils.dart';
/*pages */
import 'package:gp1_7_2022/screen/auth/signup_login.dart';
import 'package:gp1_7_2022/screen/auth/signup/userAuth/signup.dart';
/*colors */
import 'package:gp1_7_2022/config/palette.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class Photo extends StatefulWidget {
  Photo({Key? key}) : super(key: key);

  @override
  State<Photo> createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  //database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //form
  final _formKey = GlobalKey<FormState>();
  Uint8List? _image;
  String path = "no";
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
          //set img path to path
          setState(() {
            path = userData['photoPath'].toString();
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

  }

  void selectImage() async{
    Uint8List im= await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });

    /*add to database*/

    try {
      /*go to sign up page*/
      Navigator.pushNamed(context, '/question1');

      var uid =   FirebaseAuth.instance.currentUser!.uid;
      print(uid);

      String p = await StorageMethods().uploadImageToStorage("profilePics", _image!, false);
      setState(() {
        path =p;
      });
      await _firestore.collection("users").doc(uid).update({
        'photoPath': p,
      });


    }catch(e){
      Alert(
        context: context,
        title: "Invalid input!" ,
        desc: e.toString(),

      ).show();
      print(e);
    }



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
                          "Add profile photo",
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
                          "Add a profile photo so your friends know it's you.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Palette.grey,
                          ),
                        ),
                      ),
                    ),

                    /*ceke icon */
                    Stack(
                      children: [
                        /*icon*/
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child:path !="no"?
                            CircleAvatar(
                              radius: 80,
                              backgroundImage: NetworkImage(path),
                              backgroundColor: Palette.lightgrey,
                            )
                                : Icon(
                              Icons.account_circle_sharp,
                              size: 180,
                              color: Palette.icongrey,
                            ),
                          ),
                        ),
                        /*end of the cake icon*/
                        Positioned(
                          bottom: 3,
                          left: 180,
                          child:
                          /*add icon */
                          path =="no"?Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // SizedBox(width: double.infinity,),
                                ShaderMask(
                                  blendMode: BlendMode.srcATop,
                                  shaderCallback: (bounds)=>
                                      LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Palette.buttonColor,
                                            Palette.nameColor,
                                          ]
                                      ).createShader(bounds),
                                  child: Icon(
                                    Icons.add_circle_outline,
                                    size: 80,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ):SizedBox(height: 1,),
                          /*end of the cake icon*/
                        )
                      ],
                    ),



                  ],
                ),
              ),
            ),


            /*log out?*/
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /*form*/
                Form(
                  key: _formKey,
                  child: Column(
                      children:[ Column(
                        children: [

                          /*next button*/
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 0, horizontal:40 ),
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
                                onPressed:
                                /*select image */
                                selectImage,

                                child: Text('Add a photo',
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

                          /*next button*/
                          Container(
                            margin: EdgeInsets.fromLTRB(40, 4, 40, 20),
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 50.0,

                            /*button*/
                            child: ButtonTheme(
                              height: 50.0,
                              minWidth: 350,
                              child: FlatButton(onPressed: () async {

                                /*go to sign up page*/
                                Navigator.pushNamed(context, '/question1');
                              },
                                child: Text('Skip',
                                  style: TextStyle(
                                    color: Palette.buttonColor,
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
            )
            //end of log in?
          ],
        ),
      ),
    );
  }
}
