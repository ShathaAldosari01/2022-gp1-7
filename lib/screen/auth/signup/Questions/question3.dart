import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp1_7_2022/config/palette.dart';
import 'package:gp1_7_2022/model/SignUpCheckboxes.dart';
import 'package:rflutter_alert/rflutter_alert.dart';



class question3 extends StatefulWidget {
  @override
  _question3State createState() => _question3State();
}



class _question3State extends State<question3> {

  final checkboxes = [
    SignUpCheckboxes(title: 'Business.', name: "Business"),
    SignUpCheckboxes(title: 'Tourism.', name: "Tourism"),
    SignUpCheckboxes(title: 'Visiting family/friends.', name: "Visiting family and friends"),
  ];
  bool isButtonActive = false;
  //database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int a= 0, b= 0, c= 0;
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
            a =  userData['questions']["purpose"]["Business"];
            b =  userData['questions']["purpose"]["Tourism"];
            c =  userData['questions']["purpose"]["Visiting family and friends"];

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
        onPressed: () => Navigator.pushNamed(context, '/question2'),
      ),
    ),


    body: Column(

      children: [

        Container(
          margin:  const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(vertical: 40),
          child:const Center(
            child: Text(
              "What is the purpose of your trips? Check all that applies.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
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
                      await addAnswer("purpose",checkbox.name, 1);
                    }else{
                      await addAnswer("purpose",checkbox.name, 0);
                    }
                  }
              );
              /*go to question 2 page*/
              Navigator.pushNamed(context, '/question4');
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

