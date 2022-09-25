import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp1_7_2022/config/palette.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class question1 extends StatefulWidget {
  @override
  _question1State createState() => _question1State();
}

class _question1State extends State<question1> {
  static const quest1 = <String>['Yes', 'No'];
  String selectedQuest1 = "";
  bool isButtonActive = false;
  //database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int married = -1;
  //user id
  var uid = FirebaseAuth.instance.currentUser!.uid;
  /*user data*/
  var userData = {};

  /* get data method */
  getData() async {
    try {
      if (uid != null) {
        //we have uid
        var userSnap =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (userSnap.data() != null) {
          //we have user data
          userData = userSnap.data()!;

          setState(() {
            married = userData['questions']["married"];
            print(married.toString());
            if (married.toString().compareTo("0") == 0) {
              this.selectedQuest1 = "No";
              isButtonActive = true;
            }
            if (married.toString().compareTo("1") == 0) {
              this.selectedQuest1 = "Yes";
              isButtonActive = true;
            }
          });
        } else
          Navigator.of(context).popAndPushNamed('/Signup_Login');
      }
    } catch (e) {
      Alert(
        context: context,
        title: "Invalid input!",
        desc: e.toString(),
      ).show();
    }
  }

  @override
  void initState() {
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
          elevation: 0, //no shadow
          automaticallyImplyLeading: false, //no arrow
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 16),
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Center(
                child: Text(
                  "Tell Us About Yourself",
                  style: TextStyle(
                    fontSize: 30,
                    color: Palette.textColor,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: const Center(
                child: Text(
                  "Answer the following to personalize your experience in Odyssey.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Palette.grey,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: const Center(
                child: Text(
                  "Note: Data won't be displayed in your profile.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Palette.grey,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: const Center(
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
              margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              alignment: Alignment.center,
              width: 350,
              height: 50.0,
              /*button colors*/
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                gradient: isButtonActive
                    ? LinearGradient(colors: [
                        Palette.buttonColor,
                        Palette.nameColor,
                      ])
                    : LinearGradient(colors: [
                        Palette.buttonDisableColor,
                        Palette.nameDisablColor,
                      ]),
              ),

              /*button*/
              child: ButtonTheme(
                height: 50.0,
                minWidth: 350,
                child: TextButton(
                  onPressed: isButtonActive
                      ? () {
                          if (this.selectedQuest1.toString().compareTo("No") ==
                              0) {
                            addAnswer("married", 0);
                          } else if (this
                                  .selectedQuest1
                                  .toString()
                                  .compareTo("Yes") ==
                              0) {
                            addAnswer("married", 1);
                          }

                          /*deactivate the button*/
                          setState(() {
                            isButtonActive = false;
                          });

                          if (this.selectedQuest1.toString().compareTo("No") ==
                              0) {
                            /*go to gender question page*/
                            Navigator.pushNamed(context, '/gender');
                          } else if (this
                                  .selectedQuest1
                                  .toString()
                                  .compareTo("Yes") ==
                              0) {
                            /*go to question 2 page*/
                            Navigator.pushNamed(context, '/question2');
                          }
                        }
                      : null,
                  child: Text(
                    'Next',
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
          (value) {
            return RadioListTile<String>(
              value: value,
              groupValue: selectedQuest1,
              title: Text(
                value,
                style: TextStyle(fontSize: 20, color: Palette.textColor),
              ),
              onChanged: (value) => setState(() {
                this.selectedQuest1 = value!;
                isButtonActive = true;
              }),
            );
          },
        ).toList(),
      );

  Future<void> addAnswer(String question, int answer) async {
    try {
      var uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();

      await _firestore.collection('users').doc(uid).update({
        "questions." + question: answer,
        if (answer == 0) "questions.children": 0,
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
