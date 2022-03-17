import 'package:flutter/material.dart';
import 'package:gp1_7_2022/config/palette.dart';



class question2 extends StatefulWidget {
  @override
  _question2State createState() => _question2State();
}



class _question2State extends State<question2> {
  static const quest2 = <String> ['Yes.', 'No.'];
  String selectedQuest2 = "";


  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Palette.backgroundColor,
    appBar: AppBar(
      backgroundColor: Palette.backgroundColor,
      elevation: 0,//no shadow
      automaticallyImplyLeading: false,//no arrow
    ),


    body: ListView(
      padding: EdgeInsets.symmetric(vertical: 16),
      children: [


        Container(
          margin:  const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(vertical: 40),
          child:const Center(
            child: Text(
              "Do you have children?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),


        buildRadios(),



/*next button*/
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10),
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
              /*go to question 3 page*/
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




  Widget buildRadios() => Column(
    children: quest2.map(
          (value){
        return RadioListTile<String>(
          value: value,
          groupValue: selectedQuest2,
          title: Text(value,
            style: TextStyle(
                fontSize: 20,
                color: Palette.textColor),
          ),
          onChanged: (value) =>  setState(() => this.selectedQuest2 = value!),
        );
      },
    ).toList(),
  );

}

