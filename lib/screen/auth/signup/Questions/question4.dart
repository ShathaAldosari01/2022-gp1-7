import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp1_7_2022/config/palette.dart';
import 'package:gp1_7_2022/model/SignUpCheckboxes.dart';
import 'package:rflutter_alert/rflutter_alert.dart';



class question4 extends StatefulWidget {
  @override
  _question4State createState() => _question4State();
}



class _question4State extends State<question4> {

  final checkboxes = [
    SignUpCheckboxes(title: 'Middle-eastern countries.', name: "Middle eastern"),
    SignUpCheckboxes(title: 'Asian countries.', name: "Asian"),
    SignUpCheckboxes(title: 'European countries.', name: "European"),
    SignUpCheckboxes(title: 'American countries.', name: "American"),
    SignUpCheckboxes(title: 'African countries.', name: "African"),
  ];
  bool isButtonActive = false;
  //database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int a= 0, b= 0, c= 0, d = 0 , e= 0;
  //user id
  var uid= FirebaseAuth.instance.currentUser!.uid;
  /*user data*/
  var userData = {};

  /* get data method */
  getData() async {
    try {
      if (uid != null) {
        //we have uid
        var userSnap = await FirebaseFirestore.instance.collection('users').doc(
            uid).get();
        if(userSnap.data()!=null) {
          //we have user data
          userData = userSnap.data()!;
          print(uid);

          setState(() {
            a =  userData['questions']["countries"]["Middle eastern"];
            b =  userData['questions']["countries"]["Asian"];
            c =  userData['questions']["countries"]["European"];
            d =  userData['questions']["countries"]["American"];
            e =  userData['questions']["countries"]["African"];


            //a
            if(a.toString().compareTo("0")==0){
              checkboxes[0].value= false;
            }
            if(a.toString().compareTo("1")==0){
              checkboxes[0].value= true;
              isButtonActive = true;
            }
            //b
            if(b.toString().compareTo("0")==0){
              checkboxes[1].value= false;
            }
            if(b.toString().compareTo("1")==0){
              checkboxes[1].value= true;
              isButtonActive = true;
            }
            //c
            if(c.toString().compareTo("0")==0){
              checkboxes[2].value= false;
            }
            if(c.toString().compareTo("1")==0){
              checkboxes[2].value= true;
              isButtonActive = true;
            }
            //d
            if(d.toString().compareTo("0")==0){
              checkboxes[3].value= false;
            }
            if(d.toString().compareTo("1")==0){
              checkboxes[3].value= true;
              isButtonActive = true;
            }
            //e
            if(e.toString().compareTo("0")==0){
              checkboxes[4].value= false;
            }
            if(e.toString().compareTo("1")==0){
              checkboxes[4].value= true;
              isButtonActive = true;
            }

          });

        }else
          Navigator.of(context).popAndPushNamed('/Signup_Login');
      }
    }
    catch(e){
      Alert(
        context: context,
        title: "Invalid input!",
        desc: e.toString(),
      ).show();
    }

  }

  @override
  void initState(){
    super.initState();
    //getting user info
    getData();

  }

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
              checkboxes.forEach(
                      (checkbox) async {
                    if(checkbox.value){
                      await addAnswer("countries",checkbox.name, 1);
                    }else{
                      await addAnswer("countries",checkbox.name, 0);
                    }
                  }
              );
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

  Future<void> addAnswer(String question,String q,  int answer) async {
    try{
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot snap = await _firestore.collection('users').doc(uid).get();
      await _firestore.collection('users').doc(uid).update({
        "questions."+question+"."+q : answer
      });

    }catch(e){
      print(e.toString());
    }
  }

}

