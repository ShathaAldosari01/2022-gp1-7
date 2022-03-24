import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp1_7_2022/config/palette.dart';
import 'package:rflutter_alert/rflutter_alert.dart';



class question2 extends StatefulWidget {
  @override
  _question2State createState() => _question2State();
}



class _question2State extends State<question2> {
  static const quest2 = <String> ['Yes.', 'No.'];
  String selectedQuest2 = "";
  bool isButtonActive = false;
  //database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int children = -1;
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

          setState(() {
            children =  userData['questions']["children"];
            print(children.toString());
            if(children.toString().compareTo("0")==0){
              this.selectedQuest2 = "No.";
              isButtonActive = true;
            } if(children.toString().compareTo("1")==0){
              this.selectedQuest2 = "Yes.";
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
        title: "Something went wrong!",
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
        onPressed: () => Navigator.pushNamed(context, '/question1'),
      ),
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
              if(this.selectedQuest2.toString().compareTo("No.")==0){
                addAnswer("children", 0);
              }else if(this.selectedQuest2.toString().compareTo("Yes.")==0){
                addAnswer("children", 1);
              }
              /*go to question 2 page*/
              Navigator.pushNamed(context, '/question3');
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
          onChanged: (value) => setState(() { this.selectedQuest2 = value!;
          isButtonActive = true;
          }),
        );
      },
    ).toList(),
  );



  Future<void> addAnswer(String question, int answer) async {
    try{
      var uid =   FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot snap = await _firestore.collection('users').doc(uid).get();
      // List questions = (snap.data()! as dynamic)['questions'];
      await _firestore.collection('users').doc(uid).update({
        "questions."+question : answer
      });

    }catch(e){
      print(e.toString());
    }
  }

}

