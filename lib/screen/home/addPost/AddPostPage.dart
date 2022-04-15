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
  double rating = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Palette.backgroundColor,

        appBar: AppBar(
          //appBar style
          elevation: 0,
          backgroundColor: Palette.backgroundColor,
          automaticallyImplyLeading: false, //no arrow
          //username
          // centerTitle: true,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    textColor: Palette.textColor,
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed('/navigationBar');
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
                      "Add Post",
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
                      "",
                      style:
                      TextStyle(fontSize: 18, color: Palette.backgroundColor),
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

        //fix overload error
        resizeToAvoidBottomInset: false,

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              rating!=0
                  ?Text(
                    'Rate of your visit: $rating',
                    style: TextStyle(fontSize: 20),
                  )
                  :Text(
                    'Rate your visit',
                    style: TextStyle(fontSize: 20),
                  ),
              SizedBox(height: 32),
              RatingBar.builder(
                minRating: 1,
                itemSize: 30,
                itemPadding: EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context, _) =>
                    Icon(Icons.star, color: Palette.buttonColor),
                updateOnDrag: true,
                onRatingUpdate: (rating) => setState(() {
                  this.rating = rating;
                }),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                alignment: Alignment.center,
                width: double.infinity,
                height: 50.0,
                /*button*/
                child: ButtonTheme(
                  height: 50.0,
                  child: TextButton(
                    onPressed: () {
                      Utils.showSheet(
                          context,
                          child: buildDatePicker(),
                          onClicked: () {
                            final value = DateFormat('MM/dd/yyyy').format(dateTime);
                            Utils.showSnackBar(context, 'Date of visit: $value');
                        Navigator.pop(context);
                      });
                    },
                    child: Text(
                      'Pick date of visit',
                      style: TextStyle(
                        color: Palette.buttonColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
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
              DateTime.now().year, DateTime.now().month, DateTime.now().day),
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) =>
              setState(() => this.dateTime = dateTime),
        ),
      );
}
