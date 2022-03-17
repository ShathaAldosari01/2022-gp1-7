import 'package:flutter/material.dart';
import 'package:gp1_7_2022/config/palette.dart';
import 'package:gp1_7_2022/model/SignUpCheckboxes.dart';



class question5 extends StatefulWidget {
  @override
  _question5State createState() => _question5State();
}



class _question5State extends State<question5> {

  final checkboxes = [
    SignUpCheckboxes(title: 'Restaurants/cafes.'),
    SignUpCheckboxes(title: 'Museums.'),
    SignUpCheckboxes(title: 'Shopping malls.'),
    SignUpCheckboxes(title: 'Parks.'),
    SignUpCheckboxes(title: 'Sports attractions (golf, bowling, tennis,...).'),


  ];

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
          margin:  const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(vertical: 40),
          child:const Center(
            child: Text(
              "Which places do you enjoy visiting while traveling? Check all that applies.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),





        ...checkboxes.map(buildSingleCheckbox).toList(),



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
              /*go to profile page page*/
              Navigator.pushNamed(context, '/Profile_Page');
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



  Widget buildSingleCheckbox(SignUpCheckboxes checkboxes) => buildCheckbox(
    checkboxes: checkboxes,
    onClicked: (){
      setState(() {
        final newValue = !checkboxes.value;
        checkboxes.value = newValue;
      });
    },
  );



  Widget buildCheckbox({
    required SignUpCheckboxes checkboxes,
    required VoidCallback onClicked,


  }) => ListTile(
      onTap: onClicked,
      leading: Checkbox(
        value: checkboxes.value,
        onChanged: (value) => onClicked(),
      ),
      title: Text(
        checkboxes.title,
        style: TextStyle(
            fontSize: 20,
        ),

      )
  );



}

