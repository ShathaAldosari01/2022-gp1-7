
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


// country
import 'package:gp1_7_2022/model/country_model.dart';
import 'package:searchfield/searchfield.dart';

// API
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';



class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}
//API key
const kGoogleApiKey = 'AIzaSyCckhVmNilRBCInrm087ZQr0WxR1u3AbhU';

class _AddPostPageState extends State<AddPostPage> {
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
      final isActiveTitle = titleControl.text.isNotEmpty ;
      setState(() {
        this.isButtonActive[2]=isActiveTitle ;
      });
    });
    //end of title
    //body1
    body1Control = TextEditingController();
    body1Control.addListener(() {
      final isActiveBody1 = body1Control.text.isNotEmpty ;
      setState(() {
        this.isButtonActive[3]=isActiveBody1 ;
      });
    });
    //end of body1

    //body2
    body2Control = TextEditingController();
    body2Control.addListener(() {
      final isActiveBody2 = body2Control.text.isNotEmpty ;
      setState(() {
        this.isButtonActive[4]=isActiveBody2 ;
      });
    });
    //end of body2

    //body3
    body3Control = TextEditingController();
    body3Control.addListener(() {
      final isActiveBody3 = body3Control.text.isNotEmpty ;
      setState(() {
        this.isButtonActive[5]=isActiveBody3 ;
      });
    });
    //end of body3

    //body4
    body4Control = TextEditingController();
    body4Control.addListener(() {
      final isActiveBody4 = body4Control.text.isNotEmpty ;
      setState(() {
        this.isButtonActive[6]=isActiveBody4 ;
      });
    });
    //end of body4

    //body5
    body5Control = TextEditingController();
    body5Control.addListener(() {
      final isActiveBody5 = body5Control.text.isNotEmpty ;
      setState(() {
        this.isButtonActive[7]=isActiveBody5 ;
      });
    });
    //end of body5

    //body6
    body6Control = TextEditingController();
    body6Control.addListener(() {
      final isActiveBody6 = body6Control.text.isNotEmpty ;
      setState(() {
        this.isButtonActive[8]=isActiveBody6 ;
      });
    });
    //end of body6

    //body7
    body7Control = TextEditingController();
    body7Control.addListener(() {
      final isActiveBody7 = body7Control.text.isNotEmpty ;
      setState(() {
        this.isButtonActive[9]=isActiveBody7 ;
      });
    });
    //end of body7

    //body8
    body8Control = TextEditingController();
    body8Control.addListener(() {
      final isActiveBody8 = body8Control.text.isNotEmpty ;
      setState(() {
        this.isButtonActive[10]=isActiveBody8 ;
      });
    });
    //end of body8

    //body9
    body9Control = TextEditingController();
    body9Control.addListener(() {
      final isActiveBody9 = body9Control.text.isNotEmpty ;
      setState(() {
        this.isButtonActive[11]=isActiveBody9 ;
      });
    });
    //end of body9

    //body10
    body10Control = TextEditingController();
    body10Control.addListener(() {
      final isActiveBody10 = body10Control.text.isNotEmpty ;
      setState(() {
        this.isButtonActive[12]=isActiveBody10 ;
      });
    });
    //end of body10

    //body11
    body11Control = TextEditingController();
    body11Control.addListener(() {
      final isActiveBody11 = body11Control.text.isNotEmpty ;
      setState(() {
        this.isButtonActive[13]=isActiveBody11 ;
      });
    });
    //end of body11

    //body12
    body12Control = TextEditingController();
    body12Control.addListener(() {
      final isActiveBody12 = body12Control.text.isNotEmpty ;
      setState(() {
        this.isButtonActive[14]=isActiveBody12 ;
      });
    });
    //end of body12

    //body13
    body13Control = TextEditingController();
    body13Control.addListener(() {
      final isActiveBody13 = body13Control.text.isNotEmpty ;
      setState(() {
        this.isButtonActive[15]=isActiveBody13 ;
      });
    });
    //end of body13

    //body14
    body14Control = TextEditingController();
    body14Control.addListener(() {
      final isActiveBody14 = body14Control.text.isNotEmpty ;
      setState(() {
        this.isButtonActive[16]=isActiveBody14 ;
      });
    });
    //end of body14


  }

  /*attributes*/
  final focus = FocusNode();
  List<Country> countries = [];
  Country _selectedCountry = Country.init();
  //end country

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
  List<bool> isButtonActive = [false, false, false,false, false, false,false, false, false,false,false, false,false,false,  false,false, false,false];
  // location , rating , title, page1, page2, page3, page4, page5, page6, page7, page8, page9, page10, page11, page12, page13, page14,category

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
  List<bool> vis = [true, false,false,false,false,false,false,false,false,false,false,false,false,false, false];
  int  counter = 0;// cont the pages
  int maxImgs = 15;

  /*hight*/
  int devHight = 121;
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

  //for disable for done button
  late TextEditingController titleControl ;
  late TextEditingController body1Control ;
  late TextEditingController body2Control ;
  late TextEditingController body3Control ;
  late TextEditingController body4Control ;
  late TextEditingController body5Control ;
  late TextEditingController body6Control ;
  late TextEditingController body7Control ;
  late TextEditingController body8Control ;
  late TextEditingController body9Control ;
  late TextEditingController body10Control ;
  late TextEditingController body11Control ;
  late TextEditingController body12Control ;
  late TextEditingController body13Control ;
  late TextEditingController body14Control ;

  /*title size*/
  double titleSize= 18;

  //Location
  String locationId="";
  String locationName = "";
  String locationAdress = "";
  List<String> locationTypes = [];
  String locationType = "";
  List<int> numbers = [0];
  List<Color> typeTextColor = [Palette.textColor, Palette.backgroundColor];
  List<Color> typeBackgroundColor = [Palette.midgrey, Palette.buttonColor, Palette.nameColor,];
  List<Color> typeBorderColor = [Palette.grey, Palette.buttonDisableColor];






  @override
  Widget build(BuildContext context) =>
      /* back button on devise */
  WillPopScope(
    onWillPop: () async{
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
                  icon: const Icon(Icons.arrow_back, color: Palette.textColor),
                  onPressed: () => Navigator.pushNamed(context, '/navigationBar'),
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
                          child:Text("C",
                              style:TextStyle(
                                color:Palette.backgroundColor,
                                 fontWeight:FontWeight.bold  ,
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
                                    SearchFieldListItem(country.name, item: country))
                                    .toList(),
                                suggestionState: Suggestion.expand,
                                controller: _searchController,
                                hint: 'Search by country name',
                                maxSuggestionsInViewPort: 4,
                                itemHeight: 45,
                                inputType: TextInputType.text,
                                onSuggestionTap: (SearchFieldListItem<Country> x) {
                                  setState(() {
                                    _selectedCountry = x.item!;
                                  });
                                  focus.unfocus();
                                },
                                searchInputDecoration:  const InputDecoration(
                                  /*background color*/
                                  fillColor: Palette.lightgrey,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: "Search by country name",
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
                          height:!isButtonActive[0]? 77:200,
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
                         style:TextStyle(
                             fontSize: titleSize,
                             fontWeight: FontWeight.w500,
                         ),
                     ),
                      /*end of Location text*/

                      isButtonActive[0]
                          ? SizedBox(height: 12)
                          :SizedBox(),

                      /*Location */
                      /*location info*/
                      locationName.isNotEmpty?
                      Container(
                       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        color: Palette.midgrey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /*Name*/
                            locationName.isNotEmpty?
                            Container(
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
                                              fontWeight: FontWeight.normal ,
                                            )
                                        ),
                                      ]
                                  ),
                                )
                            ) :SizedBox(),
                            /* End of Name */

                            isButtonActive[0]
                                ? SizedBox(height: 8)
                                :SizedBox(),

                            /*Address*/
                            locationAdress.isNotEmpty?
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
                                              fontWeight: FontWeight.normal ,
                                            )
                                        ),
                                      ]
                                  ),
                                )
                            ) :SizedBox(),
                            /* End of Address */
                          ],
                        ),
                      ):SizedBox(),


                      SizedBox(height: 12),

                      /* Location button */
                      Container(
                        width:150,
                        alignment: Alignment.center,
                        height: 50.0,
                        /* button colors */
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          gradient:  _selectedCountry.code.toString().isNotEmpty
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
                            _selectedCountry.code.toString().isNotEmpty
                                ? _handlePressButton
                                :null,
                            child: Text(
                              !isButtonActive[0]
                                  ?'Choose Place'
                              :'Change Place',
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
                visible: isButtonActive[0]&&locationName.isNotEmpty,
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
                                Icons.all_inbox_rounded ,
                                color:Colors.white
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
                                for ( var i =0;i< locationTypes.length; i++)
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),

                                    // to make corner rounded
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          typeBackgroundColor[numbers[i]],
                                          typeBackgroundColor[numbers[i]*2],
                                        ]),
                                        border: Border.all(
                                          color: typeBorderColor[numbers[i]],
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    // End of corner rounded

                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: Size(50, 30),
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          alignment: Alignment.center),
                                      child: Text(
                                        locationTypes[i],
                                        style: TextStyle(
                                          color: typeTextColor[numbers[i]],
                                          fontSize: 16,
                                        ),
                                      ),
                                      onPressed: (){
                                        //save type
                                        locationType = locationTypes[i];
                                        print(locationType);
                                        //change style
                                        //1A) reverse the colors
                                        int num = numbers[i];

                                        //2) remove from all
                                        setState(() {
                                          for(int j=0; j<numbers.length; j++){
                                            if(numbers[j]==1){
                                              numbers[j]=0;
                                            }
                                          }
                                        });

                                        //1B) reverse the colors
                                        if(num==0)
                                        setState(() {
                                            numbers[i] = 1;
                                        });
                                        bool flag = false;
                                         for(int j=0; j<numbers.length; j++){
                                           if(numbers[j]==1){
                                             flag=true;
                                           }
                                         }
                                         setState(() {
                                           isButtonActive[17]= flag;
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
                        onRatingUpdate: (rating) => setState(() {
                          this.rating = rating.toInt();
                          isButtonActive[1] = true;
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
                          onTap:  () {
                            Utils.showSheet(context, child: buildDatePicker(),
                                onClicked: () {
                                  setState(() {
                                    visit = DateFormat.yMMMMd('en_US').format(dateTime);
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
                            contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),

                            /*hint*/
                            border: OutlineInputBorder(),
                            hintText: visit.isNotEmpty? "$visit" :DateFormat.yMMMMd('en_US').format(dateTime),
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
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Column(
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
                  ),
                  /*end left */

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
                          Container(
                            width: 235,
                            child: TextFormField(
                              //for disable for the done button
                              controller: titleControl,

                              decoration: const InputDecoration(
                                /*background color*/
                                fillColor: Palette.lightgrey,
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),

                                /*hint*/
                                border: OutlineInputBorder(),
                                hintText: "Title Of Post",
                                hintStyle: TextStyle(fontSize: 18.0, color: Palette.grey, height: 2.0,),

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
                        height: 16,
                      ),

                      /*cover image*/
                      path != "no"
                          ? Container(
                          alignment: Alignment.centerLeft,
                          height: 150,
                          width:250,
                          child: Image.network(path))
                          : Text(""),
                      /*end of cover img*/

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
                            Container(
                              width: 235,
                              child: TextFormField(
                                //for disable button
                                controller: body1Control ,
                                //for multi line
                                minLines: 1,
                                maxLines: 5,  // allow user to enter 10 line in textfield
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  /*background color*/
                                  fillColor: Palette.lightgrey,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
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
                          height: 16,
                        ),

                        /*cover image*/
                        path1 != "no"
                            ? Container(
                            alignment: Alignment.centerLeft,
                            height: 150,
                            width:250,
                            child: Image.network(path1))
                            : Text(""),
                        /*end of cover img*/

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
                              child:Text(
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

                        SizedBox(
                          height: 16,
                        ),


                        /* body 2 */
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 235,
                              child: TextFormField(
                                //for disable button
                                controller: body2Control,

                                //for multi line
                                minLines: 1,
                                maxLines: 5,  // allow user to enter 10 line in textfield
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  /*background color*/
                                  fillColor: Palette.lightgrey,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
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
                          height: 16,
                        ),

                        /*cover image*/
                        path2 != "no"
                            ? Container(
                            alignment: Alignment.centerLeft,
                            height: 150,
                            width:250,
                            child: Image.network(path2))
                            : Text(""),
                        /*end of cover img*/

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
                        Text(
                          "Page 3",
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


                        /* body 3 */
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 235,
                              child: TextFormField(
                                //for disable button
                                controller: body3Control,

                                //for multi line
                                minLines: 1,
                                maxLines: 5,  // allow user to enter 10 line in testified
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  /*background color*/
                                  fillColor: Palette.lightgrey,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: "Body Of Thread Page",
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
                          height: 16,
                        ),

                        /*cover image*/
                        path3 != "no"
                            ? Container(
                            alignment: Alignment.centerLeft,
                            height: 150,
                            width:250,
                            child: Image.network(path3))
                            : Text(""),
                        /*end of cover img*/

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

                        SizedBox(
                          height: 16,
                        ),


                        /* body 4 */
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 235,
                              child: TextFormField(
                                //for disable button
                                controller: body4Control,

                                //for multi line
                                minLines: 1,
                                maxLines: 5,  // allow user to enter 10 line in textfield
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  /*background color*/
                                  fillColor: Palette.lightgrey,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: "Body Of forth Page",
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
                          height: 16,
                        ),

                        /*cover image*/
                        path4 != "no"
                            ? Container(
                            alignment: Alignment.centerLeft,
                            height: 150,
                            width:250,
                            child: Image.network(path4))
                            : Text(""),
                        /*end of cover img*/

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

                        SizedBox(
                          height: 16,
                        ),


                        /* body 5 */
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 235,
                              child: TextFormField(
                                //for disable button
                                controller: body5Control,

                                //for multi line
                                minLines: 1,
                                maxLines: 5,  // allow user to enter 10 line in textfield
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  /*background color*/
                                  fillColor: Palette.lightgrey,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: "Body Of Fifth Page",
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
                          height: 16,
                        ),

                        /*cover image*/
                        path5 != "no"
                            ? Container(
                            alignment: Alignment.centerLeft,
                            height: 150,
                            width:250,
                            child: Image.network(path5))
                            : Text(""),
                        /*end of img 5*/

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

                        SizedBox(
                          height: 16,
                        ),


                        /* body 6 */
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 235,
                              child: TextFormField(
                                //for disable button
                                controller: body6Control,

                                //for multi line
                                minLines: 1,
                                maxLines: 5,  // allow user to enter 10 line in textfield
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  /*background color*/
                                  fillColor: Palette.lightgrey,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: "Body Of sixth Page",
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
                          height: 16,
                        ),

                        /*cover image*/
                        path6 != "no"
                            ? Container(
                            alignment: Alignment.centerLeft,
                            height: 150,
                            width:250,
                            child: Image.network(path6))
                            : Text(""),
                        /*end of img 6*/

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
                              child:Text(
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

                        SizedBox(
                          height: 16,
                        ),


                        /* body 7 */
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 235,
                              child: TextFormField(
                                //for disable button
                                controller: body7Control,

                                //for multi line
                                minLines: 1,
                                maxLines: 5,  // allow user to enter 10 line in textfield
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  /*background color*/
                                  fillColor: Palette.lightgrey,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: "Body Of Seventh Page",
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
                          height: 16,
                        ),

                        /*cover image*/
                        path7 != "no"
                            ? Container(
                            alignment: Alignment.centerLeft,
                            height: 150,
                            width:250,
                            child: Image.network(path7))
                            : Text(""),
                        /*end of  img 7*/

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

                        SizedBox(
                          height: 16,
                        ),


                        /* body 8 */
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 235,
                              child: TextFormField(
                                //for disable button
                                controller: body8Control,

                                //for multi line
                                minLines: 1,
                                maxLines: 5,  // allow user to enter 10 line in textfield
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  /*background color*/
                                  fillColor: Palette.lightgrey,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: "Body Of eight Page",
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
                          height: 16,
                        ),

                        /* image 8*/
                        path8 != "no"
                            ? Container(
                            alignment: Alignment.centerLeft,
                            height: 150,
                            width:250,
                            child: Image.network(path8))
                            : Text(""),
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

                        SizedBox(
                          height: 16,
                        ),


                        /* body 9 */
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 235,
                              child: TextFormField(
                                //for disable button
                                controller: body9Control,

                                //for multi line
                                minLines: 1,
                                maxLines: 5,  // allow user to enter 10 line in textfield
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  /*background color*/
                                  fillColor: Palette.lightgrey,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: "Body Of Ninth Page",
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
                          height: 16,
                        ),

                        /* image 9*/
                        path9 != "no"
                            ? Container(
                            alignment: Alignment.centerLeft,
                            height: 150,
                            width:250,
                            child: Image.network(path9))
                            : Text(""),
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

                        SizedBox(
                          height: 16,
                        ),


                        /* body 10 */
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 235,
                              child: TextFormField(
                                //for disable button
                                controller: body10Control,

                                //for multi line
                                minLines: 1,
                                maxLines: 5,  // allow user to enter 10 line in textfield
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  /*background color*/
                                  fillColor: Palette.lightgrey,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: "Body Of Tenth Page",
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
                          height: 16,
                        ),

                        /* image 10*/
                        path10 != "no"
                            ? Container(
                            alignment: Alignment.centerLeft,
                            height: 150,
                            width:250,
                            child: Image.network(path10))
                            : Text(""),
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

                        SizedBox(
                          height: 16,
                        ),


                        /* body 11 */
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 235,
                              child: TextFormField(
                                //for disable button
                                controller: body11Control,

                                //for multi line
                                minLines: 1,
                                maxLines: 5,  // allow user to enter 10 line in textfield
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  /*background color*/
                                  fillColor: Palette.lightgrey,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: "Body Of Eleventh Page",
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
                          height: 16,
                        ),

                        /* image  11*/
                        path11 != "no"
                            ? Container(
                            alignment: Alignment.centerLeft,
                            height: 150,
                            width:250,
                            child: Image.network(path11))
                            : Text(""),
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
                              child:Text(
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

                        SizedBox(
                          height: 16,
                        ),


                        /* body 12 */
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 235,
                              child: TextFormField(
                                //for disable button
                                controller: body12Control,

                                //for multi line
                                minLines: 1,
                                maxLines: 5,  // allow user to enter 10 line in textfield
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  /*background color*/
                                  fillColor: Palette.lightgrey,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: "Body Of twelfth Page",
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
                          height: 16,
                        ),

                        /* image 12*/
                        path12 != "no"
                            ? Container(
                            alignment: Alignment.centerLeft,
                            height: 150,
                            width:250,
                            child: Image.network(path12))
                            : Text(""),
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

                        SizedBox(
                          height: 16,
                        ),


                        /* body 13 */
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 235,
                              child: TextFormField(
                                //for disable button
                                controller: body13Control,

                                //for multi line
                                minLines: 1,
                                maxLines: 5,  // allow user to enter 10 line in textfield
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  /*background color*/
                                  fillColor: Palette.lightgrey,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: "Body Of Thirteenth Page",
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
                          height: 16,
                        ),

                        /* image 13*/
                        path13 != "no"
                            ? Container(
                            alignment: Alignment.centerLeft,
                            height: 150,
                            width:250,
                            child: Image.network(path13))
                            : Text(""),
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

                        SizedBox(
                          height: 16,
                        ),


                        /* body 14 */
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 235,
                              child: TextFormField(
                                //for disable button
                                controller: body14Control,

                                //for multi line
                                minLines: 1,
                                maxLines: 5,  // allow user to enter 10 line in textfield
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  /*background color*/
                                  fillColor: Palette.lightgrey,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: "Body Of Fourteenth Page",
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
                          height: 16,
                        ),

                        /*cover image*/
                        path14 != "no"
                            ? Container(
                            alignment: Alignment.centerLeft,
                            height: 150,
                            width:250,
                            child: Image.network(path14))
                            : Text(""),
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

                        SizedBox(
                          height: 16,
                        ),


                        /* body 15 */
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 235,
                              child: TextFormField(
                                //for multi line
                                minLines: 1,
                                maxLines: 5,  // allow user to enter 10 line in textfield
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  /*background color*/
                                  fillColor: Palette.lightgrey,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: "Body Of Fifteenth Page",
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
                          height: 16,
                        ),

                        /* image 15*/
                        path15 != "no"
                            ? Container(
                            alignment: Alignment.centerLeft,
                            height: 150,
                            width:250,
                            child: Image.network(path15))
                            : Text(""),
                        /*end of img 15*/

                      ],
                    )
                    /*end right*/

                  ],
                ),
              ),
              /*end of body 15*/



              /*add page*/
              counter !=15
                  ?Row(
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
                        (counter ==0 && isButtonActive[2] && isButtonActive[3])
                            ||(counter ==2 && (isButtonActive[4] || path2 != 'no'))
                            ||(counter ==3 && (isButtonActive[5] || path3 != 'no'))
                            ||(counter ==4 && (isButtonActive[6] || path4 != 'no'))
                            ||(counter ==5 && (isButtonActive[7] || path5 != 'no'))
                            ||(counter ==6 && (isButtonActive[8] || path6 != 'no'))
                            ||(counter ==7 && (isButtonActive[9] || path7 != 'no'))
                            ||(counter ==8 && (isButtonActive[10] || path8 != 'no'))
                            ||(counter ==9 && (isButtonActive[11] || path9 != 'no'))
                            ||(counter ==10 && (isButtonActive[12] || path10 != 'no'))
                            ||(counter ==11 && (isButtonActive[13] || path11 != 'no'))
                            ||(counter ==12 && (isButtonActive[14] || path12 != 'no'))
                            ||(counter ==13 && (isButtonActive[15] || path13 != 'no'))
                            ||(counter ==14 && (isButtonActive[16] || path14 != 'no'))
                            ?
                            (){
                          setState(() {
                            if(counter==0){
                              counter++;
                            }
                            vis[counter]=true;
                            counter++;
                          });
                        }
                            :(){
                          //show msg need to full the title first
                        },
                        child:

                        Text(
                          "Add Another Page",
                          style: TextStyle(
                              color:
                              (counter ==0 && isButtonActive[2] && isButtonActive[3])
                                  ||(counter ==2 && (isButtonActive[4] || path2 != 'no'))
                                  ||(counter ==3 && (isButtonActive[5] || path3 != 'no'))
                                  ||(counter ==4 && (isButtonActive[6] || path4 != 'no'))
                                  ||(counter ==5 && (isButtonActive[7] || path5 != 'no'))
                                  ||(counter ==6 && (isButtonActive[8] || path6 != 'no'))
                                  ||(counter ==7 && (isButtonActive[9] || path7 != 'no'))
                                  ||(counter ==8 && (isButtonActive[10] || path8 != 'no'))
                                  ||(counter ==9 && (isButtonActive[11] || path9 != 'no'))
                                  ||(counter ==10 && (isButtonActive[12] || path10 != 'no'))
                                  ||(counter ==11 && (isButtonActive[13] || path11 != 'no'))
                                  ||(counter ==12 && (isButtonActive[14] || path12 != 'no'))
                                  ||(counter ==13 && (isButtonActive[15] || path13 != 'no'))
                                  ||(counter ==14 && (isButtonActive[16] || path14 != 'no'))
                                  ?
                              Palette.link: Palette.darkGray,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      /*end of add page button*/

                    ],
                  )
                  /*end right*/

                ],
              ):Text(""),
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
                  gradient:   isButtonActive[0] && isButtonActive[1] &&  isButtonActive[2] &&  isButtonActive[3] && isButtonActive[17]
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
                    isButtonActive[0] && isButtonActive[1] &&  isButtonActive[2] &&  isButtonActive[3] && isButtonActive[17]
                        ? () {
                      /*save post to database*/

                      /*end of save post*/

                      /*disable button and clear text field */
                      setState(() {
                        for(int i=0 ; i < isButtonActive.length ; i++){
                          isButtonActive[i] = false;
                        }
                        titleControl.clear();
                      });
                      /*end of disable button and clear text field */

                      /*go home */
                      Navigator.pushNamed(context, '/navigationBar');
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

  /*functions*/


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
    if(place!=null)
     setState(() {
       devHightType = 90;
       isButtonActive[0] = true;
       locationAdress = place?.description??"";
       locationName = locationAdress.substring(0,place?.description?.indexOf(','))??"";
       locationTypes= place?.types??[];
       locationTypes.removeAt(locationTypes.indexOf("establishment"));
       locationTypes.removeAt(locationTypes.indexOf("point_of_interest"));

       for(int i=1; i< locationTypes.length; i++){
         devHightType+=47;
         numbers.add(0);
       }
     });
     print(locationTypes);
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
    setState(() {
      _Coverimage = im;
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("CoverImages", _Coverimage!, false);

      setState(() {
        path =p;
        devHight +=134;
      });
      //to do: post id
      await _firestore.collection("posts").doc(uid).set({
        'postID': {
          'images': {
            'cover': p,
            'image1': "no",
            'image2': "no",
            'image3': "no",
            'image4': "no",
            'image5': "no",
            'image6': "no",
            'image7': "no",
            'image8': "no",
            'image9': "no",
            'image10': "no",
            'image11': "no",
            'image12': "no",
            'image13': "no",
            'image14': "no",
            'image15': "no",
          },
        },
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
    setState(() {
      _image1 = im;
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("image1",_image1!, false);

      setState(() {
        path1 =p;
        devHight1 +=134;
      });
      //to do: post id
      await _firestore.collection("posts").doc(uid).set({
        'postID.images.image1': p,
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
    setState(() {
      _image2 = im;
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("image2",_image2!, false);

      setState(() {
        path2 =p;
        devHight2 +=134;
      });
      //to do: post id
      await _firestore.collection("posts").doc(uid).set({
        'postID.images.image2': p,
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
    setState(() {
      _image3 = im;
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("image3",_image3!, false);

      setState(() {
        path3 =p;
        devHight3 +=134;
      });
      //to do: post id
      await _firestore.collection("posts").doc(uid).set({
        'postID.images.image3': p,
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
    setState(() {
      _image4 = im;
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("image4",_image4!, false);

      setState(() {
        path4 =p;
        devHight4 +=134;
      });
      //to do: post id
      await _firestore.collection("posts").doc(uid).set({
        'postID.images.image4': p,
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
    setState(() {
      _image5 = im;
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("image5",_image5!, false);

      setState(() {
        path5 =p;
        devHight5 +=134;
      });
      //to do: post id
      await _firestore.collection("posts").doc(uid).set({
        'postID.images.image5': p,
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
    setState(() {
      _image6 = im;
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("image6",_image6!, false);

      setState(() {
        path6 =p;
        devHight6 +=134;
      });
      //to do: post id
      await _firestore.collection("posts").doc(uid).set({
        'postID.images.image6': p,
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
    setState(() {
      _image7 = im;
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("image7",_image7!, false);

      setState(() {
        path7 =p;
        devHight7 +=134;
      });
      //to do: post id
      await _firestore.collection("posts").doc(uid).set({
        'postID.images.image7': p,
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
    setState(() {
      _image8 = im;
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("image8",_image8!, false);

      setState(() {
        path8 =p;
        devHight8 +=134;
      });
      //to do: post id
      await _firestore.collection("posts").doc(uid).set({
        'postID.images.image8': p,
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
    setState(() {
      _image9 = im;
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("image9",_image9!, false);

      setState(() {
        path9 =p;
        devHight9 +=134;
      });
      //to do: post id
      await _firestore.collection("posts").doc(uid).set({
        'postID.images.image9': p,
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
    setState(() {
      _image10 = im;
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("image10",_image10!, false);

      setState(() {
        path10 =p;
        devHight10 +=134;
      });
      //to do: post id
      await _firestore.collection("posts").doc(uid).set({
        'postID.images.image10': p,
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
    setState(() {
      _image11 = im;
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("image11",_image11!, false);

      setState(() {
        path11 =p;
        devHight11 +=134;
      });
      //to do: post id
      await _firestore.collection("posts").doc(uid).set({
        'postID.images.image11': p,
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
    setState(() {
      _image12 = im;
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("image12",_image12!, false);

      setState(() {
        path12 =p;
        devHight12 +=134;
      });
      //to do: post id
      await _firestore.collection("posts").doc(uid).set({
        'postID.images.image12': p,
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
    setState(() {
      _image13 = im;
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("image13",_image13!, false);

      setState(() {
        path13 =p;
        devHight13 +=134;
      });
      //to do: post id
      await _firestore.collection("posts").doc(uid).set({
        'postID.images.image13': p,
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
    setState(() {
      _image14 = im;
    });

    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("image14",_image14!, false);

      setState(() {
        path14 =p;
        devHight14 +=134;
      });
      //to do: post id
      await _firestore.collection("posts").doc(uid).set({
        'postID.images.image14': p,
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
    setState(() {
      _image15 = im;
    });


    /*update to database*/
    try {
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      String p = await StorageMethods().uploadImageToStorage("image15",_image15!, false);

      setState(() {
        path15 =p;
        devHight15 +=134;
      });
      //to do: post id
      await _firestore.collection("posts").doc(uid).set({
        'postID.images.image15': p,
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