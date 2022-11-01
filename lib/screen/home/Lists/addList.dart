import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/*colors */
import 'package:gp1_7_2022/config/palette.dart';
import 'package:gp1_7_2022/screen/auth/signup/userInfo/photo/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';



//img
import 'package:image/image.dart' as IMG;
import 'package:uuid/uuid.dart';

import '../../auth/signup/userInfo/photo/storageMethods.dart';
import '../../services/firestore_methods.dart';

class AddList extends StatefulWidget {
  final pid;
  const AddList({Key? key,required this.pid}) : super(key: key);

  @override
  State<AddList> createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
/*add list to db*/
  void addListToDatabase(
      /*user info*/
      String uid,


      /*List info*/
      String CoverPath,
      String Description,
      String ListID,
      String Title,
      bool Access,
      List<String> Tags,
      List<String> postIds,
      List<String> users,



      )async{

    try{
      String res = await FireStoreMethods().uploadList(uid, CoverPath, Description, ListID, Title, Access, Tags, postIds, users);
      if(res== "success"){

        showSnackBar(context, "List has been created successfully!");
      }else{
        showSnackBar(context, res);
      }
    }catch(e){
      showSnackBar(context, e.toString());
    }
  }

  String ListID = const Uuid().v1();

  @override
  void dispose() {
    super.dispose();
    //for disable button
    titleControl.dispose();
  }

  String newCover = "";

  /*title size*/
  double titleSize = 18;


  TextEditingController titleControl = TextEditingController();
  TextEditingController descControl = TextEditingController();
  TextEditingController TagControl = TextEditingController();

  bool change = false;

  List<bool> isButtonActive = [
    false, //title
    false, //private?
  ];

  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  /*height*/
  double devHight = 70;
  double dev = 85;

  String Title = "";
  String Description = "";
  bool Access = true ;
  List <String> Tags =[];
  List <String> users =[];
  String TagsBeforeProcess = "";
  List <String> postIds =[];
  /*screen width*/
  double width = 370;
  double hight = 700;

  /*Radio*/
  int accessRadio = 1;

  //photo
  List<String> paths = ["no"];
  Uint8List? _Cover;
  List<int> sizeImge = [];
  String CoverPath = "";
  /*image looks*/
  List<BoxFit> ImgsLook = [BoxFit.cover];

  //Bool for loading the change path after posting
  List<bool> loading = [false];

  List<bool> checkImgs = [true];

  //photo size
  List<int> imageSize(Uint8List data) {
    Uint8List resizedData = data;
    IMG.Image img = IMG.decodeImage(data)!;
    List<int> size = [ img.width,  img.height];
    return size;
  }

