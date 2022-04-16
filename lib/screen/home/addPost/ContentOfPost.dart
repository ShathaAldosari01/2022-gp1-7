import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp1_7_2022/config/palette.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../auth/signup/userInfo/photo/storageMethods.dart';
import '../../auth/signup/userInfo/photo/utils.dart';

class ContentOfPost extends StatefulWidget {
  const ContentOfPost({Key? key}) : super(key: key);

  @override
  State<ContentOfPost> createState() => _ContentOfPostState();
}

class _ContentOfPostState extends State<ContentOfPost> {
  Uint8List? _Coverimage;
  String path = "no";

  String path1 = "no";
  Uint8List? _image1;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                FlatButton(
                  textColor: Palette.textColor,
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed('/addPost');
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(fontSize: 18),
                  ),
                  shape:
                      CircleBorder(side: BorderSide(color: Colors.transparent)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Text(
                    "Add Content",
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
                  child: Text(
                    "Done",
                    style: TextStyle(fontSize: 18, color: Palette.textColor),
                  ),
                  shape:
                      CircleBorder(side: BorderSide(color: Colors.transparent)),
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
      body: Container(
        //so it can scroll
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  /*background color*/
                  fillColor: Palette.lightgrey,
                  filled: true,

                  /*hint*/
                  border: OutlineInputBorder(),
                  hintText: "Title Of Post",
                  hintStyle: TextStyle(fontSize: 18.0, color: Palette.grey),

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

              //cover image
              path != "no"
                  ? Container(
                  height: 150,
                  width:150,
                  color: Colors.grey,
                  child: Image.network(path))
                  : Text(""),
              TextButton(
                onPressed: selectCoverImage,
                child: Text(
                  path=="no"
                      ? 'Add Cover Page Image'
                      : "Change the cover image",
                  style: TextStyle(
                      color: Palette.link,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                //for multi line
                minLines: 1,
                maxLines: 10,  // allow user to enter 10 line in textfield
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  /*background color*/
                  fillColor: Palette.lightgrey,
                  filled: true,
                  border: OutlineInputBorder(),
                  hintText: "Body Of First Page",
                  hintStyle: TextStyle(fontSize: 18.0, color: Palette.grey),

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

              //image1
              path1 != "no"
                  ? Container(

                  height: 150,
                  width:150,
                  color: Colors.grey,
                  child: Image.network(path1))
                  : Text(""),
              TextButton(
                onPressed: selectImage1,
                child: Text(
                  path1=="no"
                      ? 'Add image'
                      : "Change image",
                  style: TextStyle(
                      color: Palette.link,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: (){},
                child: Text(
                  "Add Another Page",
                  style: TextStyle(
                      color: Palette.link,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),




            ],
          ),
        ),
      ),
    );
  }

  void selectCoverImage() async {

      Uint8List im= await pickImage(ImageSource.gallery);
      setState(() {
        _Coverimage = im;
      });

      /*update to database*/
      try {
        var uid =   FirebaseAuth.instance.currentUser!.uid;

        String p = await StorageMethods().uploadImageToStorage("CoverImages", _Coverimage!, false);

        setState(() {
          path =p;
        });
//to do: post id
        await _firestore.collection("posts").doc(uid).set({
          'coverPath': p,
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
  void selectImage1() async {

    Uint8List im= await pickImage(ImageSource.gallery);
    setState(() {
     _image1 = im;
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;

      String p = await StorageMethods().uploadImageToStorage("image1",_image1!, false);

      setState(() {
        path1 =p;
      });
//to do: post id
      await _firestore.collection("posts").doc(uid).set({
        'Path1': p,
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
  }

