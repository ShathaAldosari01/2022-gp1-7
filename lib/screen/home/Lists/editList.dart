//EditList
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../config/palette.dart';
import '../../auth/signup/userInfo/photo/storageMethods.dart';
import '../../auth/signup/userInfo/photo/utils.dart';
import '../../services/firestore_methods.dart';
import 'addList.dart';
import 'listCountent.dart';

class EditList extends StatefulWidget {
  final listData;
  const EditList({Key? key, required this.listData}) : super(key: key);

  @override
  State<EditList> createState() => _EditListState();
}

class _EditListState extends State<EditList> {

  @override
  void initState() {
    //check the value inside the data if null or not
    if (widget.listData != null) {
      setState(() {
        CoverPath = widget.listData["Cover"];
        ListID = widget.listData["ListID"];
      });
      //append value to title
      if (widget.listData["Title"].toString().isNotEmpty) {
        setState(() {
          _titleController =
              TextEditingController(text: widget.listData["Title"].toString());
          title = widget.listData["Title"].toString();
        });
      }
//append value to description
      if (widget.listData["Description"] != null && widget.listData["Description"].toString().isNotEmpty) {
        setState(() {
          _descriptionController = TextEditingController(
              text: widget.listData["Description"].toString());
          description = widget.listData["Description"].toString();
        });

        _descriptionController.addListener(() {
          final isdescriptionNotEmpty = _descriptionController.text.isNotEmpty;

          setState(() {
            isButtonActive = isdescriptionNotEmpty;
          });
        });
      } else
        _descriptionController = TextEditingController();
    }

    //append value to tags
    if (widget.listData["Tags"] != null && widget.listData["Tags"].isNotEmpty) {
      print("Shatha");
      String tagsString = "";
      for (var t in widget.listData["Tags"]) {
        tagsString += t + " ";
      }

      setState(() {
        _tagsController = TextEditingController(text: tagsString);
        tags = tagsString;
        listOfTags = widget.listData["Tags"];
        _isloaded = true;
      });

      _tagsController.addListener(() {
        final istagsNotEmpty = _tagsController.text.isNotEmpty;

        setState(() {
          isButtonActive = istagsNotEmpty;
        });
      });
    } else {
      _tagsController = TextEditingController();
      setState(() {
        _isloaded = true;
      });
    }


    //append value to privacy
    if (widget.listData["Access"].toString().isNotEmpty) {
      bool privacy = widget.listData["Access"];
      if (privacy)
        setState(() {
          _privacyController = TextEditingController(text: "Public");
        });
      else
        setState(() {
          _privacyController = TextEditingController(text: "Private");
        });
      setState(() {
        access = privacy;
      });

      _privacyController.addListener(() {
        final isprivacyNotEmpty = _privacyController.text.isNotEmpty;

        setState(() {
          isButtonActive = isprivacyNotEmpty;
        });
      });
    } else
      _privacyController = TextEditingController();

    _titleController.addListener(() {
      final istitleNotEmpty = _titleController.text.isNotEmpty;

      setState(() {
        isButtonActive = istitleNotEmpty;
      });
    });
    if (_isloaded) {
      _titleController =
          TextEditingController(text: widget.listData["Title"].toString());
      title = widget.listData["Title"].toString();
    } else
      _titleController = TextEditingController();

    super.initState();
  }

  //attributes
  bool _isloaded = false;
  Uint8List? _image;
  String path = "";
  //database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool loading = false;
  Uint8List? _Cover;
  String CoverPath = "";
  String ListID = "";
  final _titleKey = GlobalKey<FormState>();
  String title = "";
  final _descriptionKey = GlobalKey<FormState>();
  String description = "";
  final _tagsKey = GlobalKey<FormState>();
  String tags = "";
  List<dynamic> listOfTags = [];
  final _privacyKey = GlobalKey<FormState>();
  bool access = false;
  bool isTitleChanged = false;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _tagsController;
  late TextEditingController _privacyController;
  bool isButtonActive = false;
  List <bool> isContentChanged = [false, false, false, false, false];
  bool loadingWhenUpdated = false;
  bool loadingImg = false;