  /*cover image*/
  void selectCoverImage() async {

    Uint8List im= await pickImage(ImageSource.gallery);
    List<int> size = imageSize(im);
    size[1]= (((width-90)/ size[0]) * size[1]).toInt();
    setState(() {
      loading[0]=true;
      _Cover = im;
      sizeImge = size;
      devHight = 159 + (hight*((width-90)/width));
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      /*to do upload in data base*/
      String p = await StorageMethods().uploadImageToStorage("Lists/"+uid+"/"+ListID+"/Cover", _Cover!, true);

      setState(() {
        newCover = p;
        CoverPath =p;
        loading[0]=false;
      });
      print(newCover);
      print(CoverPath);

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
  /*end of cover image*/

  //Boolean for loading the change path after posting
  bool loadingPath = false;

  //for loading image when posting
  bool isLoaded = false ;

  @override
  void initState() {
    super.initState();
    if(widget.pid!=null){
      print(widget.pid);
      postIds.add(widget.pid);
    }

    //screen width
    Future.delayed(Duration.zero, () {
      setState(() {
        width = MediaQuery
            .of(context)
            .size
            .width;
        hight = MediaQuery
            .of(context)
            .size
            .height;
      });
    });
    //title
    titleControl = TextEditingController();
    titleControl.addListener(() {
      final isActiveTitle = titleControl.text.isNotEmpty;
      setState(() {
        this.isButtonActive[2] = isActiveTitle;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded?  Container(
      color: Palette.backgroundColor,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    ):
    WillPopScope(
        onWillPop: () async{
          bool change = false;
          for(var item in isButtonActive){
            if(item){
              change = true;
              break;
            }
          }
          if(change) {
            Alert(
                context: context,
                title: "Are you sure you want to leave this page?",
                desc: "Once you click leave the information that you filled will be gone.",
                buttons: [
                  DialogButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Palette.backgroundColor,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        /*back page*/
                        Navigator.pop(context);
                      },
                      gradient: const LinearGradient(colors: [
                        Palette.grey,
                        Palette.grey,
                      ])),
                  DialogButton(
                      child: const Text(
                        "Leave",
                        style: TextStyle(color: Palette.backgroundColor,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        /*go to home page*/
                        Navigator.pushNamed(context, '/Profile_Page');
                      },
                      gradient: const LinearGradient(colors: [
                        Palette.red,
                        Palette.red,
                      ]))
                ]).show();
          }
          else Navigator.pop(context);
          return false;
        },
        child:Scaffold(
            backgroundColor: Palette.backgroundColor,
            appBar: AppBar(
              //appBar style
              elevation: 0.5,
              backgroundColor: Palette.backgroundColor,
              automaticallyImplyLeading: false, //no arrow,

              title: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /* make own arrow*/
                      IconButton(
                          icon: const Icon(Icons.arrow_back,
                              color: Palette.textColor),
                          onPressed: () {
                            for (var item in isButtonActive) {
                              if (item) {
                                change = true;
                                break;
                              }
                            }
                            if (change)
                              Alert(
                                  context: context,
                                  title:
                                  "Are you sure you want to leave this page?",
                                  desc:
                                  "once you click leave the information that you filled will be gone.",
                                  buttons: [
                                    DialogButton(
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                              color: Palette.backgroundColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          /*go to sign up page*/
                                          Navigator.pop(context);
                                        },
                                        gradient: const LinearGradient(colors: [
                                          Palette.grey,
                                          Palette.grey,
                                        ])),
                                    DialogButton(
                                        child: const Text(
                                          "Leave",
                                          style: TextStyle(
                                              color: Palette.backgroundColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          /*go to home page*/
                                          Navigator.pushNamed(
                                              context, '/Profile_Page');
                                        },
                                        gradient: const LinearGradient(colors: [
                                          Palette.red,
                                          Palette.red,
                                        ]))
                                  ]).show();
                            else
                              Navigator.pushNamed(context, '/Profile_Page');
                          }),

                      /*title (Add Post)*/
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Text(
                          "Create list",
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
                        child:
                        Icon(Icons.arrow_back, color: Palette.backgroundColor),
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

            body: ListView(children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(children: [
                  /* title */
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    /*left*/
                    Column(
                      children: [
                        /*icon*/
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: Palette.grey,
                          child: Icon(
                            Icons.title,
                            color: Palette.backgroundColor,
                            size: 20,
                          ),
                        ),
                        /*end of icon */

                        /*divider*/
                        Container(
                          color: Colors.grey,
                          width: 3,
                          height: dev.toDouble(),
                        )
                        /*end of divider */
                      ],
                    ),
                    /*end left */

                    SizedBox(
                      width: 10,
                    ),

                    /*right*/
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      /*title */
                      Text(
                        "Title *",
                        style: TextStyle(
                          color: Palette.textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: titleSize,
                        ),
                      ),
                      /* end of title */

                      SizedBox(
                        height: 16,
                      ),

                      /* Title */
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Form(
                            key: _formKey,
                            child: Container(
                              width: width - 80,
                              child: TextFormField(
                                //for disable for the done button
                                controller: titleControl,
                                onChanged: (val) {
                                  /*change the val of title*/
                                  setState(() {
                                    Title = val;
                                    isButtonActive[0] = true;
                                  });
                                },

                                /*validation*/
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Title should not be empty";
                                  }
                                  if (val.length >= 35) {
                                    return "Create a shorter title under 36 characters.";
                                  }
                                  if ((val.contains("*") ||
                                      val.contains("\\") ||
                                      val.contains("%") ||
                                      val.contains("~") ||
                                      val.contains("^") ||
                                      val.contains("+") ||
                                      val.contains("=") ||
                                      val.contains("{") ||
                                      val.contains("[") ||
                                      val.contains("}") ||
                                      val.contains("]") ||
                                      val.contains(":") ||
                                      val.contains(";") ||
                                      val.contains("\\") ||
                                      val.contains("<") ||
                                      val.contains(">"))) {
                                    return "Title should not contain symbol. Only ',?!_-&@#.";
                                  }
                                  isButtonActive[0] = true;
                                  return null;
                                },

                                decoration: const InputDecoration(
                                  /*background color*/
                                  fillColor: Palette.lightgrey,
                                  filled: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 1.0, horizontal: 10),

                                  /*hint*/
                                  border: OutlineInputBorder(),
                                  hintText: "Title",
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
                        ],
                      ),
                      /*end of title*/
                    ]),
                  ]),

                  /*desc*/
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*left*/
                      Column(
                        children: [
                          /*icon*/
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: Palette.grey,
                            child: Icon(
                              Icons.description,
                              color: Palette.backgroundColor,
                              size: 20,
                            ),
                          ),
                          /*end of icon */

                          /*divider*/
                          Container(
                            color: Colors.grey,
                            width: 3,
                            height: dev.toDouble(),
                          )
                          /*end of divider */
                        ],
                      ),
                      /*end left */

                      SizedBox(
                        width: 10,
                      ),

                      /*right*/
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /*title */
                          Text(
                            "Description",
                            style: TextStyle(
                              color: Palette.textColor,
                              fontWeight: FontWeight.w500,
                              fontSize: titleSize,
                            ),
                          ),
                          /* end of description */

                          SizedBox(
                            height: 16,
                          ),

                          /* description */
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Form(
                                key: _formKey1,
                                child: Container(
                                  width: width - 80,
                                  child: TextFormField(
                                    //for disable for the done button
                                    controller: descControl,

                                    onChanged: (val) {
                                      /*change the val of title*/
                                      setState(() {
                                        Description = val;
                                      });
                                    },

                                    /*validation*/
                                    validator: (val) {
                                      if (val!.isEmpty &&
                                          (val.contains("*") ||
                                              val.contains("\\") ||
                                              val.contains("%") ||
                                              val.contains("~") ||
                                              val.contains("^") ||
                                              val.contains("+") ||
                                              val.contains("=") ||
                                              val.contains("{") ||
                                              val.contains("[") ||
                                              val.contains("}") ||
                                              val.contains("]") ||
                                              val.contains(":") ||
                                              val.contains(";") ||
                                              val.contains("\\") ||
                                              val.contains("<") ||
                                              val.contains(">"))) {
                                        return "Description should not contain symbol. Only ',?!_-&@#.";
                                      }
                                      return null;
                                    },

                                    decoration: const InputDecoration(
                                      /*background color*/
                                      fillColor: Palette.lightgrey,
                                      filled: true,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 1.0, horizontal: 10),

                                      /*hint*/
                                      border: OutlineInputBorder(),
                                      hintText: "Description",
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
                              /*end of description*/
                            ],
                          ),
                          /*end of Desc*/
                        ],
                      ),
                    ],
                  ),

                  /*tags*/
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*left*/
                      Column(
                        children: [
                          /*icon*/
                          CircleAvatar(
                              radius: 13,
                              backgroundColor: Palette.grey,
                              child: Text("#",
                                  style: TextStyle(
                                    color: Palette.backgroundColor,
                                    fontWeight: FontWeight.bold,
                                  )
                              )
                          ),
                          /*end of icon */

                          /*divider*/
                          Container(
                            color: Colors.grey,
                            width: 3,
                            height: dev.toDouble(),
                          )
                          /*end of divider */
                        ],
                      ),
                      /*end left */

                      SizedBox(
                        width: 10,
                      ),

                      /*right*/
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /*title */
                          Text(
                            "Tags",
                            style: TextStyle(
                              color: Palette.textColor,
                              fontWeight: FontWeight.w500,
                              fontSize: titleSize,
                            ),
                          ),
                          /* end of tags */

                          SizedBox(
                            height: 16,
                          ),

                          /* tags */
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Form(
                                key: _formKey2,
                                child: Container(
                                  width: width - 80,
                                  child: TextFormField(
                                    //for disable for the done button
                                    controller: TagControl,

                                    onChanged: (val) {
                                      /*change the val of title*/
                                      setState(() {
                                        TagsBeforeProcess = val;
                                        Tags = ProcessTags(TagsBeforeProcess);
                                        for(int i = 0 ; i < Tags.length ; i++){
                                          print(Tags[i]);
                                        }
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      /*background color*/
                                      fillColor: Palette.lightgrey,
                                      filled: true,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 1.0, horizontal: 10),

                                      /*hint*/
                                      border: OutlineInputBorder(),
                                      hintText: "Tags",
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



                              /*end of tags*/
                            ],
                          ),
                          /*end of tags*/
                        ],
                      ),
                    ],
                  ),
                  /*end of tags*/

                  /*photo*/
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*left*/
                      Column(
                        children: [
                          /*icon*/
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: Palette.grey,
                            child: Icon(
                              Icons.add_photo_alternate_rounded,
                              color: Palette.backgroundColor,
                              size: 20,
                            ),
                          ),
                          /*end of icon */

                          /*divider*/
                          Container(
                            color: Colors.grey,
                            width: 3,
                            height: devHight.toDouble(),
                          )
                          /*end of divider */
                        ],
                      ),
                      /*end left */

                      SizedBox(
                        width: 10,
                      ),

                      /*right*/
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /*photo */
                          Text(
                            "Cover image",
                            style: TextStyle(
                              color: Palette.textColor,
                              fontWeight: FontWeight.w500,
                              fontSize: titleSize,
                            ),
                          ),
                          /* end of photo */

                          SizedBox(
                            height: 16,
                          ),

                          /* photo */
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              /*add image*/
                              _Cover == null?
                              Container(
                                margin: EdgeInsets.all(3),
                                child:TextButton(
                                    onPressed: selectCoverImage,
                                    child: Text(
                                      "Add image",
                                      style: TextStyle(
                                          color: Palette.link
                                      ),
                                    )
                                ),
                              ):SizedBox(),
                              /*end of add image */


                              SizedBox(
                                height: 4,
                              ),

                              /*cover image*/
                              Visibility(
                                child:
                                _Cover != null
                                    ? Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                      color: Palette.midgrey,
                                      alignment: Alignment.centerLeft,
                                      width: width - 90,
                                      // height: hight*((width-90)/width),
                                      child: checkImgs[0] ?
                                      Image(
                                        image: MemoryImage(_Cover!),
                                        width: width - 90,
                                        height: hight * ((width - 90) / width),
                                        fit: ImgsLook[0],
                                      ) :
                                      Image(
                                        image: MemoryImage(_Cover!),
                                        width: width - 90,
                                      ),
                                    ),

                                    //Delete image
                                    CircleAvatar(
                                      backgroundColor: Palette.red,
                                      radius: 15,
                                      child: IconButton(
                                        //Remove the margin
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          //End of remove margin
                                          onPressed: () {
                                            //remove a image
                                            setState(() {
                                              print(_Cover);
                                              CoverPath = '';
                                              _Cover = null;
                                              devHight = 121 +17;
                                              checkImgs[0] = true;

                                            });
                                          },
                                          icon: Icon(
                                            Icons.clear,
                                            color: Palette.backgroundColor,
                                            size: 25,
                                          )
                                      ),
                                    ),
                                    //end delete image
                                  ],
                                )
                                    : SizedBox(),
                                /*end of cover img*/
                              )
                            ],
                          ),
                          /*end of photo*/
                        ],
                      ),
                    ],
                  ),
                  /*end of photo*/

                  /*privacy*/
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*left*/
                      Column(
                        children: [
                          /*icon*/
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: Palette.grey,
                            child:accessRadio==1?
                            Icon(
                              Icons.public,
                              color: Palette.backgroundColor,
                              size: 20,
                            ):
                            Icon(
                              Icons.lock_outline,
                              color: Palette.backgroundColor,
                              size: 20,
                            ),
                          ),
                          /*end of icon */

                          /*divider*/
                          Container(
                            color: Colors.grey,
                            width: 3,
                            height: dev.toDouble()+100,
                          )
                          /*end of divider */
                        ],
                      ),
                      /*end left */


                      /*right*/
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /*title */
                          Container(
                            margin:EdgeInsets.only(left: 10),
                            child: Text(
                              "Privacy *",
                              style: TextStyle(
                                color: Palette.textColor,
                                fontWeight: FontWeight.w500,
                                fontSize: titleSize,
                              ),
                            ),
                          ),
                          /* end of access */

                          SizedBox(
                            height: 16,
                          ),

                          /* access */
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: width - 80,
                                child: Column(
                                  children: [
                                    RadioListTile(
                                      title:Text("Public"),//Private
                                      subtitle: Text("Choosing the list to be public means that other users are able to search, view and save the list."),
                                      value: 1,
                                      groupValue: accessRadio,
                                      onChanged: (value){
                                        print(value);
                                        setState(() {
                                          accessRadio = 1;
                                          Access = true ;
                                          isButtonActive[1] = true;
                                        });
                                      },
                                    ),

                                    SizedBox(height: 10,),

                                    /*Private*/
                                    RadioListTile<int>(
                                      title:Text("Private"),//Private
                                      subtitle: Text("Choosing the list to be private means that only you are able to view the list."),
                                      value: 0,
                                      groupValue: accessRadio,
                                      onChanged: (value){
                                        print(value);
                                        setState(() {
                                          accessRadio = value!;
                                          Access = false;
                                          isButtonActive[1] = true;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              /*end of access*/
                            ],
                          ),
                          /*end of access*/

                        ],
                      ),
                    ],
                  ),
                  /*end of access*/


                  /* done button */
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50.0,
                    /* button colors */
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      gradient: isButtonActive[0]
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
                      child: TextButton(
                        onPressed:

                        !isButtonActive[0]?(){

                          showSnackBar(context, "You need to write title first!");

                        }:

                            () async {


                          /*make sure of the validation*/
                          if (!_formKey.currentState!.validate()) {

                            return;
                          }
                          if (!_formKey1.currentState!.validate()) {

                            return;
                          }

                          setState(() {

                            isLoaded = true;

                          });

                          bool isDone = true;
                          while(true) {
                            await Future.delayed(const Duration(seconds: 1), () {



                                for (int i = 0; i < loading.length; i++) {
                                  if (loading[i]) {
                                    isDone = false;
                                    print("hi");
                                  }
                                }
                            });
                            if (isDone) {

                              submitList();

                              break;
                            }
                            isDone = true;

                          }

                        },
                        child: Text(
                          'Done',
                          style: TextStyle(
                            color: Palette.backgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  /* end of done button  */
                ]),
              )
            ])));
  }

  submitList() async {

    /*Data preprocessing*/
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var userData = {};
    var userSnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (userSnap.data() != null)
      userData = userSnap.data()!;

    try {
      var uid = FirebaseAuth.instance.currentUser!.uid;
      print(uid);
      await _firestore.collection("users").doc(uid).update({
        'listIds': FieldValue.arrayUnion([ListID]),
      });

      Tags.forEach((tag) async {
        await _firestore.collection("users").doc(uid).update({
          'tags': FieldValue.arrayUnion([tag]),
        });
      });

    } catch (e) {
      Alert(
        context: context,
        title: "Something went wrong!",
        desc: e.toString(),
      ).show();
      print(e);
    }


    /*save list to DB*/
    addListToDatabase(
      /*user info*/
      uid,

      /*List info*/
      newCover,
      Description,
      ListID,
      Title,
      Access,
      Tags,
      postIds,
      users,//user id how save the list

    );
    /*end of create list*/


    /*disable button and clear text field */
    setState(() {


      for (int i = 0; i < isButtonActive.length; i++) {
        isButtonActive[i] = false;
      }
      titleControl.clear();


    });
    /*end of disable button and clear text field */

    print(newCover);
    print(CoverPath);
    print("final");
    /*go home */
    Navigator.pushNamed(context, '/Profile_Page');
  }


}

/*photo*/
List<int> imageSize(Uint8List data) {
  Uint8List resizedData = data;
  IMG.Image img = IMG.decodeImage(data)!;
  List<int> size = [ img.width,  img.height];
  return size;
}

List<String>ProcessTags(String TagsBeforeProcess){

  //process tags
  int numOfTags = 0 ;
  List<String> Tags = [];
  for (int i = 0 ; i < TagsBeforeProcess.length ; i++){

    if(TagsBeforeProcess[i]==("#")) {
      String str = "";
      print("in method");

      while(true) {
        str += TagsBeforeProcess[i++];
        if (i==TagsBeforeProcess.length || TagsBeforeProcess[i] == " ") {
          break;
        }
      }
      print(str);
      Tags.add(str);
      numOfTags++;
    }
  };
  return Tags;
}
