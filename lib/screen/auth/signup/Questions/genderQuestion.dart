import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp1_7_2022/config/palette.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class GenderQuestion extends StatefulWidget {
  const GenderQuestion({Key? key}) : super(key: key);
  @override
  _GenderQuestionState createState() => _GenderQuestionState();
}

class _GenderQuestionState extends State<GenderQuestion> {
  static const questg = <String>['Female', 'Male', "I'd rather not to say"];
  String selectedQuestg = "";
  bool isButtonActive = false;
  //database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int gender = -1;
  //user id
  var uid = FirebaseAuth.instance.currentUser!.uid;
  /*user data*/
  var userData = {};
  int adult = 0;
  int married = -1;

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
            gender = userData['questions']["gender"];
            adult = userData['isAdult'];
            married = userData['questions']['married'];
            print(gender.toString());
            if (gender.toString().compareTo("0") == 0) {
              this.selectedQuestg = "Female";
              isButtonActive = true;
            }
            if (gender.toString().compareTo("1") == 0) {
              this.selectedQuestg = "Male";
              isButtonActive = true;
            }
            if (gender.toString().compareTo("2") == 0) {
              this.selectedQuestg = "I'd rather not to say";
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
          automaticallyImplyLeading: adult == 0 ? false : true, //no arrow
          /*back arrow */
          leading: adult == 1
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Palette.textColor),
                  onPressed: () {
                    if (married == 1) {
                      Navigator.pushNamed(context, '/question2');
                    } else if (married == 0) {
                      Navigator.pushNamed(context, '/question1');
                    }
                  })
              : null,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 16),
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: const Center(
                child: Text(
                  "How do you identify?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 40),
              child: const Center(
                child: Text(
                  "This information won't be displayed in your profile.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Palette.grey,
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
                child: FlatButton(
                  onPressed: isButtonActive
                      ? () {
                          if (this
                                  .selectedQuestg
                                  .toString()
                                  .compareTo("Female") ==
                              0) {
                            addAnswer("gender", 0);
                          } else if (this
                                  .selectedQuestg
                                  .toString()
                                  .compareTo("Male") ==
                              0) {
                            addAnswer("gender", 1);
                          } else if (this
                                  .selectedQuestg
                                  .toString()
                                  .compareTo("I'd rather not to say") ==
                              0) {
                            addAnswer("gender", 2);
                          }

                          /*deactivate the button*/
                          setState(() {
                            isButtonActive = false;
                          });

                          /*go to question 2 page*/
                          Navigator.pushNamed(context, '/question4');
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
        children: questg.map(
          (value) {
            return RadioListTile<String>(
              value: value,
              groupValue: selectedQuestg,
              title: Text(
                value,
                style: TextStyle(fontSize: 20, color: Palette.textColor),
              ),
              onChanged: (value) => setState(() {
                this.selectedQuestg = value!;
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

      await _firestore
          .collection('users')
          .doc(uid)
          .update({"questions." + question: answer});
    } catch (e) {
      print(e.toString());
    }
  }
}