  @override
  Widget build(BuildContext context) {
    /*size of screen*/
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if(isContentChanged[0] || isContentChanged[1] || isContentChanged[2] || isContentChanged[3] || isContentChanged[4]) {
          Alert(
              context: context,
              title: "Are you sure you want to leave this page?",
              desc: "once you click leave the information that you filled will not be updated.",
              buttons: [
                DialogButton(
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Palette.backgroundColor,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      /*go back*/
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
                      Navigator.pushNamed(context, '/Profile_Page');
                    },
                    gradient: const LinearGradient(colors: [
                      Palette.red,
                      Palette.red,
                    ]))
              ]).show();
        }
        else
          Navigator.pop(context);
        return false;
      },


      child: loadingWhenUpdated || loadingImg? Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.backgroundColor,
          elevation: 0,
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.all(32),
            child: CircularProgressIndicator(
              backgroundColor: Palette.lightgrey,
              valueColor: AlwaysStoppedAnimation<Color>(Palette.midgrey),
            ),
          ),
        ),
      ): Scaffold(
        appBar: AppBar(
          //appBar style
          elevation: 0.5,
          backgroundColor: Palette.backgroundColor,
          automaticallyImplyLeading: false, //no arrow,

          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /* make own arrow*/
              IconButton(
                  icon: const Icon(Icons.arrow_back, color: Palette.textColor),
                  onPressed: () {
                    /*back page*/
                    if(isContentChanged[0] || isContentChanged[1] || isContentChanged[2] || isContentChanged[3] || isContentChanged[4]) {
                      Alert(
                          context: context,
                          title: "Are you sure you want to leave this page?",
                          desc: "once you click leave the information that you filled will not be updated.",
                          buttons: [
                            DialogButton(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Palette.backgroundColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  /*go back*/
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
                                  /*go to list content*/
                                  Navigator.pushNamed(context, '/Profile_Page');

                                },
                                gradient: const LinearGradient(colors: [
                                  Palette.red,
                                  Palette.red,
                                ]))
                          ]).show();
                    }
                    else
                      Navigator.pop(context);
                  }),

              //edit list
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  "Edit list",
                  style: TextStyle(
                    color: Palette.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),

              //nothing
              SizedBox(width: 50)
            ],
          ),
        ),
        //fix overload error
        resizeToAvoidBottomInset: false,
        body: ListView(
          children: [
            /*cover img*/
            _isloaded
                ? CoverPath != ""
                ?
            /*show img*/
            Container(
              height: 100,
              width: size.width,
              child: Image(
                image: NetworkImage(CoverPath),
                fit: BoxFit.cover,
              ),
            )
                : SizedBox()
            /*loading*/
                : Container(
              margin: EdgeInsets.all(27),
              child: CircularProgressIndicator(
                backgroundColor: Palette.lightgrey,
                valueColor: AlwaysStoppedAnimation<Color>(Palette.midgrey),
              ),
            ),
            /*end of cover img*/

            /*change cover image*/

            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Center(
                child: CoverPath != ""
                    ? InkWell(
                    onTap: () {
                      onMore();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        "Change/remove cover image",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Palette.link,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ))
                    : InkWell(
                  child: Container(
                      width: size.width,
                      height: 100,
                      color: Palette.grey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate,
                            color: Palette.backgroundColor,
                            size: 50,
                          ),
                          Text(
                            "Add cover image",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Palette.backgroundColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ],
                      )),
                  onTap: () {
                    selectCoverImage();
                  },
                ),
              ),
            ),
            //end of change cover image

            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //edit list title
                  Text('Title',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Palette.darkGray)),
                  //end of edit title

                  //title text field
                  Form(
                    key: _titleKey,
                    child: Container(
                      child: TextFormField(
                        /*go next when submitted*/
                        onFieldSubmitted: (value) {},

                        //function
                        onChanged: (val) {
                          /*change the val of pass*/
                          setState(() {
                            title = val;
                            if(title != widget.listData["Title"].toString()){
                              isContentChanged[0] = true;
                            }
                            else
                              isContentChanged[0] = false;
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
                          isTitleChanged = true;
                          return null;
                        },
                        /*controller for button enable*/
                        controller: _titleController,

                        //design
                        decoration: InputDecoration(
                          hintText: "",
                          hintStyle:
                          TextStyle(fontSize: 18.0, color: Palette.grey),
                        ),
                      ),
                    ),
                  ),
                  //end of title text field

                  SizedBox(height: 30),

                  //edit list description
                  Text('Description',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Palette.darkGray)),
                  //end of edit title

                  //description text field
                  Form(
                    key: _descriptionKey,
                    child: Container(
                      child: TextFormField(
                        /*go next when submitted*/
                        onFieldSubmitted: (value) {},

                        //function
                        onChanged: (val) {
                          /*change the val of pass*/
                          setState(() {
                            description = val;
                            if(description != widget.listData["Description"].toString()){
                              isContentChanged[1] = true;
                            }
                            else
                              isContentChanged[1] = false;
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
                        /*controller for button enable*/
                        controller: _descriptionController,

                        //design
                        decoration: InputDecoration(
                          hintText: "Description",
                          hintStyle:
                          TextStyle(fontSize: 18.0, color: Palette.grey),
                        ),
                      ),
                    ),
                  ),
                  //end of description text field

                  SizedBox(height: 30),

                  //edit list tags
                  Text('Tags',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Palette.darkGray)),
                  //end of edit tags

                  //tags text field
                  Form(
                    key: _tagsKey,
                    child: Container(
                      child: TextFormField(
                        /*go next when submitted*/
                        onFieldSubmitted: (value) {},

                        //function
                        onChanged: (val) {
                          /*change the val of pass*/
                          setState(() {
                            tags = val;
                            isContentChanged[2] = true;
                          });
                          //process tags
                          int numOfTags = 0;
                          List<dynamic> Tags = [];
                          for (int i = 0; i < val.length; i++) {
                            if (val[i] == ("#")) {
                              String str = "";
                              print("in method");

                              while (true) {
                                str += val[i++];
                                if (i == val.length || val[i] == " ") {
                                  break;
                                }
                              }
                              print(str);
                              Tags.add(str);
                              numOfTags++;
                            }
                          }
                          ;
                          setState(() {
                            listOfTags = Tags;
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
                            return "Tags should not contain symbol. Only ',?!_-&@#.";
                          }
                          return null;
                        },
                        /*controller for button enable*/
                        controller: _tagsController,

                        //design
                        decoration: InputDecoration(
                          hintText: "Tags",
                          hintStyle:
                          TextStyle(fontSize: 18.0, color: Palette.grey),
                        ),
                      ),
                    ),
                  ),
                  //end of tags text field

                  SizedBox(height: 30),

                  //edit list tags
                  Text('Privacy',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Palette.darkGray)),
                  //end of edit tags

                  //privacy text field
                  Form(
                    key: _privacyKey,
                    child: Container(
                      child: TextFormField(
                        readOnly: true,
                        onTap: () {
                          onPrivacy();
                        },

                        /*go next when submitted*/
                        onFieldSubmitted: (value) {},

                        /*controller for button enable*/
                        controller: _privacyController,

                        //design
                        decoration: InputDecoration(
                          hintStyle:
                          TextStyle(fontSize: 18.0, color: Palette.grey),
                        ),
                      ),
                    ),
                  ),
                  //end of tags text field

                  /* save button */
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50.0,
                    /* button colors */
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      gradient: isContentChanged[0] || isContentChanged[1] || isContentChanged[2] || isContentChanged[3] || isContentChanged[4]
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
                        onPressed: !isContentChanged[0] && !isContentChanged[1] && !isContentChanged[2] && !isContentChanged[3] &&  !isContentChanged[4]
                            ? () {
                          showSnackBar(
                              context, "Content has not been modified");
                        }
                            : () async {
                          /*make sure of the validation*/
                          if (!_titleKey.currentState!.validate()) {
                            return;
                          }
                          if (!_descriptionKey.currentState!.validate()) {
                            return;
                          }
                          if (!_tagsKey.currentState!.validate()) {
                            return;
                          }
                          if (!_privacyKey.currentState!.validate()) {
                            return;
                          }

                          submitEditList();
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Palette.backgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  /* end of save button  */
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

//functions
  void onMore() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: CoverPath != "" ? (180 / 2 + 22) : (180 / 3),
            child: Container(
              child: onMorePressed(),
              decoration: BoxDecoration(
                color: Palette.backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
              ),
            ),
          );
        });
  }
  Column onMorePressed() {
    return Column(
      children: [
        ListTile(
          leading:
          Icon(CoverPath != "" ? Icons.edit : Icons.add_photo_alternate),
          title:
          Text(CoverPath != "" ? "Change cover image" : "Add cover image"),
          onTap: () {
            Navigator.pop(context);
            selectCoverImage();
          },
        ),
        CoverPath != ""
            ? ListTile(
          leading: Icon(Icons.delete),
          title: Text("Remove cover image"),
          onTap: () {
            Navigator.pop(context);
            Alert(
                context: context,
                title: "Are you sure you want to remove the cover image?",
                desc: "You can't undo this action.",
                buttons: [
                  DialogButton(
                    color: Palette.grey,
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          color: Palette.backgroundColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  DialogButton(
                    color: Palette.red,
                    child: const Text(
                      "Remove",
                      style: TextStyle(
                          color: Palette.backgroundColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                      setState(() {
                        CoverPath = "";
                        isContentChanged[4] = true;
                      });
                    },
                  )
                ]).show();
          },
        )
            : SizedBox()
      ],
    );
  }

  /*cover image*/
  void selectCoverImage() async {
    var isim = await pickImage(ImageSource.gallery);
    if(isim==null)
      return;
    Uint8List im = isim;
    setState(() {
      loadingImg = true;
      loading = true;
      _Cover = im;
    });

    /*update to database*/
    try {
      var uid = FirebaseAuth.instance.currentUser!.uid;
      /*to do upload in data base*/
      String p = await StorageMethods().uploadImageToStorage(
          "Lists/" + uid + "/" + ListID + "/Cover", _Cover!, true);

      setState(() {
        CoverPath = p;
        isContentChanged[4] = true;
        loading = false;
      });
    } catch (e) {
      print(e.toString());
      print(e);
    }
    setState(() {
      loadingImg = false;
    });
  }

  void onPrivacy() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 180 / 2 + 30,
            child: Container(
              child: onPrivacyPressed(),
              decoration: BoxDecoration(
                color: Palette.backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
              ),
            ),
          );
        });
  }

  Column onPrivacyPressed() {
    return Column(
      children: [
        //public
        ListTile(
          leading: Icon(Icons.public),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Public"),
              Text(
                "Anyone can search for and view",
                style: TextStyle(fontSize: 12, color: Palette.subtitle),
              ),
            ],
          ),
          onTap: () {
            _privacyController.text = "Public";
            access = true;
            if(access != widget.listData["Access"]){
              isContentChanged[3] = true;
            }
            else
              isContentChanged[3] = false;
            Navigator.pop(context);
          },
        ),

        //private
        ListTile(
          leading: Icon(Icons.lock_outline),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Private"),
              Text(
                "Only you can view",
                style: TextStyle(fontSize: 12, color: Palette.subtitle),
              ),
            ],
          ),
          onTap: () {
            _privacyController.text = "Private";
            access = false;
            if(access != widget.listData["Access"]){
              isContentChanged[3] = true;
            }
            else
              isContentChanged[3] = false;
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  submitEditList() async {
    print("update list");
    /*Data update*/
    try {
      await _firestore.collection("Lists").doc(widget.listData["ListID"]).update({
        'Title': title,
        'Description': description,
        'Tags': listOfTags,
        'Access': access,
        'Cover': CoverPath,
      });
    } catch (e) {
      print(e);
    }
    print("update list done");

    /*go to list content*/
    Navigator.pop(context);
    showSnackBar(
        context, "Content has been modified successfully!");
  }
}

