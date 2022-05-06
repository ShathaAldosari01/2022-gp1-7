import 'dart:io';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gp1_7_2022/screen/home/addPost/utils.dart';
import 'package:gp1_7_2022/screen/services/firestore_methods.dart';
import 'package:intl/intl.dart';

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gp1_7_2022/config/palette.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:uuid/uuid.dart';

import '../../../providers/user_provider.dart';
import '../../auth/signup/userInfo/photo/storageMethods.dart';
import '../../auth/signup/userInfo/photo/utils.dart';


// country
import 'package:gp1_7_2022/model/country_model.dart';
import 'package:searchfield/searchfield.dart';

// API
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

//img
import 'package:image/image.dart' as IMG;

//database
import 'package:provider/provider.dart';



class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}
//API key
const kGoogleApiKey = 'AIzaSyCckhVmNilRBCInrm087ZQr0WxR1u3AbhU';

class _AddPostPageState extends State<AddPostPage> {


  void addPostToDatabase(
      /*user info*/
      String uid,


      /*place type*/
      String country,
      String city,
      List<String> categories,
      String type,
      String locationId,

      /*place info*/
      String postId,
      String name,
      String address,
      double rating,

      /*visibility*/
      String visibility,

      /*date*/
      DateTime dateVisit,

      /*content*/
      String title,
      List<String> bodies,
      List<String> imgsPath,
      List<bool> isCoverPage,
      int counter,

      )async{
    try{
      String res = await FireStoreMethods().uploadPost(uid, country, city, categories, type, locationId, postId, name, address, rating, visibility, dateVisit, title, bodies, imgsPath, isCoverPage, counter);
      if(res== "success"){
        showSnackBar(context, "Posted!");
      }else{
        showSnackBar(context, res);
      }
    }catch(e){
      showSnackBar(context, e.toString());
    }
  }


  //API
  final Mode _mode = Mode.overlay;

  //country
  @override
  void dispose() {
    _searchController.dispose();
    focus.dispose();
    super.dispose();
    //for disable button
    titleControl.dispose();
  }

  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    countries = data.map((e) => Country.fromMap(e)).toList();
    //for disable done button
    //title
    titleControl = TextEditingController();
    titleControl.addListener(() {
      final isActiveTitle = titleControl.text.isNotEmpty;
      setState(() {
        this.isButtonActive[2] = isActiveTitle;
      });
    });
    //end of title
    //body1
    body1Control = TextEditingController();
    body1Control.addListener(() {
      final isActiveBody1 = body1Control.text.isNotEmpty;
      setState(() {
        this.isButtonActive[3] = isActiveBody1;
      });
    });
    //end of body1

    //body2
    body2Control = TextEditingController();
    body2Control.addListener(() {
      final isActiveBody2 = body2Control.text.isNotEmpty;
      setState(() {
        this.isButtonActive[4] = isActiveBody2;
      });
    });
    //end of body2

    //body3
    body3Control = TextEditingController();
    body3Control.addListener(() {
      final isActiveBody3 = body3Control.text.isNotEmpty;
      setState(() {
        this.isButtonActive[5] = isActiveBody3;
      });
    });
    //end of body3

    //body4
    body4Control = TextEditingController();
    body4Control.addListener(() {
      final isActiveBody4 = body4Control.text.isNotEmpty;
      setState(() {
        this.isButtonActive[6] = isActiveBody4;
      });
    });
    //end of body4

    //body5
    body5Control = TextEditingController();
    body5Control.addListener(() {
      final isActiveBody5 = body5Control.text.isNotEmpty;
      setState(() {
        this.isButtonActive[7] = isActiveBody5;
      });
    });
    //end of body5

    //body6
    body6Control = TextEditingController();
    body6Control.addListener(() {
      final isActiveBody6 = body6Control.text.isNotEmpty;
      setState(() {
        this.isButtonActive[8] = isActiveBody6;
      });
    });
    //end of body6

    //body7
    body7Control = TextEditingController();
    body7Control.addListener(() {
      final isActiveBody7 = body7Control.text.isNotEmpty;
      setState(() {
        this.isButtonActive[9] = isActiveBody7;
      });
    });
    //end of body7

    //body8
    body8Control = TextEditingController();
    body8Control.addListener(() {
      final isActiveBody8 = body8Control.text.isNotEmpty;
      setState(() {
        this.isButtonActive[10] = isActiveBody8;
      });
    });
    //end of body8

    //body9
    body9Control = TextEditingController();
    body9Control.addListener(() {
      final isActiveBody9 = body9Control.text.isNotEmpty;
      setState(() {
        this.isButtonActive[11] = isActiveBody9;
      });
    });
    //end of body9

    //body10
    body10Control = TextEditingController();
    body10Control.addListener(() {
      final isActiveBody10 = body10Control.text.isNotEmpty;
      setState(() {
        this.isButtonActive[12] = isActiveBody10;
      });
    });
    //end of body10

    //body11
    body11Control = TextEditingController();
    body11Control.addListener(() {
      final isActiveBody11 = body11Control.text.isNotEmpty;
      setState(() {
        this.isButtonActive[13] = isActiveBody11;
      });
    });
    //end of body11

    //body12
    body12Control = TextEditingController();
    body12Control.addListener(() {
      final isActiveBody12 = body12Control.text.isNotEmpty;
      setState(() {
        this.isButtonActive[14] = isActiveBody12;
      });
    });
    //end of body12

    //body13
    body13Control = TextEditingController();
    body13Control.addListener(() {
      final isActiveBody13 = body13Control.text.isNotEmpty;
      setState(() {
        this.isButtonActive[15] = isActiveBody13;
      });
    });
    //end of body13

    //body14
    body14Control = TextEditingController();
    body14Control.addListener(() {
      final isActiveBody14 = body14Control.text.isNotEmpty;
      setState(() {
        this.isButtonActive[16] = isActiveBody14;
      });
    });
    //end of body14

