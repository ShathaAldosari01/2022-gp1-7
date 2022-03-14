import 'package:flutter/material.dart';
import 'package:gp1_7_2022/config/palette.dart';



class question2 extends StatefulWidget {
  @override
  _question2State createState() => _question2State();
}



class _question2State extends State<question2> {

  final items2 = ['item 1', 'item 2', 'item 3', 'item 4', 'item 5'];
  String? value;


  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        elevation: 0,//no shadow
        automaticallyImplyLeading: false,//no arrow
      ),


    body: Column(

        children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: const Center(
            child:Text(
              "Tell us about yourself!",
              style: TextStyle(
                fontSize: 30,
                color: Palette.textColor,
              ),
            ),
          ),

        ),

          Container(
            margin:  const EdgeInsets.symmetric(horizontal: 40),
            padding: const EdgeInsets.symmetric(vertical: 5),
            child:const Center(
              child: Text(
                "Answer the following questions to personalize your experience in Odyssey.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Palette.grey,
                ),
              ),
            ),
          ),








          Container(
          //  margin:  const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 40),
            child:const Center(
              child: Text(
                "Question 2",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ),



      Container(

        margin: EdgeInsets.all(20),
       // width: 370,
        padding: EdgeInsets.symmetric(horizontal:15, vertical:0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        iconSize: 36,
        icon: Icon(Icons.arrow_drop_down, color: Colors.black),
        items: items2.map(buildMenuItem).toList(),
        onChanged: (value) => setState(() => this.value = value),
      ),
    ),
    ),








/*next button*/
          Container(

            margin: EdgeInsets.symmetric(vertical: 70),
            alignment: Alignment.center,
            width: 350,
            height: 50.0,
            /*button colors*/
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              gradient: LinearGradient(
                  colors: [
                    Palette.buttonColor,
                    Palette.nameColor,
                  ]
              ),
            ),


            /*button*/
            child: ButtonTheme(
              height: 50.0,
              minWidth: 350,
              child: FlatButton(onPressed: (){
                /*go to sign up page*/
                Navigator.pushNamed(context, '/question3');
              },
                child: Text('Next',
                  style: TextStyle(
                    color: Palette.backgroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          /*end of next button */




  ],
    ),
  );






  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      );

  }

