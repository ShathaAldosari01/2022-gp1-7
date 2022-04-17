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

  String path2 = "no";
  Uint8List? _image2;

  String path3 = "no";
  Uint8List? _image3;

  String path4 = "no";
  Uint8List? _image4;

  String path5 = "no";
  Uint8List? _image5;

  String path6 = "no";
  Uint8List? _image6;

  String path7 = "no";
  Uint8List? _image7;

  String path8 = "no";
  Uint8List? _image8;

  String path9 = "no";
  Uint8List? _image9;

  String path10 = "no";
  Uint8List? _image10;

  String path11 = "no";
  Uint8List? _image11;

  String path12 = "no";
  Uint8List? _image12;

  String path13 = "no";
  Uint8List? _image13;

  String path14 = "no";
  Uint8List? _image14;

  String path15 = "no";
  Uint8List? _image15;


  List<bool> vis = [false, false,false,false,false,false,false,false,false,false,false,false,false,false];
  int  counter = 0;

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
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Palette.textColor),
                  onPressed: () => Navigator.pushNamed(context, '/addPost'),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Text(
                    "Add Post",
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
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
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





       //image2
        Visibility(
          visible: vis[0],
                child: Column(

                  children: [
                    
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
                      hintText: "Body Of Second Page",
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


                //image2
                path2 != "no"
                    ? Container(

                    height: 150,
                    width:150,
                    child: Image.network(path2))
                    : Text(""),
                TextButton(
                  onPressed: selectImage2,
                  child: Text(
                    path2=="no"
                        ? 'Add image2'
                        : "Change image2",
                    style: TextStyle(
                        color: Palette.link,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),

             ],
                
                ),
              ),



            //image 3
              Visibility(
                visible: vis[1],
                child: Column(

                  children: [

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
                        hintText: "Body Of Third Page",
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


                    //image3
                    path3 != "no"
                        ? Container(

                        height: 150,
                        width:150,
                        child: Image.network(path3))
                        : Text(""),
                    TextButton(
                      onPressed: selectImage3,
                      child: Text(
                        path3=="no"
                            ? 'Add image3'
                            : "Change image3",
                        style: TextStyle(
                            color: Palette.link,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                  ],

                ),
              ),



              TextButton(
                onPressed: (){
                  setState(() {
                   vis[counter]=true;
                    counter++;


                  });



                },
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
  void selectImage2() async {

    Uint8List im= await pickImage(ImageSource.gallery);
    setState(() {
      _image2 = im;
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;

      String p = await StorageMethods().uploadImageToStorage("image2",_image2!, false);

      setState(() {
        path2 =p;
      });
//to do: post id
      await _firestore.collection("posts").doc(uid).set({
        'Path2': p,
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
  void selectImage3() async {

    Uint8List im= await pickImage(ImageSource.gallery);
    setState(() {
      _image3 = im;
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;

      String p = await StorageMethods().uploadImageToStorage("image3",_image3!, false);

      setState(() {
        path3 =p;
      });
//to do: post id
      await _firestore.collection("posts").doc(uid).set({
        'Path3': p,
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

