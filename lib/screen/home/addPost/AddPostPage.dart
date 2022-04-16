import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gp1_7_2022/screen/home/addPost/utils.dart';
import 'package:intl/intl.dart';

import '../../../config/palette.dart';

class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  DateTime dateTime = DateTime.now();
  var dayfromnow = DateTime.now().add(new Duration(hours: 1));
  int rating = 0;
  String visit = "";
  List<bool> isButtonActive = [true, false]; // location , rating ,

  @override
  Widget build(BuildContext context) =>
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
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Palette.textColor),
                onPressed: () => Navigator.pushNamed(context, '/navigationBar'),
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



        //fix overload error
        resizeToAvoidBottomInset: false,

        body: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*rating text*/
                    rating != 0
                        ? RichText(
                      text: TextSpan(
                          text: "Rate of your visit: ",
                          style: TextStyle(
                            color: Palette.textColor,
                            fontWeight:
                                FontWeight.w500,
                            fontSize: 20,
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
                                fontSize: 20,
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

                    SizedBox(height: 16),

                    /*date of visit*/
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      height: 50.0,
                      /* button */
                      child: RichText(
                        text: TextSpan(
                            text: visit.isEmpty
                                ? 'Pick date of visit'
                                : 'Change date of visit ',
                            style: TextStyle(
                              color: Palette.textColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                            children: <TextSpan>[
                            ]),
                      ),
                    ),
                    /* end of date of visit */

                    /*date*/
                    Container(
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
                    /*end of date*/
                  ],
                ),
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
                  onPressed:
                      isButtonActive[0] && isButtonActive[1] ? () {

                        Navigator.pushNamed(context, '/ContentOfPost');
                      } : null,
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
      );

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
}
