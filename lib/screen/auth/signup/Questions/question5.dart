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
        onPressed: () => Navigator.pushNamed(context, '/question4'),
      ),
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
              Navigator.pushNamed(context, '/Profile_Page');
            } :null,
              child: Text('Sign Up',
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

