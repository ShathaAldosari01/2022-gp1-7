import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gp1_7_2022/screen/home/addPost/utils.dart';
import 'package:intl/intl.dart';

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gp1_7_2022/config/palette.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../auth/signup/userInfo/photo/storageMethods.dart';
import '../../auth/signup/userInfo/photo/utils.dart';

class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  /*data base */
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /* date */
  DateTime dateTime = DateTime.now();
  var dayfromnow = DateTime.now().add(new Duration(hours: 1));

  /* rating */
  int rating = 0;

  /* visit */
  String visit = "";

  /* button active*/
  List<bool> isButtonActive = [true, false]; // location , rating ,

  /* images */
  String path = "no";
  Uint8List? _Coverimage;

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

  /* visibility */
  List<bool> vis = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  int counter = 0;
  int maxImgs = 15;

  //for steps
  int currentStep = 0;

  @override
  Widget build(BuildContext context) =>
      /* back button on devise */
      WillPopScope(
        onWillPop: () async {
          Navigator.pushNamed(context, '/navigationBar');
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
                    /* make own arrow*/
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Palette.textColor),
                      onPressed: () =>
                          Navigator.pushNamed(context, '/navigationBar'),
                    ),

                    /*title (Add Post)*/
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

                    /*to make title at the center*/
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Icon(Icons.arrow_back,
                          color: Palette.backgroundColor),
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

          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),

            /*so it can scroll*/
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stepper(

                    currentStep: currentStep,
                    onStepTapped: (index){
                     setState(() {
                       currentStep=index;
                     });

                    },
                    steps:
                    [
                      //start of step1
                      Step(
                        isActive: currentStep >= 0 ,
                        title: /*rating title*/

                            Text(
                          "Rate Of Visit",
                          style: TextStyle(
                            color: Palette.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        /*end of rating text*/

                        content: Column(
                          children: [
                            /*rating */
                            RatingBar.builder(
                              minRating: 1,
                              itemSize: 30,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4),
                              itemBuilder: (context, _) =>
                                  Icon(Icons.star, color: Palette.buttonColor),
                              updateOnDrag: true,
                              onRatingUpdate: (rating) => setState(() {
                                this.rating = rating.toInt();
                                isButtonActive[1] = true;
                              }),
                            ),
                            /*end of rating */
                          ],
                        ),
                      ),
                      //end of step1

                      //step 2
                      Step(
                        isActive: currentStep >= 1,
                        title:
                      Text(
                        "Date",
                        style: TextStyle(
                          color: Palette.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ), content:  /*date*/
                      Container(
                        child: TextFormField(
                          onTap: () {
                            Utils.showSheet(context, child: buildDatePicker(),
                                onClicked: () {
                                  setState(() {
                                    visit =
                                        DateFormat.yMMMMd('en_US').format(dateTime);
                                  });
                                  Navigator.pop(context);
                                });
                          },

                          //Clickable and not editable
                          readOnly: true,

                          //design
                          decoration: InputDecoration(
                            /*background color*/
                            fillColor: Palette.lightgrey,
                            filled: true,

                            /*hint*/
                            border: OutlineInputBorder(),
                            hintText: visit.isNotEmpty
                                ? "$visit"
                                : DateFormat.yMMMMd('en_US').format(dateTime),
                            hintStyle:
                            TextStyle(fontSize: 18.0, color: Palette.grey),

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
                      //end of step2


                      //step3
                      Step(
                        isActive: currentStep >= 2,
                        title:   Text(
                        "Title",
                        style: TextStyle(
                          color: Palette.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),


                          content:
                      Column(
                       children: [
                         /* Title */
                         Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Flexible(
                               child: Container(
                                 child: TextFormField(
                                   decoration: const InputDecoration(
                                     /*background color*/
                                     fillColor: Palette.lightgrey,
                                     filled: true,
                                     contentPadding: const EdgeInsets.symmetric(
                                         vertical: 1.0, horizontal: 10),

                                     /*hint*/
                                     border: OutlineInputBorder(),
                                     hintText: "Title Of Post",
                                     hintStyle: TextStyle(
                                       fontSize: 18.0,
                                       color: Palette.grey,
                                       height: 2.0,
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
                             /*end of title*/

                             /*image icon*/
                             Container(
                               margin: EdgeInsets.only(bottom: 8),
                               child: IconButton(
                                   onPressed: selectCoverImage,
                                   icon: Icon(
                                     Icons.image,
                                     color: Palette.buttonColor,
                                     size: 35,
                                   )),
                             ),
                             /*end of image icon*/
                           ],
                         ),
                         /*end of title*/

                        /*cover image*/
                         path != "no"
                             ? Container(
                             height: 150, width: 150, child: Image.network(path))
                             : Text(""),

                       ],

                      ),

                      ),
                      //end step3



                        //step4
                      Step(
                        isActive: currentStep >= 3,
                        title:   Text(
                          "Page1",
                          style: TextStyle(
                            color: Palette.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),


                        content:
                        /*body 1*/
                        Visibility(
                          visible: vis[0],
                          child: Column(
                            children: [
                              Flexible(

                                child: TextFormField(
                                  //for multi line
                                  minLines: 1,
                                  maxLines: 10, // allow user to enter 10 line in textfield
                                  keyboardType: TextInputType.multiline,
                                  decoration: const InputDecoration(
                                    /*background color*/
                                    fillColor: Palette.lightgrey,
                                    filled: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 1.0, horizontal: 10),
                                    border: OutlineInputBorder(),
                                    hintText: "Body Of First Page",
                                    hintStyle:
                                    TextStyle(fontSize: 18.0, color: Palette.grey),

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
                              /*end of body 1*/

                              /*image1*/
                              path1 != "no"
                                  ? Container(
                                  height: 150,
                                  width: 150,
                                  child: Image.network(path1))
                                  : Text(""),
                              TextButton(
                                onPressed: selectImage1,
                                child: Text(
                                  path1 == "no" ? 'Add image' : "Change image",
                                  style: TextStyle(
                                      color: Palette.link,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              /*end og image 1*/
                            ],
                          ),
                        ),

                      )
                      //end step4
                      
                    ],
                  ),






                  /*content 2*/
                  Visibility(
                    visible: vis[1],
                    child: Column(
                      children: [
                        TextFormField(
                          //for multi line
                          minLines: 1,
                          maxLines:
                              10, // allow user to enter 10 line in textfield
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            /*background color*/
                            fillColor: Palette.lightgrey,
                            filled: true,
                            border: OutlineInputBorder(),
                            hintText: "Body Of Second Page",
                            hintStyle:
                                TextStyle(fontSize: 18.0, color: Palette.grey),

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
                                width: 150,
                                child: Image.network(path2))
                            : Text(""),
                        TextButton(
                          onPressed: selectImage2,
                          child: Text(
                            path2 == "no" ? 'Add image2' : "Change image2",
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
                    visible: vis[2],
                    child: Column(
                      children: [
                        TextFormField(
                          //for multi line
                          minLines: 1,
                          maxLines:
                              10, // allow user to enter 10 line in textfield
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            /*background color*/
                            fillColor: Palette.lightgrey,
                            filled: true,
                            border: OutlineInputBorder(),
                            hintText: "Body Of Third Page",
                            hintStyle:
                                TextStyle(fontSize: 18.0, color: Palette.grey),

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
                                width: 150,
                                child: Image.network(path3))
                            : Text(""),
                        TextButton(
                          onPressed: selectImage3,
                          child: Text(
                            path3 == "no" ? 'Add image3' : "Change image3",
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
                    onPressed: () {
                      setState(() {
                        vis[counter] = true;
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

                  /* next button */
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50.0,
                    /* button colors */
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      gradient: isButtonActive[0] && isButtonActive[1]
                          ? LinearGradient(colors: [
                              Palette.buttonColor,
                              Palette.nameColor,
                            ])
                          : LinearGradient(colors: [
                              Palette.buttonDisableColor,
                              Palette.nameDisablColor,
                            ]),
                    ),
                    /* button */
                    child: ButtonTheme(
                      height: 50.0,
                      minWidth: 350,
                      child: FlatButton(
                        onPressed: isButtonActive[0] && isButtonActive[1]
                            ? () {
                                Navigator.pushNamed(context, '/ContentOfPost');
                              }
                            : null,
                        child: Text(
                          'Next',
                          style: TextStyle(
                            color: Palette.backgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  /* end of next button  */
                ],
              ),
            ),
          ),
        ),
      );

  Widget buildDatePicker() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          minimumYear: DateTime.now().year - 4,
          maximumYear: DateTime.now().year,
          maximumDate:
              DateTime(dayfromnow.year, dayfromnow.month, dayfromnow.day),
          initialDateTime:
              DateTime(dateTime.year, dateTime.month, dateTime.day),
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) =>
              setState(() => this.dateTime = dateTime),
        ),
      );

  void selectCoverImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _Coverimage = im;
    });

    /*update to database*/
    try {
      var uid = FirebaseAuth.instance.currentUser!.uid;

      String p = await StorageMethods()
          .uploadImageToStorage("CoverImages", _Coverimage!, false);

      setState(() {
        path = p;
      });
//to do: post id
      await _firestore.collection("posts").doc(uid).set({
        'coverPath': p,
      });
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

  void selectImage1() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image1 = im;
    });

    /*update to database*/
    try {
      var uid = FirebaseAuth.instance.currentUser!.uid;

      String p = await StorageMethods()
          .uploadImageToStorage("image1", _image1!, false);

      setState(() {
        path1 = p;
      });
//to do: post id
      await _firestore.collection("posts").doc(uid).set({
        'Path1': p,
      });
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

  void selectImage2() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image2 = im;
    });

    /*update to database*/
    try {
      var uid = FirebaseAuth.instance.currentUser!.uid;

      String p = await StorageMethods()
          .uploadImageToStorage("image2", _image2!, false);

      setState(() {
        path2 = p;
      });
//to do: post id
      await _firestore.collection("posts").doc(uid).set({
        'Path2': p,
      });
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

  void selectImage3() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image3 = im;
    });

    /*update to database*/
    try {
      var uid = FirebaseAuth.instance.currentUser!.uid;

      String p = await StorageMethods()
          .uploadImageToStorage("image3", _image3!, false);

      setState(() {
        path3 = p;
      });
//to do: post id
      await _firestore.collection("posts").doc(uid).set({
        'Path3': p,
      });
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
}
