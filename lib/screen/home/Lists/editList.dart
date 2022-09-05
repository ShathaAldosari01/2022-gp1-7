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
import 'addList.dart';

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
        _isloaded = true;
        CoverPath = widget.listData["Cover"];
        ListID = widget.listData["ListID"];
      });
    }
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

  @override
  Widget build(BuildContext context) {
    /*size of screen*/
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
      body: Column(
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

          Center(
            child: CoverPath != ""? InkWell(
              onTap: () {
                onMore();
              },
              child: Text(
                "Change/remove cover image",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Palette.link,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )
            ): InkWell(
              child: Container(width: size.width, height: 100, color: Palette.grey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_photo_alternate, color: Palette.backgroundColor, size: 55,),
                      Text("Add cover image",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Palette.backgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )
                    ],
                  )),
              onTap: (){ selectCoverImage();},
            ),
          ),
        ],
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
            height: CoverPath != ""? (180 / 2 + 22): (180 / 3),
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

// we need to refresh the page using RefreshWidget
  Column onMorePressed() {
    return Column(
      children: [
        ListTile(
          leading: Icon(CoverPath != ""? Icons.edit: Icons.add_photo_alternate),
          title: Text(CoverPath != ""? "Change cover image": "Add cover image"),
          onTap: () {
            Navigator.pop(context);
            selectCoverImage();
          },
        ),
        CoverPath != ""?
        ListTile(
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

                      /*update to database*/
                      try {
                        var uid = FirebaseAuth.instance.currentUser!.uid;

                        await _firestore
                            .collection("Lists")
                            .doc(ListID)
                            .update({
                          'Cover': "",
                        });
                        setState(() {
                          CoverPath = "";
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
                    },
                  )
                ]).show();
          },
        ): SizedBox()
      ],
    );
  }

  /*cover image*/
  void selectCoverImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
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
        loading = false;
      });

      await _firestore.collection("Lists").doc(ListID).update({
        'Cover': p,
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
/*end of cover image*/
}