    //body15
    body15Control = TextEditingController();
    body15Control.addListener(() {});
    //end of body15

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
  }

  /*attributes*/
  final focus = FocusNode();
  List<Country> countries = [];
  Country _selectedCountry = Country.init();
  String country = "";
  String city = "";

  String postId = const Uuid().v1();

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
  List<bool> isButtonActive = [
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
    false,
    false,
    false,
    false
  ];

  // location , rating , title, page1, page2, page3, page4, page5, page6, page7, page8, page9, page10, page11, page12, page13, page14,category

  /* images */

  List<String> paths = ["no", "no", "no", "no", "no", "no", "no", "no", "no", "no", "no", "no", "no", "no", "no", "no"];
  Uint8List? _Coverimage;
  List<int> sizeImge = [];

  Uint8List? _image1;
  List<int> sizeImge1 = [];

  Uint8List? _image2;
  List<int> sizeImge2 = [];

  Uint8List? _image3;
  List<int> sizeImge3 = [];

  Uint8List? _image4;
  List<int> sizeImge4 = [];

  Uint8List? _image5;
  List<int> sizeImge5 = [];

  Uint8List? _image6;
  List<int> sizeImge6 = [];

  Uint8List? _image7;
  List<int> sizeImge7 = [];

  Uint8List? _image8;
  List<int> sizeImge8 = [];

  Uint8List? _image9;
  List<int> sizeImge9 = [];

  Uint8List? _image10;
  List<int> sizeImge10 = [];

  Uint8List? _image11;
  List<int> sizeImge11 = [];

  Uint8List? _image12;
  List<int> sizeImge12 = [];

  Uint8List? _image13;
  List<int> sizeImge13 = [];

  Uint8List? _image14;
  List<int> sizeImge14 = [];

  Uint8List? _image15;
  List<int> sizeImge15 = [];

  /* visibility */
  List<bool> vis = [
    true,
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

  /* For x icon visibility */
  List<bool> visIcon = [
    true,
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

  int counter = 0; // cont the pages
  int maxImgs = 15;

  /*hight*/
  double devHight = 121;
  double devHight1 = 145;
  double devHight2 = 145;
  double devHight3 = 145;
  double devHight4 = 145;
  double devHight5 = 145;
  double devHight6 = 145;
  double devHight7 = 145;
  double devHight8 = 145;
  double devHight9 = 145;
  double devHight10 = 145;
  double devHight11 = 145;
  double devHight12 = 145;
  double devHight13 = 145;
  double devHight14 = 145;
  double devHight15 = 145;

  //for the type
  double devHightType = 90;

  //form
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();
  final _formKey5 = GlobalKey<FormState>();
  final _formKey6 = GlobalKey<FormState>();
  final _formKey7 = GlobalKey<FormState>();
  final _formKey8 = GlobalKey<FormState>();
  final _formKey9 = GlobalKey<FormState>();
  final _formKey10 = GlobalKey<FormState>();
  final _formKey11 = GlobalKey<FormState>();
  final _formKey12 = GlobalKey<FormState>();
  final _formKey13 = GlobalKey<FormState>();
  final _formKey14 = GlobalKey<FormState>();
  final _formKey15 = GlobalKey<FormState>();

  //for disable for done button
  late TextEditingController titleControl;
  late TextEditingController body1Control;
  late TextEditingController body2Control;
  late TextEditingController body3Control;
  late TextEditingController body4Control;
  late TextEditingController body5Control;
  late TextEditingController body6Control;
  late TextEditingController body7Control;
  late TextEditingController body8Control;
  late TextEditingController body9Control;
  late TextEditingController body10Control;
  late TextEditingController body11Control;
  late TextEditingController body12Control;
  late TextEditingController body13Control;
  late TextEditingController body14Control;
  late TextEditingController body15Control;

  String title = "";
  List<String> bodies = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", ""];

  /*title size*/
  double titleSize = 18;

  //Location
  String locationId = "";
  String locationName = "";
  String locationAdress = "";
  List<String> locationTypes = [];
  String locationType = "";
  List<int> numbers = [0];
  List<Color> typeTextColor = [Palette.textColor, Palette.backgroundColor];
  List<Color> typeBackgroundColor = [
    Palette.midgrey,
    Palette.buttonColor,
    Palette.nameColor,
  ];
  List<Color> typeBorderColor = [Palette.grey, Palette.buttonDisableColor];

  /*screen width*/
  double width = 370;
  double hight = 700;

  /*image looks*/
  List<BoxFit> ImgsLook = [
    BoxFit.cover,
    BoxFit.cover,
    BoxFit.cover,
    BoxFit.cover,
    BoxFit.cover,
    BoxFit.cover,
    BoxFit.cover,
    BoxFit.cover,
    BoxFit.cover,
    BoxFit.cover,
    BoxFit.cover,
    BoxFit.cover,
    BoxFit.cover,
    BoxFit.cover,
    BoxFit.cover,
    BoxFit.cover,
  ];
  List<bool> checkImgs = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ];

//Bool for loading the change path after posting
  List<bool> loading = [
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
    false,
    false
  ];

  //for loading image when posting
  bool isLoaded = false ;

  @override
  Widget build(BuildContext context) {
    /*user*/
    // final UserProvider userProvider = Provider.of<UserProvider>(context);

    /* back button on devise */
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/navigationBar');
        return true;
      },

      child:
      isLoaded?  Container(
        color: Palette.backgroundColor,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ):
      Scaffold(
        backgroundColor: Palette.backgroundColor,

        appBar: AppBar(
          //appBar style
          elevation: 0,
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
                    icon: const Icon(Icons.arrow_back, color: Palette.textColor),
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


        //fix overload error
        resizeToAvoidBottomInset: false,

        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),

          /*so it can scroll*/
          child: SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(
                  height: 20,
                ),

                /*country */
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /*left*/
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Column(
                        children: [
                          /*icon*/
                          CircleAvatar(
                              radius: 13,
                              backgroundColor: Palette.grey,
                              child: Text("C",
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
                            height: 81,

                          )
                          /*end of divider */

                        ],
                      ),
                    ),
                    /*end left */

                    /*right*/
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        /*county text*/
                        Text('County',
                            style: TextStyle(
                                fontSize: titleSize,
                                fontWeight: FontWeight.w500
                            )
                        ),
                        /*end of county text*/

                        SizedBox(height: 12),

                        /*county*/
                        Container(
                          width: 235,
                          child: Column(
                            children: [
                              SearchField(
                                focusNode: focus,
                                suggestions: countries
                                    .map((country) =>
                                    SearchFieldListItem(
                                        country.name, item: country))
                                    .toList(),
                                suggestionState: Suggestion.expand,
                                controller: _searchController,
                                hint: 'Search by country name',
                                maxSuggestionsInViewPort: 4,
                                itemHeight: 45,
                                inputType: TextInputType.text,
                                onSuggestionTap: (
                                    SearchFieldListItem<Country> x) {
                                  setState(() {
                                    _selectedCountry = x.item!;
                                    country = _selectedCountry.name;
                                  });
                                  focus.unfocus();
                                },
                                searchInputDecoration: const InputDecoration(
                                  /*background color*/
                                  fillColor: Palette.lightgrey,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 1.0, horizontal: 10),
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: "Search by country name",
                                  hintStyle: TextStyle(
                                      fontSize: 18.0, color: Palette.grey),

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

                            ],
                          ),
                        ),
                        /*end of county */


                      ],
                    )
                    /*end right*/

                  ],
                ),
                /*end of county*/


                /*Location */
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /*left*/
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Column(
                        children: [
                          /*icon*/
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: Palette.grey,
                            child: Icon(
                              Icons.location_on_sharp,
                              color: Palette.backgroundColor,
                              size: 20,
                            ),
                          ),
                          /*end of icon */

                          /*divider*/
                          Container(
                            color: Colors.grey,
                            width: 3,
                            height: !isButtonActive[0] ? 77 : 200,
                          )
                          /*end of divider */

                        ],
                      ),
                    ),
                    /*end left */

                    /*right*/
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /* Location title*/
                        Text("Location",
                          style: TextStyle(
                            fontSize: titleSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        /*end of Location text*/

                        isButtonActive[0]
                            ? SizedBox(height: 12)
                            : SizedBox(),

                        /*Location */
                        /*location info*/
                        locationName.isNotEmpty ?
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          color: Palette.midgrey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /*Name*/
                              locationName.isNotEmpty ?
                              Container(
                                  width: 260,
                                  child: RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                        text: "Name : ",
                                        style: TextStyle(
                                          color: Palette.textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: "$locationName",
                                              style: TextStyle(
                                                color: Palette.textColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                              )
                                          ),
                                        ]
                                    ),
                                  )
                              ) : SizedBox(),
                              /* End of Name */

                              isButtonActive[0]
                                  ? SizedBox(height: 8)
                                  : SizedBox(),

                              /*Address*/
                              locationAdress.isNotEmpty ?
                              Container(
                                  width: 260,
                                  child: RichText(
                                    text: TextSpan(
                                        text: "Address : ",
                                        style: TextStyle(
                                          color: Palette.textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: "$locationAdress",
                                              style: TextStyle(
                                                color: Palette.textColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                              )
                                          ),
                                        ]
                                    ),
                                  )
                              ) : SizedBox(),
                              /* End of Address */
                            ],
                          ),
                        ) : SizedBox(),


                        SizedBox(height: 12),

                        /* Location button */
                        Container(
                          width: 150,
                          alignment: Alignment.center,
                          height: 50.0,
                          /* button colors */
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            gradient: _selectedCountry.code
                                .toString()
                                .isNotEmpty
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
                              onPressed:
                              _selectedCountry.code
                                  .toString()
                                  .isNotEmpty
                                  ? _handlePressButton
                                  : null,
                              child: Text(
                                !isButtonActive[0]
                                    ? 'Choose Place'
                                    : 'Change Place',
                                style: TextStyle(
                                  color: Palette.backgroundColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        /* end of location button  */


                        SizedBox(height: 20),


                        /*end of Location */
                      ],
                    )
                    /*end right*/

                  ],
                ),
                /*end of Location*/


                /*type*/
                Visibility(
                  visible: isButtonActive[0] && locationTypes.length !=0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /*left*/
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(
                          children: [
                            /*icon*/
                            CircleAvatar(
                              radius: 13,
                              backgroundColor: Palette.grey,
                              child: Icon(
                                  Icons.all_inbox_rounded,
                                  color: Colors.white
                              ),
                            ),
                            /*end of icon */

                            /*divider*/
                            Container(
                              color: Colors.grey,
                              width: 3,
                              height: devHightType,
                            )
                            /*end of divider */

                          ],
                        ),
                      ),
                      /*end left */

                      /*right*/
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /*Category title */
                          Text(
                            "Category ",
                            style: TextStyle(
                              color: Palette.textColor,
                              fontWeight: FontWeight.w500,
                              fontSize: titleSize,
                            ),
                          ),
                          /* end of Category title */

                          SizedBox(
                            height: 16,
                          ),


                          /* Category */
                          Container(
                              width: 250,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for ( var i = 0; i < locationTypes.length; i++)
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 5),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 5),

                                      // to make corner rounded
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            typeBackgroundColor[numbers[i]],
                                            typeBackgroundColor[numbers[i] * 2],
                                          ]),
                                          border: Border.all(
                                            color: typeBorderColor[numbers[i]],
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))
                                      ),
                                      // End of corner rounded

                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            minimumSize: Size(50, 30),
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                            alignment: Alignment.center),
                                        child: Text(
                                          locationTypes[i],
                                          style: TextStyle(
                                            color: typeTextColor[numbers[i]],
                                            fontSize: 16,
                                          ),
                                        ),
                                        onPressed: () {
                                          //save type
                                          locationType = locationTypes[i];
                                          print(locationType);
                                          //change style
                                          //1A) reverse the colors
                                          int num = numbers[i];

                                          //2) remove from all
                                          setState(() {
                                            for (int j = 0; j <
                                                numbers.length; j++) {
                                              if (numbers[j] == 1) {
                                                numbers[j] = 0;
                                              }
                                            }
                                          });

                                          //1B) reverse the colors
                                          if (num == 0)
                                            setState(() {
                                              numbers[i] = 1;
                                            });
                                          bool flag = false;
                                          for (int j = 0; j <
                                              numbers.length; j++) {
                                            if (numbers[j] == 1) {
                                              flag = true;
                                            }
                                          }
                                          setState(() {
                                            isButtonActive[17] = flag;
                                          });
                                        },
                                      ),
                                    )
                                ],
                              )
                          ),
                          /*end of Category*/

                          SizedBox(
                            height: 16,
                          ),


                        ],
                      )
                      /*end right*/

                    ],
                  ),
                ),
                /*end of Category*/


                /*rating */
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /*left*/
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Column(
                        children: [
                          /*icon*/
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: Palette.grey,
                            child: Icon(
                              Icons.star,
                              color: Palette.backgroundColor,
                              size: 20,
                            ),
                          ),
                          /*end of icon */

                          /*divider*/
                          Container(
                            color: Colors.grey,
                            width: 3,
                            height: 74,

                          )
                          /*end of divider */

                        ],
                      ),
                    ),
                    /*end left */

                    /*right*/
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /*rating title*/
                        rating != 0
                            ? RichText(
                          text: TextSpan(
                              text: "Rate of your visit : ",
                              style: TextStyle(
                                color: Palette.textColor,
                                fontWeight:
                                FontWeight.w500,
                                fontSize: titleSize,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "$rating",
                                    style: TextStyle(
                                      color: Palette.buttonColor,
                                      fontSize: 20,
                                    )
                                ),
                              ]
                          ),
                        )
                            : Text(
                          'Rate your visit',
                          style: TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        /*end of rating text*/

                        SizedBox(height: 16),

                        /*rating */
                        RatingBar.builder(
                          minRating: 1,
                          itemSize: 30,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4),
                          itemBuilder: (context, _) =>
                              Icon(Icons.star, color: Palette.buttonColor),
                          updateOnDrag: true,
                          onRatingUpdate: (rating) =>
                              setState(() {
                                this.rating = rating.toInt();
                                isButtonActive[1] = true;
                                print(isButtonActive);
                              }),
                        ),
                        /*end of rating */

                        SizedBox(height: 30),
                      ],
                    )
                    /*end right*/

                  ],
                ),
                /*end of rating*/


                /*date */
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /*left*/
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Column(
                        children: [
                          /*icon*/
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: Palette.grey,
                            child: Icon(
                              Icons.date_range,
                              color: Palette.backgroundColor,
                              size: 20,
                            ),
                          ),
                          /*end of icon */

                          /*divider*/
                          Container(
                            color: Colors.grey,
                            width: 3,
                            height: 95,

                          )
                          /*end of divider */

                        ],
                      ),
                    ),
                    /*end left */

                    /*right*/
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /*date of visit*/
                        RichText(
                          text: TextSpan(
                              text: 'Date of visit',
                              style: TextStyle(
                                color: Palette.textColor,
                                fontWeight: FontWeight.w500,
                                fontSize: titleSize,
                              ),
                              children: <TextSpan>[
                              ]),
                        ),
                        /* end of date of visit */

                        SizedBox(height: 16),

                        /*date*/
                        Container(
                          width: 235,
                          child: TextFormField(
                            onTap: () {
                              Utils.showSheet(context, child: buildDatePicker(),
                                  onClicked: () {
                                    setState(() {
                                      visit = DateFormat.yMMMMd('en_US').format(
                                          dateTime);
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
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 1.0, horizontal: 10),

                              /*hint*/
                              border: OutlineInputBorder(),
                              hintText: visit.isNotEmpty ? "$visit" : DateFormat
                                  .yMMMMd('en_US').format(dateTime),
                              hintStyle: TextStyle(
                                  fontSize: 18.0, color: Palette.grey),

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

                        SizedBox(height: 30),

                      ],
                    )
                    /*end right*/

                  ],
                ),
                /*end of date*/


                /*title */
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

                        /*title */
                        Text(
                          "Title",
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
                                width: 235,
                                child: TextFormField(
                                  //for disable for the done button
                                  controller: titleControl,

                                  onChanged: (val) {
                                    /*change the val of title*/
                                    setState(() {
                                      title = val;
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
                                    if ((val.contains('&') ||
                                        val.contains("#") ||
                                        val.contains("*") ||
                                        val.contains("!") ||
                                        val.contains("%") ||
                                        val.contains("~") ||
                                        val.contains("`") ||
                                        val.contains("@") ||
                                        val.contains("^") ||
                                        val.contains("(") ||
                                        val.contains(")") ||
                                        val.contains("+") ||
                                        val.contains("=") ||
                                        val.contains("{") ||
                                        val.contains("[") ||
                                        val.contains("}") ||
                                        val.contains("]") ||
                                        val.contains("|") ||
                                        val.contains(":") ||
                                        val.contains(";") ||
                                        val.contains("<") ||
                                        val.contains(">") ||
                                        val.contains(",") ||
                                        val.contains("?") ||
                                        val.contains("/"))) {
                                      return "Title should not contain special characters. only '-', '_' and '.'.";
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
                                    hintText: "Title Of Post",
                                    hintStyle: TextStyle(fontSize: 18.0,
                                      color: Palette.grey,
                                      height: 2.0,),

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
                                  )
                              ),
                            ),
                            /*end of image icon*/

                          ],
                        ),
                        /*end of title*/

                        SizedBox(
                          height: 4,
                        ),

                        /*cover image*/
                        _Coverimage != null
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
                                image: MemoryImage(_Coverimage!),
                                width: width - 90,
                                height: hight * ((width - 90) / width),
                                fit: ImgsLook[0],
                              ) :
                              Image(
                                image: MemoryImage(_Coverimage!),
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
                                      print(_Coverimage);
                                      paths[0] = 'no';
                                      _Coverimage = null;
                                      devHight = 121;
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

                        /*cover img look*/
                        _Coverimage != null ?
                        Container(
                          color: Palette.lightgrey,
                          width: width - 90,
                          child: CheckboxListTile(
                            //text
                            title: Text("Cover the entire page"),
                            //value
                            value: checkImgs[0],
                            //action
                            onChanged: (bool? value) {
                              setState(() {
                                checkImgs[0] = !checkImgs[0];
                              });
                              if (checkImgs[0]) {
                                setState(() {
                                  devHight =
                                      159 + (hight * ((width - 90) / width));
                                });
                              } else {
                                setState(() {
                                  devHight = sizeImge[1].toDouble() + 159;
                                });
                              }
                            },
                            //style
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: Palette.buttonColor,
                            // checkColor: Palette.buttonColor,
                          ),
                        ) :
                        SizedBox(),
                        /*end of cover img look*/

                        SizedBox(height: 20),

                      ],
                    )
                    /*end right*/

                  ],
                ),
                /*end of title*/


                /*body 1 */
                Visibility(
                  visible: vis[0],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /*left*/
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(
                          children: [
                            /*icon*/
                            CircleAvatar(
                                radius: 13,
                                backgroundColor: Palette.grey,
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                    color: Palette.backgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ),
                            /*end of icon */

                            /*divider*/
                            Container(
                              color: Colors.grey,
                              width: 3,
                              height: devHight1,
                            )
                            /*end of divider */

                          ],
                        ),
                      ),
                      /*end left */

                      /*right*/
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /*page title */
                          Text(
                            "Page 1",
                            style: TextStyle(
                              color: Palette.textColor,
                              fontWeight: FontWeight.w500,
                              fontSize: titleSize,
                            ),
                          ),
                          /* end of page title */

                          SizedBox(
                            height: 16,
                          ),


                          /* body 1 */
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Form(
                                key: _formKey1,
                                child: Container(
                                  width: 235,
                                  child: TextFormField(

                                    //for disable button
                                    controller: body1Control,

                                    onChanged: (val) {
                                      /*change the val of title*/
                                      setState(() {
                                        bodies[0] = val;
                                      });
                                    },

                                    /*validation*/
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Body should not be empty";
                                      }
                                      if (val.length >= 280) {
                                        return "Create a shorter body under 281 characters.";
                                      }
                                      if ((val.contains('&') ||
                                          val.contains("#") ||
                                          val.contains("*") ||
                                          val.contains("!") ||
                                          val.contains("%") ||
                                          val.contains("~") ||
                                          val.contains("`") ||
                                          val.contains("@") ||
                                          val.contains("^") ||
                                          val.contains("(") ||
                                          val.contains(")") ||
                                          val.contains("+") ||
                                          val.contains("=") ||
                                          val.contains("{") ||
                                          val.contains("[") ||
                                          val.contains("}") ||
                                          val.contains("]") ||
                                          val.contains("|") ||
                                          val.contains(":") ||
                                          val.contains(";") ||
                                          val.contains("<") ||
                                          val.contains(">") ||
                                          val.contains(",") ||
                                          val.contains("?") ||
                                          val.contains("/"))) {
                                        return ""
                                            "Body should not contain special characters. only '-', '_' and '.'.";
                                      }
                                      return null;
                                    },

                                    //for multi line
                                    minLines: 1,
                                    maxLines: 5,
                                    // allow user to enter 10 line in textfield
                                    keyboardType: TextInputType.multiline,
                                    decoration: const InputDecoration(
                                      /*background color*/
                                      fillColor: Palette.lightgrey,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 1.0, horizontal: 10),
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      hintText: "Body Of First Page",
                                      hintStyle: TextStyle(
                                          fontSize: 18.0, color: Palette.grey),

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
                              /*end of body 1*/

                              /*image image 1*/
                              Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: IconButton(
                                    onPressed: selectImage1,
                                    icon: Icon(
                                      Icons.image,
                                      color: Palette.buttonColor,
                                      size: 35,
                                    )
                                ),
                              ),
                              /*end of image icon*/

                            ],
                          ),
                          /*end of title*/

                          SizedBox(
                            height: 4,
                          ),

                          /*cover image*/
                          _image1 != null
                              ? Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                color: Palette.midgrey,
                                alignment: Alignment.centerLeft,
                                width: width - 90,
                                child: checkImgs[1] ?
                                Image(
                                  image: MemoryImage(_image1!),
                                  width: width - 90,
                                  height: hight * ((width - 90) / width),
                                  fit: ImgsLook[1],
                                ) :
                                Image(
                                  image: MemoryImage(_image1!),
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
                                        paths[1] = 'no';
                                        _image1 = null;
                                        devHight1 = 121;
                                        checkImgs[1] = true;
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

                          /*cover img look*/
                          _image1 != null ?
                          Container(
                            color: Palette.lightgrey,
                            width: width - 90,
                            child: CheckboxListTile(
                              //text
                              title: Text("Cover the entire page"),
                              //value
                              value: checkImgs[1],
                              //action
                              onChanged: (bool? value) {
                                setState(() {
                                  checkImgs[1] = !checkImgs[1];
                                });
                                if (checkImgs[1]) {
                                  setState(() {
                                    devHight1 =
                                        159 + (hight * ((width - 90) / width));
                                  });
                                } else {
                                  setState(() {
                                    devHight1 = sizeImge1[1].toDouble() + 159;
                                  });
                                }
                              },
                              //style
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: Palette.buttonColor,
                              // checkColor: Palette.buttonColor,
                            ),
                          ) :
                          SizedBox(),
                          /*end of cover img look*/

                        ],
                      )
                      /*end right*/

                    ],
                  ),
                ),
                /*end of body 1*/


                /*body 2 */
                Visibility(
                  visible: vis[1],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /*left*/
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(
                          children: [
                            /*icon*/
                            CircleAvatar(
                                radius: 13,
                                backgroundColor: Palette.grey,
                                child: Text(
                                  '2',
                                  style: TextStyle(
                                    color: Palette.backgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ),
                            /*end of icon */

                            /*divider*/
                            Container(
                              color: Colors.grey,
                              width: 3,
                              height: devHight2,
                            )
                            /*end of divider */

                          ],
                        ),
                      ),
                      /*end left */

                      /*right*/
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              /*page title */
                              Text(
                                "Page 2",
                                style: TextStyle(
                                  color: Palette.textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: titleSize,
                                ),
                              ),
                              /* end of page title */

                              SizedBox(width: 193,),

                              //Delete page
                              Visibility(
                                visible: visIcon[0],
                                child: IconButton(
                                  //Remove the margin
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    //End of remove margin
                                    onPressed: () {
                                      //remove a page
                                      setState(() {
                                        vis[1] = false;
                                        counter--;
                                        counter--;
                                        //remove the image
                                        paths[2] = 'no';
                                        _image2 = null;
                                        devHight2 = 145;
                                        checkImgs[2] = true;
                                      });
                                      //clear the text
                                      body2Control.clear();
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color: Palette.darkGray,
                                      size: 25,
                                    )
                                ),
                              ),
                              //end delete page
                            ],
                          ),


                          SizedBox(
                            height: 16,
                          ),


                          /* body 2 */
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Form(
                                key: _formKey2,
                                child: Container(
                                  width: 235,
                                  child: TextFormField(
                                    //for disable button
                                    controller: body2Control,

                                    onChanged: (val) {
                                      /*change the val of title*/
                                      setState(() {
                                        bodies[1] = val;
                                      });
                                    },

                                    /*validation*/
                                    validator: (val) {
                                      if (val!.isNotEmpty && val.length >= 280) {
                                        return "Create a shorter body under 281 characters.";
                                      }
                                      if (val!.isNotEmpty &&
                                          (val.contains('&') ||
                                              val.contains("#") ||
                                              val.contains("*") ||
                                              val.contains("!") ||
                                              val.contains("%") ||
                                              val.contains("~") ||
                                              val.contains("`") ||
                                              val.contains("@") ||
                                              val.contains("^") ||
                                              val.contains("(") ||
                                              val.contains(")") ||
                                              val.contains("+") ||
                                              val.contains("=") ||
                                              val.contains("{") ||
                                              val.contains("[") ||
                                              val.contains("}") ||
                                              val.contains("]") ||
                                              val.contains("|") ||
                                              val.contains(":") ||
                                              val.contains(";") ||
                                              val.contains("<") ||
                                              val.contains(">") ||
                                              val.contains(",") ||
                                              val.contains("?") ||
                                              val.contains("/"))) {
                                        return "Body should not contain special characters. only '-', '_' and '.'.";
                                      }
                                      return null;
                                    },

                                    //for multi line
                                    minLines: 1,
                                    maxLines: 5,
                                    // allow user to enter 10 line in textfield
                                    keyboardType: TextInputType.multiline,
                                    decoration: const InputDecoration(
                                      /*background color*/
                                      fillColor: Palette.lightgrey,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 1.0, horizontal: 10),
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      hintText: "Body Of Second Page",
                                      hintStyle: TextStyle(
                                          fontSize: 18.0, color: Palette.grey),

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
                              /*end of body 1*/

                              /*image image 2*/
                              Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: IconButton(
                                    onPressed: selectImage2,
                                    icon: Icon(
                                      Icons.image,
                                      color: Palette.buttonColor,
                                      size: 35,
                                    )
                                ),
                              ),
                              /*end of image 2 icon*/

                            ],
                          ),
                          /*end of title*/

                          SizedBox(
                            height: 4,
                          ),

                          /*cover image*/
                          _image2 != null
                              ? Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                color: Palette.midgrey,
                                alignment: Alignment.centerLeft,
                                width: width - 90,
                                child: checkImgs[2] ?
                                Image(
                                  image: MemoryImage(_image2!),
                                  width: width - 90,
                                  height: hight * ((width - 90) / width),
                                  fit: ImgsLook[2],
                                ) :
                                Image(
                                  image: MemoryImage(_image2!),
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
                                        paths[2] = 'no';
                                        _image2 = null;
                                        devHight2 = 121;
                                        checkImgs[2] = true;
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

                          /*cover img look*/
                          _image2 != null ?
                          Container(
                            color: Palette.lightgrey,
                            width: width - 90,
                            child: CheckboxListTile(
                              //text
                              title: Text("Cover the entire page"),
                              //value
                              value: checkImgs[2],
                              //action
                              onChanged: (bool? value) {
                                setState(() {
                                  checkImgs[2] = !checkImgs[2];
                                });
                                if (checkImgs[2]) {
                                  setState(() {
                                    devHight2 =
                                        183 + (hight * ((width - 90) / width));
                                  });
                                } else {
                                  setState(() {
                                    devHight2 = sizeImge2[1].toDouble() + 183;
                                  });
                                }
                              },
                              //style
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: Palette.buttonColor,
                              // checkColor: Palette.buttonColor,
                            ),
                          ) :
                          SizedBox(),
                          /*end of cover img look*/

                        ],
                      )
                      /*end right*/

                    ],
                  ),
                ),
                /*end of body 2*/


                /*body 3 */
                Visibility(
                  visible: vis[2],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /*left*/
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(
                          children: [
                            /*icon*/
                            CircleAvatar(
                                radius: 13,
                                backgroundColor: Palette.grey,
                                child: Text(
                                  '3',
                                  style: TextStyle(
                                    color: Palette.backgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ),
                            /*end of icon */

                            /*divider*/
                            Container(
                              color: Colors.grey,
                              width: 3,
                              height: devHight3,
                            )
                            /*end of divider */

                          ],
                        ),
                      ),
                      /*end left */

                      /*right*/
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /*page title */
                          Row(
                            children: [
                              /*page title */
                              Text(
                                "Page 3",
                                style: TextStyle(
                                  color: Palette.textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: titleSize,
                                ),
                              ),
                              // end of page title

                              SizedBox(width: 193,),

                              //Delete page
                              Visibility(
                                visible: visIcon[1],
                                child: IconButton(
                                  //Remove the margin
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    //End of remove margin
                                    onPressed: () {
                                      //remove a page
                                      setState(() {
                                        vis[2] = false;
                                        counter--;
                                        //remove the image
                                        paths[3] = 'no';
                                        _image3 = null;
                                        devHight3 = 145;
                                        visIcon[0] = true;
                                        checkImgs[3] = true;
                                      });
                                      //clear the text
                                      body3Control.clear();
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color: Palette.darkGray,
                                      size: 25,
                                    )
                                ),
                              ),
                              //end delete page
                            ],
                          ),


                          SizedBox(
                            height: 16,
                          ),


                          /* body 3 */
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Form(
                                key: _formKey3,
                                child: Container(
                                  width: 235,
                                  child: TextFormField(

                                    onChanged: (val) {
                                      /*change the val of title*/
                                      setState(() {
                                        bodies[2] = val;
                                      });
                                    },

                                    /*validation*/
                                    validator: (val) {
                                      if (val!.isNotEmpty && val.length >= 280) {
                                        return "Create a shorter body under 281 characters.";
                                      }
                                      if ((val.contains('&') ||
                                          val.contains("#") ||
                                          val.contains("*") ||
                                          val.contains("!") ||
                                          val.contains("%") ||
                                          val.contains("~") ||
                                          val.contains("`") ||
                                          val.contains("@") ||
                                          val.contains("^") ||
                                          val.contains("(") ||
                                          val.contains(")") ||
                                          val.contains("+") ||
                                          val.contains("=") ||
                                          val.contains("{") ||
                                          val.contains("[") ||
                                          val.contains("}") ||
                                          val.contains("]") ||
                                          val.contains("|") ||
                                          val.contains(":") ||
                                          val.contains(";") ||
                                          val.contains("<") ||
                                          val.contains(">") ||
                                          val.contains(",") ||
                                          val.contains("?") ||
                                          val.contains("/"))) {
                                        return "Body should not contain special characters. only '-', '_' and '.'.";
                                      }
                                      return null;
                                    },

                                    //for disable button
                                    controller: body3Control,

                                    //for multi line
                                    minLines: 1,
                                    maxLines: 5,
                                    // allow user to enter 10 line in testified
                                    keyboardType: TextInputType.multiline,
                                    decoration: const InputDecoration(
                                      /*background color*/
                                      fillColor: Palette.lightgrey,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 1.0, horizontal: 10),
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      hintText: "Body Of Thread Page",
                                      hintStyle: TextStyle(
                                          fontSize: 18.0, color: Palette.grey),

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
                              /*end of body 3*/

                              /*image image 3*/
                              Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: IconButton(
                                    onPressed: selectImage3,
                                    icon: Icon(
                                      Icons.image,
                                      color: Palette.buttonColor,
                                      size: 35,
                                    )
                                ),
                              ),
                              /*end of image 3 icon*/

                            ],
                          ),
                          /*end of title*/

                          SizedBox(
                            height: 4,
                          ),

                          /*cover image*/
                          _image3 != null
                              ? Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                color: Palette.midgrey,
                                alignment: Alignment.centerLeft,
                                width: width - 90,
                                child: checkImgs[3] ?
                                Image(
                                  image: MemoryImage(_image3!),
                                  width: width - 90,
                                  height: hight * ((width - 90) / width),
                                  fit: ImgsLook[3],
                                ) :
                                Image(
                                  image: MemoryImage(_image3!),
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
                                        paths[3] = 'no';
                                        _image3 = null;
                                        devHight3 = 121;
                                        checkImgs[3] = true;
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

                          /*cover img look*/
                          _image3 != null ?
                          Container(
                            color: Palette.lightgrey,
                            width: width - 90,
                            child: CheckboxListTile(
                              //text
                              title: Text("Cover the entire page"),
                              //value
                              value: checkImgs[3],
                              //action
                              onChanged: (bool? value) {
                                setState(() {
                                  checkImgs[3] = !checkImgs[3];
                                });
                                if (checkImgs[3]) {
                                  setState(() {
                                    devHight3 =
                                        183 + (hight * ((width - 90) / width));
                                  });
                                } else {
                                  setState(() {
                                    devHight3 = sizeImge3[1].toDouble() + 183;
                                  });
                                }
                              },
                              //style
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: Palette.buttonColor,
                              // checkColor: Palette.buttonColor,
                            ),
                          ) :
                          SizedBox(),
                          /*end of cover img look*/

                        ],
                      )
                      /*end right*/

                    ],
                  ),
                ),
                /*end of body 3*/


                /*body 4 */
                Visibility(
                  visible: vis[3],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /*left*/
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(
                          children: [
                            /*icon*/
                            CircleAvatar(
                                radius: 13,
                                backgroundColor: Palette.grey,
                                child: Text(
                                  '4',
                                  style: TextStyle(
                                    color: Palette.backgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ),
                            /*end of icon */

                            /*divider*/
                            Container(
                              color: Colors.grey,
                              width: 3,
                              height: devHight4,
                            )
                            /*end of divider */

                          ],
                        ),
                      ),
                      /*end left */

                      /*right*/
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Row(
                            children: [
                              /*page title */
                              Text(
                                "Page 4",
                                style: TextStyle(
                                  color: Palette.textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: titleSize,
                                ),
                              ),
                              /* end of page title */

                              SizedBox(width: 193,),

                              //Delete page
                              Visibility(
                                visible: visIcon[2],
                                child: IconButton(
                                  //Remove the margin
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    //End of remove margin
                                    onPressed: () {
                                      //remove a page
                                      setState(() {
                                        vis[3] = false;
                                        counter--;
                                        //remove the image
                                        paths[4] = 'no';
                                        _image4 = null;
                                        devHight4 = 145;
                                        checkImgs[4] = true;
                                        visIcon[1] = true;
                                      });
                                      //clear the text
                                      body4Control.clear();
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color: Palette.darkGray,
                                      size: 25,
                                    )
                                ),
                              ),
                              //end delete page
                            ],
                          ),


                          SizedBox(
                            height: 16,
                          ),


                          /* body 4 */
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Form(
                                key: _formKey4,
                                child: Container(
                                  width: 235,
                                  child: TextFormField(
                                    //for disable button
                                    controller: body4Control,

                                    onChanged: (val) {
                                      /*change the val of title*/
                                      setState(() {
                                        bodies[3] = val;
                                      });
                                    },

                                    /*validation*/
                                    validator: (val) {
                                      if (val!.isNotEmpty && val.length >= 280) {
                                        return "Create a shorter body under 281 characters.";
                                      }
                                      if ((val.contains('&') ||
                                          val.contains("#") ||
                                          val.contains("*") ||
                                          val.contains("!") ||
                                          val.contains("%") ||
                                          val.contains("~") ||
                                          val.contains("`") ||
                                          val.contains("@") ||
                                          val.contains("^") ||
                                          val.contains("(") ||
                                          val.contains(")") ||
                                          val.contains("+") ||
                                          val.contains("=") ||
                                          val.contains("{") ||
                                          val.contains("[") ||
                                          val.contains("}") ||
                                          val.contains("]") ||
                                          val.contains("|") ||
                                          val.contains(":") ||
                                          val.contains(";") ||
                                          val.contains("<") ||
                                          val.contains(">") ||
                                          val.contains(",") ||
                                          val.contains("?") ||
                                          val.contains("/"))) {
                                        return "Body should not contain special characters. only '-', '_' and '.'.";
                                      }
                                      return null;
                                    },

                                    //for multi line
                                    minLines: 1,
                                    maxLines: 5,
                                    // allow user to enter 10 line in textfield
                                    keyboardType: TextInputType.multiline,
                                    decoration: const InputDecoration(
                                      /*background color*/
                                      fillColor: Palette.lightgrey,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 1.0, horizontal: 10),
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      hintText: "Body Of forth Page",
                                      hintStyle: TextStyle(
                                          fontSize: 18.0, color: Palette.grey),

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
                              /*end of body 4*/

                              /*image image 4*/
                              Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: IconButton(
                                    onPressed: selectImage4,
                                    icon: Icon(
                                      Icons.image,
                                      color: Palette.buttonColor,
                                      size: 35,
                                    )
                                ),
                              ),
                              /*end of image 4 icon*/

                            ],
                          ),
                          /*end of title*/

                          SizedBox(
                            height: 4,
                          ),

                          /*cover image*/
                          _image4 != null
                              ? Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                color: Palette.midgrey,
                                alignment: Alignment.centerLeft,
                                width: width - 90,
                                child: checkImgs[4] ?
                                Image(
                                  image: MemoryImage(_image4!),
                                  width: width - 90,
                                  height: hight * ((width - 90) / width),
                                  fit: ImgsLook[4],
                                ) :
                                Image(
                                  image: MemoryImage(_image4!),
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
                                        paths[4] = 'no';
                                        _image4 = null;
                                        devHight4 = 121;
                                        checkImgs[4] = true;
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

                          /*cover img look*/
                          _image4 != null ?
                          Container(
                            color: Palette.lightgrey,
                            width: width - 90,
                            child: CheckboxListTile(
                              //text
                              title: Text("Cover the entire page"),
                              //value
                              value: checkImgs[4],
                              //action
                              onChanged: (bool? value) {
                                setState(() {
                                  checkImgs[4] = !checkImgs[4];
                                });
                                if (checkImgs[4]) {
                                  setState(() {
                                    devHight4 =
                                        183 + (hight * ((width - 90) / width));
                                  });
                                } else {
                                  setState(() {
                                    devHight4 = sizeImge4[1].toDouble() + 183;
                                  });
                                }
                              },
                              //style
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: Palette.buttonColor,
                              // checkColor: Palette.buttonColor,
                            ),
                          ) :
                          SizedBox(),
                          /*end of cover img look*/

                        ],
                      )
                      /*end right*/

                    ],
                  ),
                ),
                /*end of body 4*/


                /*body  5*/
                Visibility(
                  visible: vis[4],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /*left*/
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(
                          children: [
                            /*icon*/
                            CircleAvatar(
                                radius: 13,
                                backgroundColor: Palette.grey,
                                child: Text(
                                  '5',
                                  style: TextStyle(
                                    color: Palette.backgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ),
                            /*end of icon */

                            /*divider*/
                            Container(
                              color: Colors.grey,
                              width: 3,
                              height: devHight5,
                            )
                            /*end of divider */

                          ],
                        ),
                      ),
                      /*end left */

                      /*right*/
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Row(
                            children: [
                              /*page title */
                              Text(
                                "Page 5",
                                style: TextStyle(
                                  color: Palette.textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: titleSize,
                                ),
                              ),
                              /* end of page title */

                              SizedBox(width: 193,),

                              //Delete page
                              Visibility(
                                visible: visIcon[3],
                                child: IconButton(
                                  //Remove the margin
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    //End of remove margin
                                    onPressed: () {
                                      //remove a page
                                      setState(() {
                                        vis[4] = false;
                                        counter--;
                                        //remove the image
                                        paths[5] = 'no';
                                        _image5 = null;
                                        devHight5 = 145;
                                        checkImgs[5] = true;
                                        visIcon[2] = true;
                                      });
                                      //clear the text
                                      body5Control.clear();
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color: Palette.darkGray,
                                      size: 25,
                                    )
                                ),
                              ),
                              //end delete page
                            ],
                          ),

                          SizedBox(
                            height: 16,
                          ),


                          /* body 5 */
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Form(
                                key: _formKey5,
                                child: Container(
                                  width: 235,
                                  child: TextFormField(
                                    //for disable button
                                    controller: body5Control,

                                    onChanged: (val) {
                                      /*change the val of title*/
                                      setState(() {
                                        bodies[4] = val;
                                      });
                                    },

                                    /*validation*/
                                    validator: (val) {
                                      if (val!.isNotEmpty && val.length >= 280) {
                                        return "Create a shorter body under 281 characters.";
                                      }
                                      if ((val.contains('&') ||
                                          val.contains("#") ||
                                          val.contains("*") ||
                                          val.contains("!") ||
                                          val.contains("%") ||
                                          val.contains("~") ||
                                          val.contains("`") ||
                                          val.contains("@") ||
                                          val.contains("^") ||
                                          val.contains("(") ||
                                          val.contains(")") ||
                                          val.contains("+") ||
                                          val.contains("=") ||
                                          val.contains("{") ||
                                          val.contains("[") ||
                                          val.contains("}") ||
                                          val.contains("]") ||
                                          val.contains("|") ||
                                          val.contains(":") ||
                                          val.contains(";") ||
                                          val.contains("<") ||
                                          val.contains(">") ||
                                          val.contains(",") ||
                                          val.contains("?") ||
                                          val.contains("/"))) {
                                        return "Body should not contain special characters. only '-', '_' and '.'.";
                                      }
                                      return null;
                                    },

                                    //for multi line
                                    minLines: 1,
                                    maxLines: 5,
                                    // allow user to enter 10 line in textfield
                                    keyboardType: TextInputType.multiline,
                                    decoration: const InputDecoration(
                                      /*background color*/
                                      fillColor: Palette.lightgrey,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 1.0, horizontal: 10),
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      hintText: "Body Of Fifth Page",
                                      hintStyle: TextStyle(
                                          fontSize: 18.0, color: Palette.grey),

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
                              /*end of body 5*/

                              /*image image 5*/
                              Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: IconButton(
                                    onPressed: selectImage5,
                                    icon: Icon(
                                      Icons.image,
                                      color: Palette.buttonColor,
                                      size: 35,
                                    )
                                ),
                              ),
                              /*end of image 5 icon*/

                            ],
                          ),
                          /*end of title*/

                          SizedBox(
                            height: 4,
                          ),

                          /*cover image*/
                          _image5 != null
                              ? Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                color: Palette.midgrey,
                                alignment: Alignment.centerLeft,
                                width: width - 90,
                                child: checkImgs[5] ?
                                Image(
                                  image: MemoryImage(_image5!),
                                  width: width - 90,
                                  height: hight * ((width - 90) / width),
                                  fit: ImgsLook[5],
                                ) :
                                Image(
                                  image: MemoryImage(_image5!),
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
                                        paths[5] = 'no';
                                        _image5 = null;
                                        devHight5 = 121;
                                        checkImgs[5] = true;
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

                          /*cover img look*/
                          _image5 != null ?
                          Container(
                            color: Palette.lightgrey,
                            width: width - 90,
                            child: CheckboxListTile(
                              //text
                              title: Text("Cover the entire page"),
                              //value
                              value: checkImgs[5],
                              //action
                              onChanged: (bool? value) {
                                setState(() {
                                  checkImgs[5] = !checkImgs[5];
                                });
                                if (checkImgs[5]) {
                                  setState(() {
                                    devHight5 =
                                        183 + (hight * ((width - 90) / width));
                                  });
                                } else {
                                  setState(() {
                                    devHight5 = sizeImge5[1].toDouble() + 183;
                                  });
                                }
                              },
                              //style
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: Palette.buttonColor,
                              // checkColor: Palette.buttonColor,
                            ),
                          ) :
                          SizedBox(),
                          /*end of cover img look*/

                        ],
                      )
                      /*end right*/

                    ],
                  ),
                ),
                /*end of body 5*/


                /*body 6*/
                Visibility(
                  visible: vis[5],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /*left*/
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(
                          children: [
                            /*icon*/
                            CircleAvatar(
                                radius: 13,
                                backgroundColor: Palette.grey,
                                child: Text(
                                  '6',
                                  style: TextStyle(
                                    color: Palette.backgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ),
                            /*end of icon */

                            /*divider*/
                            Container(
                              color: Colors.grey,
                              width: 3,
                              height: devHight6,
                            )
                            /*end of divider */

                          ],
                        ),
                      ),
                      /*end left */

                      /*right*/
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Row(
                            children: [
                              /*page title */
                              Text(
                                "Page 6",
                                style: TextStyle(
                                  color: Palette.textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: titleSize,
                                ),
                              ),
                              /* end of page title */

                              SizedBox(width: 193,),

                              //Delete page
                              Visibility(
                                visible: visIcon[4],
                                child: IconButton(
                                  //Remove the margin
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    //End of remove margin
                                    onPressed: () {
                                      //remove a page
                                      setState(() {
                                        vis[5] = false;
                                        counter--;
                                        //remove the image
                                        paths[6] = 'no';
                                        _image6 = null;
                                        devHight6 = 145;
                                        checkImgs[6] = true;
                                        visIcon[3] = true;
                                      });
                                      //clear the text
                                      body6Control.clear();
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color: Palette.darkGray,
                                      size: 25,
                                    )
                                ),
                              ),
                              //end delete page
                            ],
                          ),


                          SizedBox(
                            height: 16,
                          ),


                          /* body 6 */
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Form(
                                key: _formKey6,
                                child: Container(
                                  width: 235,
                                  child: TextFormField(
                                    //for disable button
                                    controller: body6Control,

                                    onChanged: (val) {
                                      /*change the val of title*/
                                      setState(() {
                                        bodies[5] = val;
                                      });
                                    },

                                    /*validation*/
                                    validator: (val) {
                                      if (val!.isNotEmpty && val.length >= 280) {
                                        return "Create a shorter body under 281 characters.";
                                      }
                                      if ((val.contains('&') ||
                                          val.contains("#") ||
                                          val.contains("*") ||
                                          val.contains("!") ||
                                          val.contains("%") ||
                                          val.contains("~") ||
                                          val.contains("`") ||
                                          val.contains("@") ||
                                          val.contains("^") ||
                                          val.contains("(") ||
                                          val.contains(")") ||
                                          val.contains("+") ||
                                          val.contains("=") ||
                                          val.contains("{") ||
                                          val.contains("[") ||
                                          val.contains("}") ||
                                          val.contains("]") ||
                                          val.contains("|") ||
                                          val.contains(":") ||
                                          val.contains(";") ||
                                          val.contains("<") ||
                                          val.contains(">") ||
                                          val.contains(",") ||
                                          val.contains("?") ||
                                          val.contains("/"))) {
                                        return "Body should not contain special characters. only '-', '_' and '.'.";
                                      }
                                      return null;
                                    },

                                    //for multi line
                                    minLines: 1,
                                    maxLines: 5,
                                    // allow user to enter 10 line in textfield
                                    keyboardType: TextInputType.multiline,
                                    decoration: const InputDecoration(
                                      /*background color*/
                                      fillColor: Palette.lightgrey,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 1.0, horizontal: 10),
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      hintText: "Body Of sixth Page",
                                      hintStyle: TextStyle(
                                          fontSize: 18.0, color: Palette.grey),

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
                              /*end of body 6*/

                              /*image image 6*/
                              Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: IconButton(
                                    onPressed: selectImage6,
                                    icon: Icon(
                                      Icons.image,
                                      color: Palette.buttonColor,
                                      size: 35,
                                    )
                                ),
                              ),
                              /*end of image icon*/

                            ],
                          ),
                          /*end of title*/

                          SizedBox(
                            height: 4,
                          ),

                          /*cover image*/
                          _image6 != null
                              ? Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                color: Palette.midgrey,
                                alignment: Alignment.centerLeft,
                                width: width - 90,
                                child: checkImgs[6] ?
                                Image(
                                  image: MemoryImage(_image6!),
                                  width: width - 90,
                                  height: hight * ((width - 90) / width),
                                  fit: ImgsLook[6],
                                ) :
                                Image(
                                  image: MemoryImage(_image6!),
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
                                        paths[6] = 'no';
                                        _image6 = null;
                                        devHight6 = 121;
                                        checkImgs[6] = true;
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

                          /*cover img look*/
                          _image6 != null ?
                          Container(
                            color: Palette.lightgrey,
                            width: width - 90,
                            child: CheckboxListTile(
                              //text
                              title: Text("Cover the entire page"),
                              //value
                              value: checkImgs[6],
                              //action
                              onChanged: (bool? value) {
                                setState(() {
                                  checkImgs[6] = !checkImgs[6];
                                });
                                if (checkImgs[6]) {
                                  setState(() {
                                    devHight6 =
                                        183 + (hight * ((width - 90) / width));
                                  });
                                } else {
                                  setState(() {
                                    devHight6 = sizeImge6[1].toDouble() + 183;
                                  });
                                }
                              },
                              //style
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: Palette.buttonColor,
                              // checkColor: Palette.buttonColor,
                            ),
                          ) :
                          SizedBox(),
                          /*end of cover img look*/

                        ],
                      )
                      /*end right*/

                    ],
                  ),
                ),
                /*end of body 6*/


                /*body 7 */
                Visibility(
                  visible: vis[6],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /*left*/
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(
                          children: [
                            /*icon*/
                            CircleAvatar(
                                radius: 13,
                                backgroundColor: Palette.grey,
                                child: Text(
                                  '7',
                                  style: TextStyle(
                                    color: Palette.backgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ),
                            /*end of icon */

                            /*divider*/
                            Container(
                              color: Colors.grey,
                              width: 3,
                              height: devHight7,
                            )
                            /*end of divider */

                          ],
                        ),
                      ),
                      /*end left */

                      /*right*/
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Row(
                            children: [
                              /*page title */
                              Text(
                                "Page 7",
                                style: TextStyle(
                                  color: Palette.textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: titleSize,
                                ),
                              ),
                              /* end of page title */

                              SizedBox(width: 193,),

                              //Delete page
                              Visibility(
                                visible: visIcon[5],
                                child: IconButton(
                                  //Remove the margin
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    //End of remove margin
                                    onPressed: () {
                                      //remove a page
                                      setState(() {
                                        vis[6] = false;
                                        counter--;
                                        //remove the image
                                        paths[7] = 'no';
                                        _image7 = null;
                                        devHight7 = 145;
                                        checkImgs[7] = true;
                                        visIcon[4] = true;
                                      });
                                      //clear the text
                                      body7Control.clear();
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color: Palette.darkGray,
                                      size: 25,
                                    )
                                ),
                              ),
                              //end delete page
                            ],
                          ),


                          SizedBox(
                            height: 16,
                          ),


                          /* body 7 */
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Form(
                                key: _formKey7,
                                child: Container(
                                  width: 235,
                                  child: TextFormField(
                                    //for disable button
                                    controller: body7Control,

                                    onChanged: (val) {
                                      /*change the val of title*/
                                      setState(() {
                                        bodies[6] = val;
                                      });
                                    },

                                    /*validation*/
                                    validator: (val) {
                                      if (val!.isNotEmpty && val.length >= 280) {
                                        return "Create a shorter body under 281 characters.";
                                      }
                                      if ((val.contains('&') ||
                                          val.contains("#") ||
                                          val.contains("*") ||
                                          val.contains("!") ||
                                          val.contains("%") ||
                                          val.contains("~") ||
                                          val.contains("`") ||
                                          val.contains("@") ||
                                          val.contains("^") ||
                                          val.contains("(") ||
                                          val.contains(")") ||
                                          val.contains("+") ||
                                          val.contains("=") ||
                                          val.contains("{") ||
                                          val.contains("[") ||
                                          val.contains("}") ||
                                          val.contains("]") ||
                                          val.contains("|") ||
                                          val.contains(":") ||
                                          val.contains(";") ||
                                          val.contains("<") ||
                                          val.contains(">") ||
                                          val.contains(",") ||
                                          val.contains("?") ||
                                          val.contains("/"))) {
                                        return "Body should not contain special characters. only '-', '_' and '.'.";
                                      }
                                      return null;
                                    },

                                    //for multi line
                                    minLines: 1,
                                    maxLines: 5,
                                    // allow user to enter 10 line in textfield
                                    keyboardType: TextInputType.multiline,
                                    decoration: const InputDecoration(
                                      /*background color*/
                                      fillColor: Palette.lightgrey,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 1.0, horizontal: 10),
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      hintText: "Body Of Seventh Page",
                                      hintStyle: TextStyle(
                                          fontSize: 18.0, color: Palette.grey),

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
                              /*end of body 7*/

                              /*image image 7*/
                              Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: IconButton(
                                    onPressed: selectImage7,
                                    icon: Icon(
                                      Icons.image,
                                      color: Palette.buttonColor,
                                      size: 35,
                                    )
                                ),
                              ),
                              /*end of image 7*/

                            ],
                          ),
                          /*end of title*/

                          SizedBox(
                            height: 4,
                          ),

                          /*cover image*/
                          _image7 != null
                              ? Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                color: Palette.midgrey,
                                alignment: Alignment.centerLeft,
                                width: width - 90,
                                child: checkImgs[7] ?
                                Image(
                                  image: MemoryImage(_image7!),
                                  width: width - 90,
                                  height: hight * ((width - 90) / width),
                                  fit: ImgsLook[7],
                                ) :
                                Image(
                                  image: MemoryImage(_image7!),
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
                                        paths[7] = 'no';
                                        _image7 = null;
                                        devHight7 = 121;
                                        checkImgs[7] = true;
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

                          /*cover img look*/
                          _image7 != null ?
                          Container(
                            color: Palette.lightgrey,
                            width: width - 90,
                            child: CheckboxListTile(
                              //text
                              title: Text("Cover the entire page"),
                              //value
                              value: checkImgs[7],
                              //action
                              onChanged: (bool? value) {
                                setState(() {
                                  checkImgs[7] = !checkImgs[7];
                                });
                                if (checkImgs[7]) {
                                  setState(() {
                                    devHight7 =
                                        183 + (hight * ((width - 90) / width));
                                  });
                                } else {
                                  setState(() {
                                    devHight7 = sizeImge7[1].toDouble() + 183;
                                  });
                                }
                              },
                              //style
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: Palette.buttonColor,
                              // checkColor: Palette.buttonColor,
                            ),
                          ) :
                          SizedBox(),
                          /*end of cover img look*/

                        ],
                      )
                      /*end right*/

                    ],
                  ),
                ),
                /*end of body 7*/


                /*body 8 */
                Visibility(
                  visible: vis[7],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /*left*/
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(
                          children: [
                            /*icon*/
                            CircleAvatar(
                                radius: 13,
                                backgroundColor: Palette.grey,
                                child: Text(
                                  '8',
                                  style: TextStyle(
                                    color: Palette.backgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ),
                            /*end of icon */

                            /*divider*/
                            Container(
                              color: Colors.grey,
                              width: 3,
                              height: devHight8,
                            )
                            /*end of divider */

                          ],
                        ),
                      ),
                      /*end left */

                      /*right*/
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Row(
                            children: [
                              /*page title */
                              Text(
                                "Page 8",
                                style: TextStyle(
                                  color: Palette.textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: titleSize,
                                ),
                              ),
                              /* end of page title */

                              SizedBox(width: 193,),

                              //Delete page
                              Visibility(
                                visible: visIcon[6],
                                child: IconButton(
                                  //Remove the margin
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    //End of remove margin
                                    onPressed: () {
                                      //remove a page
                                      setState(() {
                                        vis[7] = false;
                                        counter--;
                                        //remove the image
                                        paths[8] = 'no';
                                        _image8 = null;
                                        devHight8 = 145;
                                        checkImgs[8] = true;
                                        visIcon[5] = true;
                                      });
                                      //clear the text
                                      body8Control.clear();
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color: Palette.darkGray,
                                      size: 25,
                                    )
                                ),
                              ),
                              //end delete page
                            ],
                          ),


                          SizedBox(
                            height: 16,
                          ),


                          /* body 8 */
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Form(
                                key: _formKey8,
                                child: Container(
                                  width: 235,
                                  child: TextFormField(
                                    //for disable button
                                    controller: body8Control,

                                    onChanged: (val) {
                                      /*change the val of title*/
                                      setState(() {
                                        bodies[7] = val;
                                      });
                                    },

                                    /*validation*/
                                    validator: (val) {
                                      if (val!.isNotEmpty && val.length >= 280) {
                                        return "Create a shorter body under 281 characters.";
                                      }
                                      if ((val.contains('&') ||
                                          val.contains("#") ||
                                          val.contains("*") ||
                                          val.contains("!") ||
                                          val.contains("%") ||
                                          val.contains("~") ||
                                          val.contains("`") ||
                                          val.contains("@") ||
                                          val.contains("^") ||
                                          val.contains("(") ||
                                          val.contains(")") ||
                                          val.contains("+") ||
                                          val.contains("=") ||
                                          val.contains("{") ||
                                          val.contains("[") ||
                                          val.contains("}") ||
                                          val.contains("]") ||
                                          val.contains("|") ||
                                          val.contains(":") ||
                                          val.contains(";") ||
                                          val.contains("<") ||
                                          val.contains(">") ||
                                          val.contains(",") ||
                                          val.contains("?") ||
                                          val.contains("/"))) {
                                        return "Body should not contain special characters. only '-', '_' and '.'.";
                                      }
                                      return null;
                                    },

                                    //for multi line
                                    minLines: 1,
                                    maxLines: 5,
                                    // allow user to enter 10 line in textfield
                                    keyboardType: TextInputType.multiline,
                                    decoration: const InputDecoration(
                                      /*background color*/
                                      fillColor: Palette.lightgrey,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 1.0, horizontal: 10),
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      hintText: "Body Of eight Page",
                                      hintStyle: TextStyle(
                                          fontSize: 18.0, color: Palette.grey),

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
                              /*end of body 8*/

                              /*image image 8*/
                              Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: IconButton(
                                    onPressed: selectImage8,
                                    icon: Icon(
                                      Icons.image,
                                      color: Palette.buttonColor,
                                      size: 35,
                                    )
                                ),
                              ),
                              /*end of image 8 icon*/

                            ],
                          ),
                          /*end of title*/

                          SizedBox(
                            height: 4,
                          ),

                          /* image 8*/
                          _image8 != null
                              ? Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                color: Palette.midgrey,
                                alignment: Alignment.centerLeft,
                                width: width - 90,
                                child: checkImgs[8] ?
                                Image(
                                  image: MemoryImage(_image8!),
                                  width: width - 90,
                                  height: hight * ((width - 90) / width),
                                  fit: ImgsLook[8],
                                ) :
                                Image(
                                  image: MemoryImage(_image8!),
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
                                        paths[8] = 'no';
                                        _image8 = null;
                                        devHight8 = 121;
                                        checkImgs[8] = true;
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

                          /*cover img look*/
                          _image8 != null ?
                          Container(
                            color: Palette.lightgrey,
                            width: width - 90,
                            child: CheckboxListTile(
                              //text
                              title: Text("Cover the entire page"),
                              //value
                              value: checkImgs[8],
                              //action
                              onChanged: (bool? value) {
                                setState(() {
                                  checkImgs[8] = !checkImgs[8];
                                });
                                if (checkImgs[8]) {
                                  setState(() {
                                    devHight8 =
                                        183 + (hight * ((width - 90) / width));
                                  });
                                } else {
                                  setState(() {
                                    devHight8 = sizeImge8[1].toDouble() + 183;
                                  });
                                }
                              },
                              //style
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: Palette.buttonColor,
                              // checkColor: Palette.buttonColor,
                            ),
                          ) :
                          SizedBox(),
                          /*end of  img 8*/

                        ],
                      )
                      /*end right*/

                    ],
                  ),
                ),
                /*end of body 8*/


                /*body 9 */
                Visibility(
                  visible: vis[8],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /*left*/
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(
                          children: [
                            /*icon*/
                            CircleAvatar(
                                radius: 13,
                                backgroundColor: Palette.grey,
                                child: Text(
                                  '9',
                                  style: TextStyle(
                                    color: Palette.backgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ),
                            /*end of icon */

                            /*divider*/
                            Container(
                              color: Colors.grey,
                              width: 3,
                              height: devHight9,
                            )
                            /*end of divider */

                          ],
                        ),
                      ),
                      /*end left */

                      /*right*/
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Row(
                            children: [
                              /*page title */
                              Text(
                                "Page 9",
                                style: TextStyle(
                                  color: Palette.textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: titleSize,
                                ),
                              ),
                              /* end of page title */

                              SizedBox(width: 193,),

                              //Delete page
                              Visibility(
                                visible: visIcon[7],
                                child: IconButton(
                                  //Remove the margin
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    //End of remove margin
                                    onPressed: () {
                                      //remove a page
                                      setState(() {
                                        vis[8] = false;
                                        counter--;
                                        //remove the image
                                        paths[9] = 'no';
                                        _image9 = null;
                                        devHight9 = 145;
                                        checkImgs[9] = true;
                                        visIcon[6] = true;
                                      });
                                      //clear the text
                                      body9Control.clear();
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color: Palette.darkGray,
                                      size: 25,
                                    )
                                ),
                              ),
                              //end delete page
                            ],
                          ),


                          SizedBox(
                            height: 16,
                          ),


                          /* body 9 */
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Form(
                                key: _formKey9,
                                child: Container(
                                  width: 235,
                                  child: TextFormField(
                                    //for disable button
                                    controller: body9Control,

                                    onChanged: (val) {
                                      /*change the val of title*/
                                      setState(() {
                                        bodies[8] = val;
                                      });
                                    },

                                    /*validation*/
                                    validator: (val) {
                                      if (val!.isNotEmpty && val.length >= 280) {
                                        return "Create a shorter body under 281 characters.";
                                      }
                                      if ((val.contains('&') ||
                                          val.contains("#") ||
                                          val.contains("*") ||
                                          val.contains("!") ||
                                          val.contains("%") ||
                                          val.contains("~") ||
                                          val.contains("`") ||
                                          val.contains("@") ||
                                          val.contains("^") ||
                                          val.contains("(") ||
                                          val.contains(")") ||
                                          val.contains("+") ||
                                          val.contains("=") ||
                                          val.contains("{") ||
                                          val.contains("[") ||
                                          val.contains("}") ||
                                          val.contains("]") ||
                                          val.contains("|") ||
                                          val.contains(":") ||
                                          val.contains(";") ||
                                          val.contains("<") ||
                                          val.contains(">") ||
                                          val.contains(",") ||
                                          val.contains("?") ||
                                          val.contains("/"))) {
                                        return "Body should not contain special characters. only '-', '_' and '.'.";
                                      }
                                      return null;
                                    },

                                    //for multi line
                                    minLines: 1,
                                    maxLines: 5,
                                    // allow user to enter 10 line in textfield
                                    keyboardType: TextInputType.multiline,
                                    decoration: const InputDecoration(
                                      /*background color*/
                                      fillColor: Palette.lightgrey,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 1.0, horizontal: 10),
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      hintText: "Body Of Ninth Page",
                                      hintStyle: TextStyle(
                                          fontSize: 18.0, color: Palette.grey),

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
                              /*end of body 9*/

                              /*image image 9*/
                              Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: IconButton(
                                    onPressed: selectImage9,
                                    icon: Icon(
                                      Icons.image,
                                      color: Palette.buttonColor,
                                      size: 35,
                                    )
                                ),
                              ),
                              /*end of image 9 icon*/

                            ],
                          ),
                          /*end of title*/

                          SizedBox(
                            height: 4,
                          ),

                          /* image 9*/
                          _image9 != null
                              ? Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                color: Palette.midgrey,
                                alignment: Alignment.centerLeft,
                                width: width - 90,
                                child: checkImgs[9] ?
                                Image(
                                  image: MemoryImage(_image9!),
                                  width: width - 90,
                                  height: hight * ((width - 90) / width),
                                  fit: ImgsLook[9],
                                ) :
                                Image(
                                  image: MemoryImage(_image9!),
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
                                        paths[9] = 'no';
                                        _image9 = null;
                                        devHight9 = 121;
                                        checkImgs[9] = true;
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

                          /*cover img look*/
                          _image9 != null ?
                          Container(
                            color: Palette.lightgrey,
                            width: width - 90,
                            child: CheckboxListTile(
                              //text
                              title: Text("Cover the entire page"),
                              //value
                              value: checkImgs[9],
                              //action
                              onChanged: (bool? value) {
                                setState(() {
                                  checkImgs[9] = !checkImgs[9];
                                });
                                if (checkImgs[9]) {
                                  setState(() {
                                    devHight9 =
                                        183 + (hight * ((width - 90) / width));
                                  });
                                } else {
                                  setState(() {
                                    devHight9 = sizeImge9[1].toDouble() + 183;
                                  });
                                }
                              },
                              //style
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: Palette.buttonColor,
                              // checkColor: Palette.buttonColor,
                            ),
                          ) :
                          SizedBox(),
                          /*end of img 9*/

                        ],
                      )
                      /*end right*/

                    ],
                  ),
                ),
                /*end of body 9*/


                /*body 10 */
                Visibility(
                  visible: vis[9],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /*left*/
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(
                          children: [
                            /*icon*/
                            CircleAvatar(
                                radius: 13,
                                backgroundColor: Palette.grey,
                                child: Text(
                                  '10',
                                  style: TextStyle(
                                    color: Palette.backgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ),
                            /*end of icon */

                            /*divider*/
                            Container(
                              color: Colors.grey,
                              width: 3,
                              height: devHight10,
                            )
                            /*end of divider */

                          ],
                        ),
                      ),
                      /*end left */

                      /*right*/
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Row(
                            children: [
                              /*page title */
                              Text(
                                "Page 10",
                                style: TextStyle(
                                  color: Palette.textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: titleSize,
                                ),
                              ),
                              /* end of page title */

                              SizedBox(width: 193,),

                              //Delete page
                              Visibility(
                                visible: visIcon[8],
                                child: IconButton(
                                  //Remove the margin
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    //End of remove margin
                                    onPressed: () {
                                      //remove a page
                                      setState(() {
                                        vis[9] = false;
                                        counter--;
                                        //remove the image
                                        paths[10] = 'no';
                                        _image10 = null;
                                        devHight10 = 145;
                                        checkImgs[10] = true;
                                        visIcon[7] = true;
                                      });
                                      //clear the text
                                      body10Control.clear();
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color: Palette.darkGray,
                                      size: 25,
                                    )
                                ),
                              ),
                              //end delete page
                            ],
                          ),


                          SizedBox(
                            height: 16,
                          ),


                          /* body 10 */
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Form(
                                key: _formKey10,
                                child: Container(
                                  width: 235,
                                  child: TextFormField(
                                    //for disable button
                                    controller: body10Control,

                                    onChanged: (val) {
                                      /*change the val of title*/
                                      setState(() {
                                        bodies[9] = val;
                                      });
                                    },

                                    /*validation*/
                                    validator: (val) {
                                      if (val!.isNotEmpty && val.length >= 280) {
                                        return "Create a shorter body under 281 characters.";
                                      }
                                      if ((val.contains('&') ||
                                          val.contains("#") ||
                                          val.contains("*") ||
                                          val.contains("!") ||
                                          val.contains("%") ||
                                          val.contains("~") ||
                                          val.contains("`") ||
                                          val.contains("@") ||
                                          val.contains("^") ||
                                          val.contains("(") ||
                                          val.contains(")") ||
                                          val.contains("+") ||
                                          val.contains("=") ||
                                          val.contains("{") ||
                                          val.contains("[") ||
                                          val.contains("}") ||
                                          val.contains("]") ||
                                          val.contains("|") ||
                                          val.contains(":") ||
                                          val.contains(";") ||
                                          val.contains("<") ||
                                          val.contains(">") ||
                                          val.contains(",") ||
                                          val.contains("?") ||
                                          val.contains("/"))) {
                                        return "Body should not contain special characters. only '-', '_' and '.'.";
                                      }
                                      return null;
                                    },

                                    //for multi line
                                    minLines: 1,
                                    maxLines: 5,
                                    // allow user to enter 10 line in textfield
                                    keyboardType: TextInputType.multiline,
                                    decoration: const InputDecoration(
                                      /*background color*/
                                      fillColor: Palette.lightgrey,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 1.0, horizontal: 10),
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      hintText: "Body Of Tenth Page",
                                      hintStyle: TextStyle(
                                          fontSize: 18.0, color: Palette.grey),

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
                              /*end of body 10*/

                              /*image image 10*/
                              Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: IconButton(
                                    onPressed: selectImage10,
                                    icon: Icon(
                                      Icons.image,
                                      color: Palette.buttonColor,
                                      size: 35,
                                    )
                                ),
                              ),
                              /*end of image 10 icon*/

                            ],
                          ),
                          /*end of title*/

                          SizedBox(
                            height: 4,
                          ),

                          /* image 10*/
                          _image10 != null
                              ? Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                color: Palette.midgrey,
                                alignment: Alignment.centerLeft,
                                width: width - 90,
                                child: checkImgs[10] ?
                                Image(
                                  image: MemoryImage(_image10!),
                                  width: width - 90,
                                  height: hight * ((width - 90) / width),
                                  fit: ImgsLook[10],
                                ) :
                                Image(
                                  image: MemoryImage(_image10!),
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
                                        paths[10] = 'no';
                                        _image10 = null;
                                        devHight10 = 121;
                                        checkImgs[11] = true;
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

                          /*cover img look*/
                          _image10 != null ?
                          Container(
                            color: Palette.lightgrey,
                            width: width - 90,
                            child: CheckboxListTile(
                              //text
                              title: Text("Cover the entire page"),
                              //value
                              value: checkImgs[10],
                              //action
                              onChanged: (bool? value) {
                                setState(() {
                                  checkImgs[10] = !checkImgs[10];
                                });
                                if (checkImgs[10]) {
                                  setState(() {
                                    devHight10 =
                                        183 + (hight * ((width - 90) / width));
                                  });
                                } else {
                                  setState(() {
                                    devHight10 = sizeImge10[1].toDouble() + 183;
                                  });
                                }
                              },
                              //style
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: Palette.buttonColor,
                              // checkColor: Palette.buttonColor,
                            ),
                          ) :
                          SizedBox(),
                          /*end of  img 10*/

                        ],
                      )
                      /*end right*/

                    ],
                  ),
                ),
                /*end of body 10*/


                /*body 11 */
                Visibility(
                  visible: vis[10],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /*left*/
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(
                          children: [
                            /*icon*/
                            CircleAvatar(
                                radius: 13,
                                backgroundColor: Palette.grey,
                                child: Text(
                                  '11',
                                  style: TextStyle(
                                    color: Palette.backgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ),
                            /*end of icon */

                            /*divider*/
                            Container(
                              color: Colors.grey,
                              width: 3,
                              height: devHight11,
                            )
                            /*end of divider */

                          ],
                        ),
                      ),
                      /*end left */

                      /*right*/
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Row(
                            children: [
                              /*page title */
                              Text(
                                "Page 11",
                                style: TextStyle(
                                  color: Palette.textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: titleSize,
                                ),
                              ),
                              /* end of page title */

                              SizedBox(width: 193,),

                              //Delete page
                              Visibility(
                                visible: visIcon[9],
                                child: IconButton(
                                  //Remove the margin
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    //End of remove margin
                                    onPressed: () {
                                      //remove a page
                                      setState(() {
                                        vis[10] = false;
                                        counter--;
                                        //remove the image
                                        paths[11] = 'no';
                                        _image11 = null;
                                        devHight11 = 145;
                                        checkImgs[11] = true;
                                        visIcon[8] = true;
                                      });
                                      //clear the text
                                      body11Control.clear();
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color: Palette.darkGray,
                                      size: 25,
                                    )
                                ),
                              ),
                              //end delete page
                            ],
                          ),


                          SizedBox(
                            height: 16,
                          ),


                          /* body 11 */
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Form(
                                key: _formKey11,
                                child: Container(
                                  width: 235,
                                  child: TextFormField(
                                    //for disable button
                                    controller: body11Control,

                                    onChanged: (val) {
                                      /*change the val of title*/
                                      setState(() {
                                        bodies[10] = val;
                                      });
                                    },

                                    /*validation*/
                                    validator: (val) {
                                      if (val!.isNotEmpty && val.length >= 280) {
                                        return "Create a shorter body under 281 characters.";
                                      }
                                      if ((val.contains('&') ||
                                          val.contains("#") ||
                                          val.contains("*") ||
                                          val.contains("!") ||
                                          val.contains("%") ||
                                          val.contains("~") ||
                                          val.contains("`") ||
                                          val.contains("@") ||
                                          val.contains("^") ||
                                          val.contains("(") ||
                                          val.contains(")") ||
                                          val.contains("+") ||
                                          val.contains("=") ||
                                          val.contains("{") ||
                                          val.contains("[") ||
                                          val.contains("}") ||
                                          val.contains("]") ||
                                          val.contains("|") ||
                                          val.contains(":") ||
                                          val.contains(";") ||
                                          val.contains("<") ||
                                          val.contains(">") ||
                                          val.contains(",") ||
                                          val.contains("?") ||
                                          val.contains("/"))) {
                                        return "Body should not contain special characters. only '-', '_' and '.'.";
                                      }
                                      return null;
                                    },

                                    //for multi line
                                    minLines: 1,
                                    maxLines: 5,
                                    // allow user to enter 10 line in textfield
                                    keyboardType: TextInputType.multiline,
                                    decoration: const InputDecoration(
                                      /*background color*/
                                      fillColor: Palette.lightgrey,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 1.0, horizontal: 10),
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      hintText: "Body Of Eleventh Page",
                                      hintStyle: TextStyle(
                                          fontSize: 18.0, color: Palette.grey),

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
                              /*end of body 11*/

                              /*image image 11*/
                              Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: IconButton(
                                    onPressed: selectImage11,
                                    icon: Icon(
                                      Icons.image,
                                      color: Palette.buttonColor,
                                      size: 35,
                                    )
                                ),
                              ),
                              /*end of image 11 icon*/

                            ],
                          ),
                          /*end of title*/

                          SizedBox(
                            height: 4,
                          ),

                          /* image  11*/
                          _image11 != null
                              ? Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                color: Palette.midgrey,
                                alignment: Alignment.centerLeft,
                                width: width - 90,
                                child: checkImgs[11] ?
                                Image(
                                  image: MemoryImage(_image11!),
                                  width: width - 90,
                                  height: hight * ((width - 90) / width),
                                  fit: ImgsLook[11],
                                ) :
                                Image(
                                  image: MemoryImage(_image11!),
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
                                        paths[11] = 'no';
                                        _image11 = null;
                                        devHight11 = 121;
                                        checkImgs[11] = true;
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

                          /*cover img look*/
                          _image11 != null ?
                          Container(
                            color: Palette.lightgrey,
                            width: width - 90,
                            child: CheckboxListTile(
                              //text
                              title: Text("Cover the entire page"),
                              //value
                              value: checkImgs[11],
                              //action
                              onChanged: (bool? value) {
                                setState(() {
                                  checkImgs[11] = !checkImgs[11];
                                });
                                if (checkImgs[11]) {
                                  setState(() {
                                    devHight11 =
                                        183 + (hight * ((width - 90) / width));
                                  });
                                } else {
                                  setState(() {
                                    devHight11 = sizeImge11[1].toDouble() + 183;
                                  });
                                }
                              },
                              //style
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: Palette.buttonColor,
                              // checkColor: Palette.buttonColor,
                            ),
                          ) :
                          SizedBox(),
                          /*end of img 11*/

                        ],
                      )
                      /*end right*/

                    ],
                  ),
                ),
                /*end of body 11*/


                /*body 12 */
                Visibility(
                  visible: vis[11],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /*left*/
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(
                          children: [
                            /*icon*/
                            CircleAvatar(
                                radius: 13,
                                backgroundColor: Palette.grey,
                                child: Text(
                                  '12',
                                  style: TextStyle(
                                    color: Palette.backgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ),
                            /*end of icon */

                            /*divider*/
                            Container(
                              color: Colors.grey,
                              width: 3,
                              height: devHight12,
                            )
                            /*end of divider */

                          ],
                        ),
                      ),
                      /*end left */

                      /*right*/
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Row(
                            children: [
                              /*page title */
                              Text(
                                "Page 12",
                                style: TextStyle(
                                  color: Palette.textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: titleSize,
                                ),
                              ),
                              /* end of page title */

                              SizedBox(width: 193,),

                              //Delete page
                              Visibility(
                                visible: visIcon[10],
                                child: IconButton(
                                  //Remove the margin
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    //End of remove margin
                                    onPressed: () {
                                      //remove a page
                                      setState(() {
                                        vis[11] = false;
                                        counter--;
                                        //remove the image
                                        paths[12] = 'no';
                                        _image12 = null;
                                        devHight12 = 145;
                                        checkImgs[12] = true;
                                        visIcon[9] = true;
                                      });
                                      //clear the text
                                      body12Control.clear();
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color: Palette.darkGray,
                                      size: 25,
                                    )
                                ),
                              ),
                              //end delete page
                            ],
                          ),


                          SizedBox(
                            height: 16,
                          ),


                          /* body 12 */
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Form(
                                key: _formKey12,
                                child: Container(
                                  width: 235,
                                  child: TextFormField(
                                    //for disable button
                                    controller: body12Control,

                                    onChanged: (val) {
                                      /*change the val of title*/
                                      setState(() {
                                        bodies[11] = val;
                                      });
                                    },

                                    /*validation*/
                                    validator: (val) {
                                      if (val!.isNotEmpty && val.length >= 280) {
                                        return "Create a shorter body under 281 characters.";
                                      }
                                      if ((val.contains('&') ||
                                          val.contains("#") ||
                                          val.contains("*") ||
                                          val.contains("!") ||
                                          val.contains("%") ||
                                          val.contains("~") ||
                                          val.contains("`") ||
                                          val.contains("@") ||
                                          val.contains("^") ||
                                          val.contains("(") ||
                                          val.contains(")") ||
                                          val.contains("+") ||
                                          val.contains("=") ||
                                          val.contains("{") ||
                                          val.contains("[") ||
                                          val.contains("}") ||
                                          val.contains("]") ||
                                          val.contains("|") ||
                                          val.contains(":") ||
                                          val.contains(";") ||
                                          val.contains("<") ||
                                          val.contains(">") ||
                                          val.contains(",") ||
                                          val.contains("?") ||
                                          val.contains("/"))) {
                                        return "Body should not contain special characters. only '-', '_' and '.'.";
                                      }
                                      return null;
                                    },

                                    //for multi line
                                    minLines: 1,
                                    maxLines: 5,
                                    // allow user to enter 10 line in textfield
                                    keyboardType: TextInputType.multiline,
                                    decoration: const InputDecoration(
                                      /*background color*/
                                      fillColor: Palette.lightgrey,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 1.0, horizontal: 10),
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      hintText: "Body Of twelfth Page",
                                      hintStyle: TextStyle(
                                          fontSize: 18.0, color: Palette.grey),

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
                              /*end of body 12*/

                              /*image image 12*/
                              Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: IconButton(
                                    onPressed: selectImage12,
                                    icon: Icon(
                                      Icons.image,
                                      color: Palette.buttonColor,
                                      size: 35,
                                    )
                                ),
                              ),
                              /*end of image 12 icon*/

                            ],
                          ),
                          /*end of title*/

                          SizedBox(
                            height: 4,
                          ),

                          /* image 12*/
                          _image12 != null
                              ? Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                color: Palette.midgrey,
                                alignment: Alignment.centerLeft,
                                width: width - 90,
                                child: checkImgs[12] ?
                                Image(
                                  image: MemoryImage(_image12!),
                                  width: width - 90,
                                  height: hight * ((width - 90) / width),
                                  fit: ImgsLook[12],
                                ) :
                                Image(
                                  image: MemoryImage(_image12!),
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
                                        paths[12] = 'no';
                                        _image12 = null;
                                        devHight12 = 121;
                                        checkImgs[12] = true;
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

                          /*cover img look*/
                          _image12 != null ?
                          Container(
                            color: Palette.lightgrey,
                            width: width - 90,
                            child: CheckboxListTile(
                              //text
                              title: Text("Cover the entire page"),
                              //value
                              value: checkImgs[12],
                              //action
                              onChanged: (bool? value) {
                                setState(() {
                                  checkImgs[12] = !checkImgs[12];
                                });
                                if (checkImgs[12]) {
                                  setState(() {
                                    devHight12 =
                                        183 + (hight * ((width - 90) / width));
                                  });
                                } else {
                                  setState(() {
                                    devHight12 = sizeImge12[1].toDouble() + 183;
                                  });
                                }
                              },
                              //style
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: Palette.buttonColor,
                              // checkColor: Palette.buttonColor,
                            ),
                          ) :
                          SizedBox(),
                          /*end of img 12*/

                        ],
                      )
                      /*end right*/

                    ],
                  ),
                ),
                /*end of body 12*/


                /*body 13 */
                Visibility(
                  visible: vis[12],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /*left*/
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(
                          children: [
                            /*icon*/
                            CircleAvatar(
                                radius: 13,
                                backgroundColor: Palette.grey,
                                child: Text(
                                  '13',
                                  style: TextStyle(
                                    color: Palette.backgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ),
                            /*end of icon */

                            /*divider*/
                            Container(
                              color: Colors.grey,
                              width: 3,
                              height: devHight13,
                            )
                            /*end of divider */

                          ],
                        ),
                      ),
                      /*end left */

                      /*right*/
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Row(
                            children: [
                              /*page title */
                              Text(
                                "Page 13",
                                style: TextStyle(
                                  color: Palette.textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: titleSize,
                                ),
                              ),
                              /* end of page title */

                              SizedBox(width: 193,),

                              //Delete page
                              Visibility(
                                visible: visIcon[11],
                                child: IconButton(
                                  //Remove the margin
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    //End of remove margin
                                    onPressed: () {
                                      //remove a page
                                      setState(() {
                                        vis[12] = false;
                                        counter--;
                                        //remove the image
                                        paths[13] = 'no';
                                        _image13 = null;
                                        devHight13 = 145;
                                        checkImgs[13] = true;
                                        visIcon[10] = true;
                                      });
                                      //clear the text
                                      body13Control.clear();
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color: Palette.darkGray,
                                      size: 25,
                                    )
                                ),
                              ),
                              //end delete page
                            ],
                          ),

                          SizedBox(
                            height: 16,
                          ),


                          /* body 13 */
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Form(
                                key: _formKey13,
                                child: Container(
                                  width: 235,
                                  child: TextFormField(
                                    //for disable button
                                    controller: body13Control,

                                    onChanged: (val) {
                                      /*change the val of title*/
                                      setState(() {
                                        bodies[12] = val;
                                      });
                                    },

                                    /*validation*/
                                    validator: (val) {
                                      if (val!.isNotEmpty && val.length >= 280) {
                                        return "Create a shorter body under 281 characters.";
                                      }
                                      if ((val.contains('&') ||
                                          val.contains("#") ||
                                          val.contains("*") ||
                                          val.contains("!") ||
                                          val.contains("%") ||
                                          val.contains("~") ||
                                          val.contains("`") ||
                                          val.contains("@") ||
                                          val.contains("^") ||
                                          val.contains("(") ||
                                          val.contains(")") ||
                                          val.contains("+") ||
                                          val.contains("=") ||
                                          val.contains("{") ||
                                          val.contains("[") ||
                                          val.contains("}") ||
                                          val.contains("]") ||
                                          val.contains("|") ||
                                          val.contains(":") ||
                                          val.contains(";") ||
                                          val.contains("<") ||
                                          val.contains(">") ||
                                          val.contains(",") ||
                                          val.contains("?") ||
                                          val.contains("/"))) {
                                        return "Body should not contain special characters. only '-', '_' and '.'.";
                                      }
                                      return null;
                                    },

                                    //for multi line
                                    minLines: 1,
                                    maxLines: 5,
                                    // allow user to enter 10 line in textfield
                                    keyboardType: TextInputType.multiline,
                                    decoration: const InputDecoration(
                                      /*background color*/
                                      fillColor: Palette.lightgrey,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 1.0, horizontal: 10),
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      hintText: "Body Of Thirteenth Page",
                                      hintStyle: TextStyle(
                                          fontSize: 18.0, color: Palette.grey),

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
                              /*end of body 13*/

                              /*image image 13*/
                              Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: IconButton(
                                    onPressed: selectImage13,
                                    icon: Icon(
                                      Icons.image,
                                      color: Palette.buttonColor,
                                      size: 35,
                                    )
                                ),
                              ),
                              /*end of image 13 icon*/

                            ],
                          ),
                          /*end of title*/

                          SizedBox(
                            height: 4,
                          ),

                          /* image 13*/
                          _image13 != null
                              ? Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                color: Palette.midgrey,
                                alignment: Alignment.centerLeft,
                                width: width - 90,
                                child: checkImgs[13] ?
                                Image(
                                  image: MemoryImage(_image13!),
                                  width: width - 90,
                                  height: hight * ((width - 90) / width),
                                  fit: ImgsLook[13],
                                ) :
                                Image(
                                  image: MemoryImage(_image13!),
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
                                        paths[13] = 'no';
                                        _image13 = null;
                                        devHight13 = 121;
                                        checkImgs[13] = true;
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

                          /*cover img look*/
                          _image13 != null ?
                          Container(
                            color: Palette.lightgrey,
                            width: width - 90,
                            child: CheckboxListTile(
                              //text
                              title: Text("Cover the entire page"),
                              //value
                              value: checkImgs[13],
                              //action
                              onChanged: (bool? value) {
                                setState(() {
                                  checkImgs[13] = !checkImgs[13];
                                });
                                if (checkImgs[13]) {
                                  setState(() {
                                    devHight13 =
                                        183 + (hight * ((width - 90) / width));
                                  });
                                } else {
                                  setState(() {
                                    devHight13 = sizeImge13[1].toDouble() + 183;
                                  });
                                }
                              },
                              //style
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: Palette.buttonColor,
                              // checkColor: Palette.buttonColor,
                            ),
                          ) :
                          SizedBox(),
                          /*end of img 13*/

                        ],
                      )
                      /*end right*/

                    ],
                  ),
                ),
                /*end of body 13*/


                /*body 14 */
                Visibility(
                  visible: vis[13],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /*left*/
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(
                          children: [
                            /*icon*/
                            CircleAvatar(
                                radius: 13,
                                backgroundColor: Palette.grey,
                                child: Text(
                                  '14',
                                  style: TextStyle(
                                    color: Palette.backgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ),
                            /*end of icon */

                            /*divider*/
                            Container(
                              color: Colors.grey,
                              width: 3,
                              height: devHight14,
                            )
                            /*end of divider */

                          ],
                        ),
                      ),
                      /*end left */

                      /*right*/
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Row(
                            children: [
                              /*page title */
                              Text(
                                "Page 14",
                                style: TextStyle(
                                  color: Palette.textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: titleSize,
                                ),
                              ),
                              /* end of page title */

                              SizedBox(width: 193,),

                              //Delete page
                              Visibility(
                                visible: visIcon[12],
                                child: IconButton(
                                  //Remove the margin
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    //End of remove margin
                                    onPressed: () {
                                      //remove a page
                                      setState(() {
                                        vis[13] = false;
                                        counter--;
                                        //remove the image
                                        paths[14] = 'no';
                                        _image14 = null;
                                        devHight14 = 145;
                                        checkImgs[14] = true;
                                        visIcon[11] = true;
                                      });
                                      //clear the text
                                      body14Control.clear();
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color: Palette.darkGray,
                                      size: 25,
                                    )
                                ),
                              ),
                              //end delete page
                            ],
                          ),

                          SizedBox(
                            height: 16,
                          ),


                          /* body 14 */
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Form(
                                key: _formKey14,
                                child: Container(
                                  width: 235,
                                  child: TextFormField(
                                    //for disable button
                                    controller: body14Control,

                                    onChanged: (val) {
                                      /*change the val of title*/
                                      setState(() {
                                        bodies[13] = val;
                                      });
                                    },

                                    /*validation*/
                                    validator: (val) {
                                      if (val!.isNotEmpty && val.length >= 280) {
                                        return "Create a shorter body under 281 characters.";
                                      }
                                      if ((val.contains('&') ||
                                          val.contains("#") ||
                                          val.contains("*") ||
                                          val.contains("!") ||
                                          val.contains("%") ||
                                          val.contains("~") ||
                                          val.contains("`") ||
                                          val.contains("@") ||
                                          val.contains("^") ||
                                          val.contains("(") ||
                                          val.contains(")") ||
                                          val.contains("+") ||
                                          val.contains("=") ||
                                          val.contains("{") ||
                                          val.contains("[") ||
                                          val.contains("}") ||
                                          val.contains("]") ||
                                          val.contains("|") ||
                                          val.contains(":") ||
                                          val.contains(";") ||
                                          val.contains("<") ||
                                          val.contains(">") ||
                                          val.contains(",") ||
                                          val.contains("?") ||
                                          val.contains("/"))) {
                                        return "Body should not contain special characters. only '-', '_' and '.'.";
                                      }
                                      return null;
                                    },

                                    //for multi line
                                    minLines: 1,
                                    maxLines: 5,
                                    // allow user to enter 10 line in textfield
                                    keyboardType: TextInputType.multiline,
                                    decoration: const InputDecoration(
                                      /*background color*/
                                      fillColor: Palette.lightgrey,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 1.0, horizontal: 10),
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      hintText: "Body Of Fourteenth Page",
                                      hintStyle: TextStyle(
                                          fontSize: 18.0, color: Palette.grey),

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
                              /*end of body 14*/

                              /*image image 14*/
                              Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: IconButton(
                                    onPressed: selectImage14,
                                    icon: Icon(
                                      Icons.image,
                                      color: Palette.buttonColor,
                                      size: 35,
                                    )
                                ),
                              ),
                              /*end of image 14 icon*/

                            ],
                          ),
                          /*end of title*/

                          SizedBox(
                            height: 4,
                          ),

                          /*cover image*/
                          _image14 != null
                              ? Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                color: Palette.midgrey,
                                alignment: Alignment.centerLeft,
                                width: width - 90,
                                child: checkImgs[14] ?
                                Image(
                                  image: MemoryImage(_image14!),
                                  width: width - 90,
                                  height: hight * ((width - 90) / width),
                                  fit: ImgsLook[14],
                                ) :
                                Image(
                                  image: MemoryImage(_image14!),
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
                                        paths[14] = 'no';
                                        _image14 = null;
                                        devHight14 = 121;
                                        checkImgs[14] = true;
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

                          /*cover img look*/
                          _image14 != null ?
                          Container(
                            color: Palette.lightgrey,
                            width: width - 90,
                            child: CheckboxListTile(
                              //text
                              title: Text("Cover the entire page"),
                              //value
                              value: checkImgs[14],
                              //action
                              onChanged: (bool? value) {
                                setState(() {
                                  checkImgs[14] = !checkImgs[14];
                                });
                                if (checkImgs[14]) {
                                  setState(() {
                                    devHight14 =
                                        183 + (hight * ((width - 90) / width));
                                  });
                                } else {
                                  setState(() {
                                    devHight14 = sizeImge14[1].toDouble() + 183;
                                  });
                                }
                              },
                              //style
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: Palette.buttonColor,
                              // checkColor: Palette.buttonColor,
                            ),
                          ) :
                          SizedBox(),
                          /*end of img 14*/

                        ],
                      )
                      /*end right*/

                    ],
                  ),
                ),
                /*end of body 14*/


                /*body 15 */
                Visibility(
                  visible: vis[14],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /*left*/
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(
                          children: [
                            /*icon*/
                            CircleAvatar(
                                radius: 13,
                                backgroundColor: Palette.grey,
                                child: Text(
                                  '15',
                                  style: TextStyle(
                                    color: Palette.backgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ),
                            /*end of icon */

                          ],
                        ),
                      ),
                      /*end left */

                      /*right*/
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Row(
                            children: [
                              /*page title */
                              Text(
                                "Page 15",
                                style: TextStyle(
                                  color: Palette.textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: titleSize,
                                ),
                              ),
                              /* end of page title */

                              SizedBox(width: 193,),

                              //Delete page
                              Visibility(
                                visible: visIcon[13],
                                child: IconButton(
                                  //Remove the margin
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    //End of remove margin
                                    onPressed: () {
                                      //remove a page
                                      setState(() {
                                        vis[14] = false;
                                        counter--;
                                        //remove the image
                                        paths[15] = 'no';
                                        _image15 = null;
                                        devHight15 = 145;
                                        checkImgs[15] = true;
                                        visIcon[12] = true;
                                      });
                                      //clear the text
                                      body15Control.clear();
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color: Palette.darkGray,
                                      size: 25,
                                    )
                                ),
                              ),
                              //end delete page
                            ],
                          ),


                          SizedBox(
                            height: 16,
                          ),


                          /* body 15 */
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Form(
                                key: _formKey15,
                                child: Container(
                                  width: 235,
                                  child: TextFormField(
                                    controller: body15Control,

                                    onChanged: (val) {
                                      /*change the val of title*/
                                      setState(() {
                                        bodies[14] = val;
                                      });
                                    },

                                    /*validation*/
                                    validator: (val) {
                                      if (val!.isNotEmpty && val.length >= 280) {
                                        return "Create a shorter body under 281 characters.";
                                      }
                                      if ((val.contains('&') ||
                                          val.contains("#") ||
                                          val.contains("*") ||
                                          val.contains("!") ||
                                          val.contains("%") ||
                                          val.contains("~") ||
                                          val.contains("`") ||
                                          val.contains("@") ||
                                          val.contains("^") ||
                                          val.contains("(") ||
                                          val.contains(")") ||
                                          val.contains("+") ||
                                          val.contains("=") ||
                                          val.contains("{") ||
                                          val.contains("[") ||
                                          val.contains("}") ||
                                          val.contains("]") ||
                                          val.contains("|") ||
                                          val.contains(":") ||
                                          val.contains(";") ||
                                          val.contains("<") ||
                                          val.contains(">") ||
                                          val.contains(",") ||
                                          val.contains("?") ||
                                          val.contains("/"))) {
                                        return "Body should not contain special characters. only '-', '_' and '.'.";
                                      }
                                      return null;
                                    },

                                    //for multi line
                                    minLines: 1,
                                    maxLines: 5,
                                    // allow user to enter 10 line in textfield
                                    keyboardType: TextInputType.multiline,
                                    decoration: const InputDecoration(
                                      /*background color*/
                                      fillColor: Palette.lightgrey,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 1.0, horizontal: 10),
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      hintText: "Body Of Fifteenth Page",
                                      hintStyle: TextStyle(
                                          fontSize: 18.0, color: Palette.grey),

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
                              /*end of body 15*/

                              /*image image 15*/
                              Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: IconButton(
                                    onPressed: selectImage15,
                                    icon: Icon(
                                      Icons.image,
                                      color: Palette.buttonColor,
                                      size: 35,
                                    )
                                ),
                              ),
                              /*end of image icon*/

                            ],
                          ),
                          /*end of title*/

                          SizedBox(
                            height: 4,
                          ),

                          /* image 15*/
                          _image15 != null
                              ? Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                color: Palette.midgrey,
                                alignment: Alignment.centerLeft,
                                width: width - 90,
                                child: checkImgs[15] ?
                                Image(
                                  image: MemoryImage(_image15!),
                                  width: width - 90,
                                  height: hight * ((width - 90) / width),
                                  fit: ImgsLook[15],
                                ) :
                                Image(
                                  image: MemoryImage(_image15!),
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
                                        paths[15] = 'no';
                                        _image15 = null;
                                        devHight15 = 121;
                                        checkImgs[15] = true;
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

                          /*cover img look*/
                          _image15 != null ?
                          Container(
                            color: Palette.lightgrey,
                            width: width - 90,
                            child: CheckboxListTile(
                              //text
                              title: Text("Cover the entire page"),
                              //value
                              value: checkImgs[15],
                              //action
                              onChanged: (bool? value) {
                                setState(() {
                                  checkImgs[15] = !checkImgs[15];
                                });
                                if (checkImgs[15]) {
                                  setState(() {
                                    devHight15 =
                                        183 + (hight * ((width - 90) / width));
                                  });
                                } else {
                                  setState(() {
                                    devHight15 = sizeImge15[1].toDouble() + 183;
                                  });
                                }
                              },
                              //style
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: Palette.buttonColor,
                              // checkColor: Palette.buttonColor,
                            ),
                          ) :
                          SizedBox(),
                          /*end of img 15*/

                        ],
                      )
                      /*end right*/

                    ],
                  ),
                ),
                /*end of body 15*/


                /*add page*/
                counter != 15
                    ? Row(
                  children: [

                    /*left*/
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Column(
                        children: [

                          /*divider*/
                          Container(
                            color: Colors.grey,
                            width: 3,
                            height: 12,

                          ),
                          /*end of divider */

                          /*icon*/
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: Palette.grey,
                            child: Icon(
                              Icons.add,
                              color: Palette.backgroundColor,
                              size: 26,
                            ),
                          ),
                          /*end of icon */

                          /*divider*/
                          Container(
                            color: Palette.backgroundColor,
                            width: 3,
                            height: 12,

                          ),
                          /*end of divider */

                        ],
                      ),
                    ),
                    /*end left */

                    /*right*/
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        /*add page button*/
                        TextButton(
                          // List<bool> isButtonActive = [true, false, false,false, false, false,false, false, false,false,false, false,false,false,  false,false, false];
                          // location , rating , title, page1, page2, page3, page4, page5, page6, page7, page8, page9, page10, page11, page12, page13, page14,
                          onPressed:
                          (counter == 0 && isButtonActive[2] && isButtonActive[3])
                              || (counter == 2 &&
                              (isButtonActive[4] || paths[2]!= 'no' ||
                                  _image2 != null))
                              || (counter == 3 &&
                              (isButtonActive[5] || paths[3] != 'no' ||
                                  _image3 != null))
                              || (counter == 4 &&
                              (isButtonActive[6] || paths[4] != 'no' ||
                                  _image4 != null))
                              || (counter == 5 &&
                              (isButtonActive[7] || paths[5] != 'no' ||
                                  _image5 != null))
                              || (counter == 6 &&
                              (isButtonActive[8] || paths[6] != 'no' ||
                                  _image6 != null))
                              || (counter == 7 &&
                              (isButtonActive[9] || paths[7] != 'no' ||
                                  _image7 != null))
                              || (counter == 8 &&
                              (isButtonActive[10] || paths[8] != 'no' ||
                                  _image8 != null))
                              || (counter == 9 &&
                              (isButtonActive[11] || paths[9] != 'no' ||
                                  _image9 != null))
                              || (counter == 10 &&
                              (isButtonActive[12] || paths[10] != 'no' ||
                                  _image10 != null))
                              || (counter == 11 &&
                              (isButtonActive[13] || paths[11] != 'no' ||
                                  _image11 != null))
                              || (counter == 12 && (isButtonActive[14] ||
                              paths[12] != 'no' || _image12 != null))
                              || (counter == 13 && (isButtonActive[15] ||
                              paths[13] != 'no' || _image13 != null))
                              || (counter == 14 && (isButtonActive[16] ||
                              paths[14] != 'no' || _image14 != null))
                              ?
                              () {
                            setState(() {
                              if (counter == 0) {
                                counter++;
                              }
                              vis[counter] = true;
                              counter++;
                              if (counter == 2) {
                                visIcon[0] = true;
                              }
                              else if (counter == 3) {
                                visIcon[0] = false;
                                visIcon[1] = true;
                              }
                              else if (counter == 4) {
                                visIcon[1] = false;
                                visIcon[2] = true;
                              }
                              else if (counter == 5) {
                                visIcon[2] = false;
                                visIcon[3] = true;
                              }
                              else if (counter == 6) {
                                visIcon[3] = false;
                                visIcon[4] = true;
                              }
                              else if (counter == 7) {
                                visIcon[4] = false;
                                visIcon[5] = true;
                              }
                              else if (counter == 8) {
                                visIcon[5] = false;
                                visIcon[6] = true;
                              }
                              else if (counter == 9) {
                                visIcon[6] = false;
                                visIcon[7] = true;
                              }
                              else if (counter == 10) {
                                visIcon[7] = false;
                                visIcon[8] = true;
                              }
                              else if (counter == 11) {
                                visIcon[8] = false;
                                visIcon[9] = true;
                              }
                              else if (counter == 12) {
                                visIcon[9] = false;
                                visIcon[10] = true;
                              }
                              else if (counter == 13) {
                                visIcon[10] = false;
                                visIcon[11] = true;
                              }
                              else if (counter == 14) {
                                visIcon[11] = false;
                                visIcon[12] = true;
                              }
                              else if (counter == 15) {
                                visIcon[12] = false;
                                visIcon[13] = true;
                              }
                            });
                          }
                              : () {
                            //show msg need to full the title first
                          },
                          child:

                          Text(
                            "Add Another Page",
                            style: TextStyle(
                                color:
                                (counter == 0 && isButtonActive[2] &&
                                    isButtonActive[3])
                                    || (counter == 2 &&
                                    (isButtonActive[4] || paths[2] != 'no' ||
                                        _image2 != null))
                                    || (counter == 3 &&
                                    (isButtonActive[5] || paths[3] != 'no' ||
                                        _image3 != null))
                                    || (counter == 4 &&
                                    (isButtonActive[6] || paths[4] != 'no' ||
                                        _image4 != null))
                                    || (counter == 5 &&
                                    (isButtonActive[7] || paths[5] != 'no' ||
                                        _image5 != null))
                                    || (counter == 6 &&
                                    (isButtonActive[8] || paths[6] != 'no' ||
                                        _image6 != null))
                                    || (counter == 7 &&
                                    (isButtonActive[9] || paths[7] != 'no' ||
                                        _image7 != null))
                                    || (counter == 8 &&
                                    (isButtonActive[10] || paths[8] != 'no' ||
                                        _image8 != null))
                                    || (counter == 9 &&
                                    (isButtonActive[11] || paths[9] != 'no' ||
                                        _image9 != null))
                                    || (counter == 10 &&
                                    (isButtonActive[12] || paths[10] != 'no' ||
                                        _image10 != null))
                                    || (counter == 11 &&
                                    (isButtonActive[13] || paths[11] != 'no' ||
                                        _image11 != null))
                                    || (counter == 12 &&
                                    (isButtonActive[14] || paths[12] != 'no' ||
                                        _image12 != null))
                                    || (counter == 13 &&
                                    (isButtonActive[15] || paths[13] != 'no' ||
                                        _image13 != null))
                                    || (counter == 14 &&
                                    (isButtonActive[16] || paths[14] != 'no' ||
                                        _image14 != null))
                                    ?
                                Palette.link : Palette.darkGray,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        /*end of add page button*/

                      ],
                    )
                    /*end right*/

                  ],
                ) : Text(""),
                /*end of add page*/


                /* next button */
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50.0,
                  /* button colors */
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    gradient: isButtonActive[0] && isButtonActive[1] &&
                        isButtonActive[2] && isButtonActive[3] &&
                        isButtonActive[17]
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
                      onPressed:
                      isButtonActive[0] && isButtonActive[1] &&
                          isButtonActive[2] && isButtonActive[3] &&
                          isButtonActive[17]
                          ? () async {

                        /*make sure of the validation*/
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        if (!_formKey1.currentState!.validate()) {
                          return;
                        }
                        if (counter == 2 && !_formKey2.currentState!.validate()) {
                          return;
                        }
                        if (counter == 3 && !_formKey3.currentState!.validate()) {
                          return;
                        }
                        if (counter == 4 && !_formKey4.currentState!.validate()) {
                          return;
                        }
                        if (counter == 5 && !_formKey5.currentState!.validate()) {
                          return;
                        }
                        if (counter == 6 && !_formKey6.currentState!.validate()) {
                          return;
                        }
                        if (counter == 7 && !_formKey7.currentState!.validate()) {
                          return;
                        }
                        if (counter == 8 && !_formKey8.currentState!.validate()) {
                          return;
                        }
                        if (counter == 9 && !_formKey9.currentState!.validate()) {
                          return;
                        }
                        if (counter == 10 &&
                            !_formKey10.currentState!.validate()) {
                          return;
                        }
                        if (counter == 11 &&
                            !_formKey11.currentState!.validate()) {
                          return;
                        }
                        if (counter == 12 &&
                            !_formKey12.currentState!.validate()) {
                          return;
                        }
                        if (counter == 13 &&
                            !_formKey13.currentState!.validate()) {
                          return;
                        }
                        if (counter == 14 &&
                            !_formKey14.currentState!.validate()) {
                          return;
                        }
                        if (counter == 15 &&
                            !_formKey15.currentState!.validate()) {
                          return;
                        }

                        setState(() {
                          isLoaded = true;
                        });
                        bool isDone = true;
                        while(true) {
                          await Future.delayed(const Duration(seconds: 1), () {
                            print("wait1");
                            for (int i = 0; i < loading.length; i++) {
                              if (loading[i]) {
                                isDone = false;
                                print("hi");
                              }
                            }
                          });
                          if (isDone) {
                            print("submit?");
                            submitPost();
                            break;
                          }
                          isDone = true;
                        }
                      } : null,
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
                /* end of next button  */


              ],
            ),
          ),
        ),
      ),
    );
  }

  /*functions*/

  submitPost() async{

    /*Data preprocessing*/
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var userData = {};
    var userSnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();
    if (userSnap.data() != null)
      userData = userSnap.data()!;

    if(counter==0)
      counter++;

    if (bodies[counter-1].isEmpty && paths[counter]=='no')
      counter--;

    /*save post to database*/
    addPostToDatabase(
      /*user info*/
      uid,


      /*place type*/
      country,
      city,
      locationTypes,
      locationType,
      locationId,

      /*place info*/
      postId,
      locationName,
      locationAdress,
      rating.toDouble(),

      /*visibility*/
      "public",

      /*date*/
      dateTime,

      /*content*/
      title,
      bodies,
      paths,
      checkImgs,
      counter,
    );
    /*end of save post*/

    /*disable button and clear text field */
    setState(() {
      for (int i = 0; i < isButtonActive.length; i++) {
        isButtonActive[i] = false;
      }
      titleControl.clear();
    });
    /*end of disable button and clear text field */

    /*go home */
    Navigator.pushNamed(context, '/navigationBar');
  }

  List<int> imageSize(Uint8List data) {
    Uint8List resizedData = data;
    IMG.Image img = IMG.decodeImage(data)!;
    List<int> size = [ img.width,  img.height];
    return size;
  }


  /*for Location*/
  Future<void> _handlePressButton() async {
    //Search places box
    Prediction? place = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        components: [_selectedCountry.code.isEmpty?Component(Component.country,"SA"):Component(Component.country,_selectedCountry.code)]
    );
    //End Search places box

    //save place information
    if(place!=null) {
      /*design*/
      setState(() {
        devHightType = 90;
        isButtonActive[0] = true;
      });
      setState(() {
        locationAdress = place?.description ?? " ";
        int index = locationAdress.indexOf(',') ?? 0,//1
            index2 = locationAdress.indexOf('-') ?? 0;
        if(index ==-1)
          index = index2;
        else if(index2!= -1 && index2 < index)
          index = index2;
        if(index!=-1) {
          locationName = locationAdress.substring(0, index);
          int index3 = locationAdress.indexOf(country, index + 1) ?? 0;
          if(index3 != -1)
            city =  index ==index2?locationAdress.substring(0, index3 - 2) ?? "":locationAdress.substring(0, index3 - 1) ?? "";
          print(city);
        }
        int index4 = city.lastIndexOf(","),
            index7 = city.lastIndexOf("-"),
            index5 = city.lastIndexOf("،");
        if (index5 > index4)
          index4 = index5;
        if(index7 > index4)
          index4 = index7;
        if(index4 != -1)
          city = city.substring(index4 + 2);
      });
      setState(() {
        locationTypes = place?.types ?? [];
        if (locationTypes.indexOf("establishment") != -1)
          locationTypes.removeAt(locationTypes.indexOf("establishment"));
        if (locationTypes.indexOf("point_of_interest") != -1)
          locationTypes.removeAt(locationTypes.indexOf("point_of_interest"));

        for (int i = 1; i < locationTypes.length; i++) {
          devHightType += 47;
          numbers.add(0);
        }
      });
      setState(() {
        locationId = place.placeId ?? "";
      });
    }
    print(city);
    print(locationAdress);
    print(locationName);
  }

  /*End Location*/


  /*for date*/
  Widget buildDatePicker() => SizedBox(
    height: 180,
    child: CupertinoDatePicker(
      minimumYear: DateTime.now().year - 4,
      maximumYear: DateTime.now().year,
      maximumDate:
      DateTime(dayfromnow.year, dayfromnow.month, dayfromnow.day),
      initialDateTime: DateTime(
          dateTime.year, dateTime.month, dateTime.day),
      mode: CupertinoDatePickerMode.date,
      onDateTimeChanged: (dateTime) =>
          setState(() => this.dateTime = dateTime),
    ),
  );

  /*images*/
  /*cover image*/
  void selectCoverImage() async {

    Uint8List im= await pickImage(ImageSource.gallery);
    List<int> size = imageSize(im);
    size[1]= (((width-90)/ size[0]) * size[1]).toInt();
    setState(() {
      loading[0]=true;
      _Coverimage = im;
      sizeImge = size;
      devHight = 159 + (hight*((width-90)/width));
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("posts/"+uid+"/"+postId+"/CoverImages", _Coverimage!, true);

      setState(() {
        paths[0] =p;
        loading[0]=false;
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
  /*end of cover image*/


  /* image1 */
  void selectImage1() async {

    Uint8List im= await pickImage(ImageSource.gallery);
    List<int> size = imageSize(im);
    size[1]= (((width-90)/ size[0]) * size[1]).toInt();
    setState(() {
      loading[1]=true;
      _image1 = im;
      sizeImge1 = size;
      devHight1 = 183 + (hight*((width-90)/width));
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("posts/"+uid+"/"+postId+"/image1",_image1!, true);

      setState(() {
        paths[1] =p;
        loading[1]=false;
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
  /* end of image2 */

  /* image3 */
  void selectImage2() async {

    Uint8List im= await pickImage(ImageSource.gallery);
    List<int> size = imageSize(im);
    size[1]= (((width-90)/ size[0]) * size[1]).toInt();
    setState(() {
      loading[2]=true;
      _image2 = im;
      sizeImge2 = size;
      devHight2 = 183 + (hight*((width-90)/width));
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("posts/"+uid+"/"+postId+"/image2",_image2!, true);

      setState(() {
        paths[2] =p;
        loading[2]=false;
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
  /* end of image2 */


  /* image3 */
  void selectImage3() async {

    Uint8List im= await pickImage(ImageSource.gallery);
    List<int> size = imageSize(im);
    size[1]= (((width-90)/ size[0]) * size[1]).toInt();
    setState(() {
      loading[3]=true;
      _image3 = im;
      sizeImge3 = size;
      devHight3 = 183 + (hight*((width-90)/width));
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("posts/"+uid+"/"+postId+"/image3",_image3!, true);

      setState(() {
        paths[3] =p;
        loading[3]=false;
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
  /* end of image3 */


/* image4 */
  void selectImage4() async {

    Uint8List im= await pickImage(ImageSource.gallery);
    List<int> size = imageSize(im);
    size[1]= (((width-90)/ size[0]) * size[1]).toInt();
    setState(() {
      loading[4]=true;
      _image4 = im;
      sizeImge4 = size;
      devHight4 = 183 + (hight*((width-90)/width));
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("posts/"+uid+"/"+postId+"/image4",_image4!, true);

      setState(() {
        paths[4] =p;
        loading[4]=false;
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
/* end of image4 */


/* image5 */
  void selectImage5() async {

    Uint8List im= await pickImage(ImageSource.gallery);
    List<int> size = imageSize(im);
    size[1]= (((width-90)/ size[0]) * size[1]).toInt();
    setState(() {
      loading[5]=true;
      _image5 = im;
      sizeImge5 = size;
      devHight5 = 183 + (hight*((width-90)/width));
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("posts/"+uid+"/"+postId+"/image5",_image5!, true);

      setState(() {
        paths[5] =p;
        loading[5]=false;
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
/* end of image5 */

/* image6 */
  void selectImage6() async {

    Uint8List im= await pickImage(ImageSource.gallery);
    List<int> size = imageSize(im);
    size[1]= (((width-90)/ size[0]) * size[1]).toInt();
    setState(() {
      loading[6]=true;
      _image6 = im;
      sizeImge6 = size;
      devHight6 = 183 + (hight*((width-90)/width));
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("posts/"+uid+"/"+postId+"/image6",_image6!, true);

      setState(() {
        paths[6] =p;
        loading[6]=false;
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
/* end of image6 */


/* image7 */
  void selectImage7() async {

    Uint8List im= await pickImage(ImageSource.gallery);
    List<int> size = imageSize(im);
    size[1]= (((width-90)/ size[0]) * size[1]).toInt();
    setState(() {
      loading[7]=true;
      _image7 = im;
      sizeImge7 = size;
      devHight7 = 183 + (hight*((width-90)/width));
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("posts/"+uid+"/"+postId+"/image7",_image7!, true);

      setState(() {
        paths[7] =p;
        loading[7]=false;
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
/* end of image7 */


/* image8 */
  void selectImage8() async {

    Uint8List im= await pickImage(ImageSource.gallery);
    List<int> size = imageSize(im);
    size[1]= (((width-90)/ size[0]) * size[1]).toInt();
    setState(() {
      loading[8]=true;
      _image8 = im;
      sizeImge8 = size;
      devHight8 = 183 + (hight*((width-90)/width));
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("posts/"+uid+"/"+postId+"/image8",_image8!, true);

      setState(() {
        paths[8] =p;
        loading[8]=false;
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
/* end of image8 */


/* image9 */
  void selectImage9() async {

    Uint8List im= await pickImage(ImageSource.gallery);
    List<int> size = imageSize(im);
    size[1]= (((width-90)/ size[0]) * size[1]).toInt();
    setState(() {
      loading[9]=true;
      _image9 = im;
      sizeImge9 = size;
      devHight9 = 183 + (hight*((width-90)/width));
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("posts/"+uid+"/"+postId+"/image9",_image9!, true);

      setState(() {
        paths[9] =p;
        loading[9]=false;
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
/* end of image9 */


/* image10 */
  void selectImage10() async {

    Uint8List im= await pickImage(ImageSource.gallery);
    List<int> size = imageSize(im);
    size[1]= (((width-90)/ size[0]) * size[1]).toInt();
    setState(() {
      loading[10]=true;
      _image10 = im;
      sizeImge10 = size;
      devHight10 = 183 + (hight*((width-90)/width));
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("posts/"+uid+"/"+postId+"/image10",_image10!, true);

      setState(() {
        paths[10] =p;
        loading[10]=false;
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
/* end of image10 */


/* image11 */
  void selectImage11() async {

    Uint8List im= await pickImage(ImageSource.gallery);
    List<int> size = imageSize(im);
    size[1]= (((width-90)/ size[0]) * size[1]).toInt();
    setState(() {
      loading[11]=true;
      _image11 = im;
      sizeImge11 = size;
      devHight11 = 183 + (hight*((width-90)/width));
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("posts/"+uid+"/"+postId+"/image11",_image11!, true);

      setState(() {
        paths[11] =p;
        loading[11]=false;
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
/* end of image11 */

/* image12 */
  void selectImage12() async {

    Uint8List im= await pickImage(ImageSource.gallery);
    List<int> size = imageSize(im);
    size[1]= (((width-90)/ size[0]) * size[1]).toInt();
    setState(() {
      loading[12]=true;
      _image12 = im;
      sizeImge12 = size;
      devHight12 = 183 + (hight*((width-90)/width));
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("posts/"+uid+"/"+postId+"/image12",_image12!, true);

      setState(() {
        paths[12] =p;
        loading[12]=false;
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
/* end of image12 */

/* image13 */
  void selectImage13() async {

    Uint8List im= await pickImage(ImageSource.gallery);
    List<int> size = imageSize(im);
    size[1]= (((width-90)/ size[0]) * size[1]).toInt();
    setState(() {
      loading[13]=true;
      _image13 = im;
      sizeImge13 = size;
      devHight13 = 183 + (hight*((width-90)/width));
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("posts/"+uid+"/"+postId+"/image13",_image13!, true);

      setState(() {
        paths[13] =p;
        loading[13]=false;
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
/* end of image13 */

/* image14 */
  void selectImage14() async {

    Uint8List im= await pickImage(ImageSource.gallery);
    List<int> size = imageSize(im);
    size[1]= (((width-90)/ size[0]) * size[1]).toInt();
    setState(() {
      loading[14]=true;
      _image14 = im;
      sizeImge14 = size;
      devHight14 = 183 + (hight*((width-90)/width));
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("posts/"+uid+"/"+postId+"/image14",_image14!, true);

      setState(() {
        paths[14] =p;
        loading[14]=false;
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
/* end of image14 */


/* image15 */
  void selectImage15() async {

    Uint8List im= await pickImage(ImageSource.gallery);
    List<int> size = imageSize(im);
    size[1]= (((width-90)/ size[0]) * size[1]).toInt();
    setState(() {
      loading[15]=true;
      _image15 = im;
      sizeImge15 = size;
      devHight15 = 183 + (hight*((width-90)/width));
    });


    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("posts/"+uid+"/"+postId+"/image15",_image15!, true);

      setState(() {
        paths[15] =p;
        loading[15]=false;
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
/* end of image15*/
}
//country

class CountryDetail extends StatefulWidget {
  final Country? country;

  CountryDetail({Key? key, required this.country}) : super(key: key);
  @override
  _CountryDetailState createState() => _CountryDetailState();
}

class _CountryDetailState extends State<CountryDetail> {
  Widget dataWidget(String key, int value) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery
              .of(context)
              .size
              .width * 0.15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('$key:'),
          SizedBox(
            width: 16,
          ),
          Flexible(
            child: Text(
              '$value',
              style: TextStyle(fontSize: 30),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text("");
  }
}
//end of country