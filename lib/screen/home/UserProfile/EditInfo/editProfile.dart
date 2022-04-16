import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp1_7_2022/screen/auth/signup/userAuth/signupConfirmationCode.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../config/palette.dart';
import '../../../auth/signup/userInfo/photo/storageMethods.dart';
import '../../../auth/signup/userInfo/photo/utils.dart';
import 'package:flutter/cupertino.dart';

class EditProfile extends StatefulWidget {
  final uid;
  const EditProfile({Key? key, this.uid}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool _isloaded = false;
  //database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  /*photo*/
  Uint8List? _image;
  String path = "no";
  /*user data*/
  var userData = {};

  @override
  void initState() {
    getData();
    super.initState();
  }

  /* get data method */
  getData() async {
    try {
      if (widget.uid != null) {
        //we have uid
        var userSnap = await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.uid)
            .get();
        if (userSnap.data() != null) {
          //we have user data
          userData = userSnap.data()!;
          //stop loading
          setState(() {
            path = userData['photoPath'];
            _isloaded = true;
          });
        } else
          Navigator.of(context).popAndPushNamed('/Signup_Login');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
    Navigator.of(context).popAndPushNamed('/editProfile');
    /*update to database*/
    try {
      var uid = FirebaseAuth.instance.currentUser!.uid;

      String p = await StorageMethods()
          .uploadImageToStorage("profilePics", _image!, false);

      setState(() {
        path = p;
      });

      await _firestore.collection("users").doc(uid).update({
        'photoPath': p,
      });
      Navigator.of(context).popAndPushNamed('/editProfile');
    } catch (e) {
      print(e.toString());
      Alert(
        context: context,
        title: "Invalid input!",
        desc: e.toString(),
      ).show();
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
        onWillPop: () async{
      Navigator.pushNamed(context, '/Profile_Page');
      return true;
    },

    child: Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        //appBar style
        elevation: 0,
        backgroundColor: Palette.backgroundColor,
        automaticallyImplyLeading: false, //no arrow,

        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Palette.textColor),
                  onPressed: () => Navigator.pushNamed(context, '/Profile_Page'),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                      color: Palette.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Icon(Icons.arrow_back, color: Palette.backgroundColor),
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

      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Column(
              children: [
                Column(
                  children: [
                    //user photo
                    _isloaded
                        ? userData['photoPath'] != "no"
                            ? CircleAvatar(
                                backgroundColor: Palette.grey,
                                backgroundImage: NetworkImage(path),
                                radius: 45)

                            //user photo
                            : CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 45,
                                child: Icon(
                                  Icons.account_circle_sharp,
                                  color: Colors.grey,
                                  size: 90,
                                ),
                              )
                        : Container(
                            margin: EdgeInsets.all(27),
                            child: CircularProgressIndicator(
                              backgroundColor: Palette.lightgrey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Palette.midgrey),
                            ),
                          ),

                    //end user photo
                    /*change profile photo*/
                    TextButton(
                      onPressed: () {
                        Alert(
                            context: context,
                            title: "Change profile photo?",
                            buttons: [
                              DialogButton(
                                  child: Text(
                                    "Add",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Palette.backgroundColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  onPressed:
                                      /*select image */
                                      selectImage,
                                  gradient: const LinearGradient(colors: [
                                    Palette.buttonColor,
                                    Palette.nameColor,
                                  ])),
                              DialogButton(
                                  color: Palette.red,
                                  child: Text(
                                    "Remove",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Palette.backgroundColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  onPressed: () {
                                    Alert(
                                        context: context,
                                        title: "Are You Sure.",
                                        //change me latter
                                        //Your profile, post, video, comments, likes and followers will be permanently deleted.
                                        desc:
                                            "Your profile photo will be permanently deleted.",
                                        buttons: [
                                          DialogButton(
                                            color: Palette.grey,
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color:
                                                      Palette.backgroundColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .popAndPushNamed(
                                                      '/editProfile');
                                            },
                                          ),
                                          DialogButton(
                                            color: Palette.red,
                                            child: const Text(
                                              "Remove",
                                              style: TextStyle(
                                                  color:
                                                      Palette.backgroundColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            onPressed: () async {
                                              await _firestore
                                                  .collection("users")
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .update({
                                                'photoPath': 'no',
                                              });
                                              Navigator.of(context)
                                                  .popAndPushNamed(
                                                      '/editProfile');
                                            },
                                          )
                                        ]).show();
                                  })
                            ]).show();
                      },
                      child: Text(
                        'Change profile photo',
                        style: TextStyle(
                            color: Palette.link,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //end of change photo

                    /*line*/
                    Divider(
                      height: 5,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 15, 45, 15),
                          child: Text(
                            "Name",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /*value*/
                              //name
                              Container(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .popAndPushNamed('/editName');
                                  },
                                  child: _isloaded
                                      ? Text(
                                          (userData['name']
                                                  .toString()
                                                  .isNotEmpty)
                                              ? userData['name']
                                              : "Name",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: (userData['name']
                                                    .toString()
                                                    .isNotEmpty)
                                                ? Palette.textColor
                                                : Palette.grey,
                                          ))
                                      : Container(
                                          width: 100,
                                          child: LinearProgressIndicator(
                                            minHeight: 15,
                                            backgroundColor: Palette.lightgrey,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Palette.midgrey),
                                          ),
                                        ),
                                ),
                              ),

                              /*line*/
                              Divider(
                                height: 4,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    //username
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Text(
                            "Username",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /*value*/
                              //username
                              Container(
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .popAndPushNamed('/editUsername');
                                  },
                                  child: _isloaded
                                      ? Text(
                                          (userData['username']
                                                  .toString()
                                                  .isNotEmpty)
                                              ? userData['username']
                                              : "Username",
                                          style: TextStyle(
                                            color: (userData['username']
                                                    .toString()
                                                    .isNotEmpty)
                                                ? Palette.textColor
                                                : Palette.grey,
                                            fontSize: 16,
                                          ))
                                      : Container(
                                          width: 100,
                                          child: LinearProgressIndicator(
                                            minHeight: 15,
                                            backgroundColor: Palette.lightgrey,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Palette.midgrey),
                                          ),
                                        ),
                                ),
                              ),

                              /*line*/
                              Divider(
                                height: 4,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    //Bio
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 15, 67, 15),
                          child: Text(
                            "Bio",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /*value*/
                              //bio
                              Container(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .popAndPushNamed('/editBio');
                                  },
                                  child: _isloaded
                                      ? Text(
                                          (userData['bio']
                                                  .toString()
                                                  .isNotEmpty)
                                              ? userData['bio']
                                              : "Bio",
                                          style: TextStyle(
                                            color: (userData['bio']
                                                    .toString()
                                                    .isNotEmpty)
                                                ? Palette.textColor
                                                : Palette.grey,
                                            fontSize: 16,
                                          ))
                                      : Container(
                                          width: 100,
                                          child: LinearProgressIndicator(
                                            minHeight: 15,
                                            backgroundColor: Palette.lightgrey,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Palette.midgrey),
                                          ),
                                        ),
                                ),
                              ),

                              /*line*/
                              Divider(
                                height: 4,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                )
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}
