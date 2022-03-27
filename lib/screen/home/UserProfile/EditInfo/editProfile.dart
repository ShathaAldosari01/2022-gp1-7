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
        var userSnap = await FirebaseFirestore.instance.collection('users').doc(
            widget.uid).get();
        if(userSnap.data()!=null) {
          //we have user data
          userData = userSnap.data()!;
          //stop loading
          setState(() {
            path = userData['photoPath'];
            _isloaded = true;
          });

        }else
          Navigator.of(context).popAndPushNamed('/Signup_Login');
      }
    }
    catch(e){
      print(e.toString());
    }

  }

  void selectImage() async{
    Uint8List im= await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;

      String p = await StorageMethods().uploadImageToStorage("profilePics", _image!, false);

      setState(() {
        path =p;
      });

      await _firestore.collection("users").doc(uid).update({
        'photoPath': p,
      });


    }catch(e){
      print(e.toString());
      Alert(
        context: context,
        title: "Invalid input!" ,
        desc: e.toString(),

      ).show();
      print(e);
    }



  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Palette.backgroundColor,

      appBar: AppBar(
        //appBar style
        elevation: 0,
        backgroundColor: Palette.backgroundColor,
        automaticallyImplyLeading: false,//no arrow
        //username
        // centerTitle: true,
        title:Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(
                  textColor: Palette.textColor,
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed('/Profile_Page');
                  },
                  child: Text("Back", style: TextStyle(fontSize: 18),),
                  shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Text(
                    "Edit profile",
                    style: TextStyle(
                      color: Palette.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                FlatButton(
                  textColor: Palette.link,
                  onPressed: () {},
                  child: Text("", style: TextStyle(fontSize: 18, color: Palette.backgroundColor),),
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

      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top:5),
            child: Column(
              children: [
                Column(
                  children: [
                    //user photo
                    _isloaded?
                      userData['photoPath']!="no"?
                      CircleAvatar(
                          backgroundColor: Palette.grey,
                          backgroundImage:NetworkImage(path),
                          radius:45
                      )

                    //user photo
                        :CircleAvatar(
                           backgroundColor: Colors.white ,
                           radius: 45,
                           child:  Icon(
                              Icons.account_circle_sharp,
                              color: Colors.grey,
                              size: 90,
                           ),

                        ): Container(
                            margin:EdgeInsets.all(27),
                            child: CircularProgressIndicator(
                                backgroundColor: Palette.lightgrey,
                                valueColor:
                                AlwaysStoppedAnimation<Color>
                                  (Palette.midgrey),
                              ),
                          ),

                    //end user photo
                    /*change profile photo*/
                    TextButton(
                      onPressed:
                        /*select image */
                        selectImage,
                      child: Text(
                          'Change profile photo',
                        style: TextStyle(
                          color: Palette.link,
                            fontSize: 16,
                            fontWeight: FontWeight.bold

                        ),
                      ),
                    ),
                    //end of change photo

                    /*line*/
                    Divider(
                      height: 5,
                    ),
                  ],
                ),
                Row(
                  // mainAxisAlignment: M,
                  children: [
                    Container(
                      // color: Colors.red,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /*label*/
                          //name
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            child: Text(
                              "Name",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),

                          //username
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            child: Text(
                              "Username",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),

                          //Bio
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            child: Text(
                              "Bio",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /*value*/
                          //name
                          Container(
                            child:  TextButton(
                              onPressed: (){
                                Navigator.of(context).popAndPushNamed('/editName');
                              },
                                      child: _isloaded
                                          ? Text(
                                                  (userData['name'].toString().isNotEmpty)
                                                      ? userData['name']
                                                      : "Name",
                                                  style:
                                                  TextStyle(
                                                    fontSize: 16,
                                                    color:(userData['name'].toString().isNotEmpty)
                                                        ? Palette.textColor
                                                        : Palette.grey,

                                                  )
                                              )
                                          :Container(
                                            width: 100,
                                            child: LinearProgressIndicator(
                                              minHeight:15,
                                              backgroundColor: Palette.lightgrey,
                                              valueColor:
                                              AlwaysStoppedAnimation<Color>
                                                (Palette.midgrey),
                                            ),
                                          ),

                            ),
                          ),

                          /*line*/
                          Divider(
                            height: 4,
                          ),

                          //username
                          Container(
                            alignment: Alignment.centerLeft,
                            child:  TextButton(
                              onPressed: (){
                                Navigator.of(context).popAndPushNamed('/editUsername');
                              },
                              child:_isloaded
                                  ? Text(
                                      (userData['username'].toString().isNotEmpty)
                                          ? userData['username']
                                          : "Username",
                                      style:
                                      TextStyle(
                                        color:(userData['username'].toString().isNotEmpty)
                                            ? Palette.textColor
                                            : Palette.grey,
                                        fontSize: 16,
                                      )
                                  )
                                  :Container(
                                    width: 100,
                                    child: LinearProgressIndicator(
                                      minHeight:15,
                                      backgroundColor: Palette.lightgrey,
                                      valueColor:
                                      AlwaysStoppedAnimation<Color>
                                        (Palette.midgrey),
                                    ),
                                  ),

                            ),
                          ),

                          /*line*/
                          Divider(
                            height: 4,
                          ),

                          //bio
                          Container(

                            child: TextButton(
                              onPressed: (){
                                Navigator.of(context).popAndPushNamed('/editBio');
                              },
                              child: _isloaded
                                  ? Text(
                                      (userData['bio'].toString().isNotEmpty)
                                          ? userData['bio']
                                          : "Bio",
                                      style:
                                        TextStyle(
                                          color:(userData['bio'].toString().isNotEmpty)
                                                  ? Palette.textColor
                                                  : Palette.grey,
                                          fontSize: 16,
                                        )
                                    )
                                  :Container(
                                      width: 100,
                                      child: LinearProgressIndicator(
                                        minHeight:15,
                                        backgroundColor: Palette.lightgrey,
                                        valueColor:
                                        AlwaysStoppedAnimation<Color>
                                          (Palette.midgrey),
                                      ),
                                    ),

                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                  ],
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}
