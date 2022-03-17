import 'package:flutter/material.dart';
import 'package:gp1_7_2022/config/palette.dart';
import 'package:gp1_7_2022/model/SignUpCheckboxes.dart';



class question4 extends StatefulWidget {
  @override
  _question4State createState() => _question4State();
}



class _question4State extends State<question4> {

  final checkboxes = [
    SignUpCheckboxes(title: 'Middle-eastern countries.'),
    SignUpCheckboxes(title: 'Asian countries.'),
    SignUpCheckboxes(title: 'European countries.'),
    SignUpCheckboxes(title: 'American countries.'),
    SignUpCheckboxes(title: 'African countries.'),
  ];
  bool isButtonActive = false;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Palette.backgroundColor,
    appBar: AppBar(
      backgroundColor: Palette.backgroundColor,
      foregroundColor: Palette.textColor,
      elevation: 0,//no shadow
      /*back arrow */
      leading: IconButton(
        icon: const Icon(
            Icons.arrow_back, color: Palette.textColor
        ),
        onPressed: () => Navigator.pushNamed(context, '/question3'),
      ),
    ),


    body: Column(

      children: [

        Container(
          margin:  const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(vertical: 40),
          child:const Center(
            child: Text(
              "Which countries do you most like traveling to? Check all that applies.",
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
          margin: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10),
          alignment: Alignment.center,
          width: 350,
          height: 50.0,
          /*button colors*/
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            gradient: isButtonActive?
            LinearGradient(
                colors: [
                  Palette.buttonColor,
                  Palette.nameColor,
                ]
            )
                : LinearGradient(
                colors: [
                  Palette.buttonDisableColor,
                  Palette.nameDisablColor,
                ]
            ),
          ),


          /*button*/
          child: ButtonTheme(
            height: 50.0,
            minWidth: 350,
            child: FlatButton(onPressed: isButtonActive? (){
              /*go to question 2 page*/
              Navigator.pushNamed(context, '/question5');
            } :null,
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



  Widget buildSingleCheckbox(SignUpCheckboxes checkbox) => buildCheckbox(
    checkboxes: checkbox,
    onClicked: (){
      setState(() {
        final newValue = !checkbox.value;
        checkbox.value = newValue;
        bool isTrue = false;
        checkboxes.forEach(
                (checkbox){
              if(checkbox.value){
                isTrue = true;
              }
            }
        );
        isButtonActive = isTrue;
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

