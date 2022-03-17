import 'package:flutter/material.dart';
import 'package:gp1_7_2022/config/palette.dart';



class question1 extends StatefulWidget {
  @override
  _question1State createState() => _question1State();
}



class _question1State extends State<question1> {
    static const quest1 = <String> ['Yes.', 'No.'];
    String selectedQuest1 = "";
    bool isButtonActive = false;


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
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: const Center(
            child:Text(
              "Tell Us About Yourself!",
              style: TextStyle(
                fontSize: 30,
                color: Palette.textColor,
              ),
            ),
          ),

        ),

          Container(
            margin:  const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 5),
            child:const Center(
              child: Text(
              //  "Answer the following to personalize your experience in Odyssey.",
                "This information won't be listed in your profile.",
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
                "Are you married?",
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
                Navigator.pushNamed(context, '/question2');
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




Widget buildRadios() => Column(
  children: quest1.map(
      (value){
  return RadioListTile<String>(
  value: value,
  groupValue: selectedQuest1,
  title: Text(value,
   style: TextStyle(
       fontSize: 20,
       color: Palette.textColor),
),
  onChanged: (value) => setState(() { this.selectedQuest1 = value!;
  isButtonActive = true;
      }),
      );
      },
      ).toList(),
      );

}

