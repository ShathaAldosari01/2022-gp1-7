// import 'dart:io';
// import 'package:flutter/cupertino.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
/*extra */
// import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';

/*pages */
import 'package:gp1_7_2022/screen/home/Profile_Page.dart';
// import 'package:gp1_7_2022/screen/auth/signup/signup.dart';
/*colors */
import 'package:gp1_7_2022/config/palette.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ConfirmationCode extends StatefulWidget {
  final String email;
  const ConfirmationCode({Key? key,  required this.email}) : super(key: key);

  @override
  State<ConfirmationCode> createState() => _ConfirmationCodeState();
}

class _ConfirmationCodeState extends State<ConfirmationCode> {
  //val?
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState(){
    super.initState();

    //user need to be created before
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if(!isEmailVerified){
      sendVerificationEmail();
    }else{
      Navigator.pushNamed(context, '/signupBirthday');
    }

    timer= Timer.periodic(
      Duration(seconds:3),
          (_) =>cheackEmailVerified(),
    );
  }

  @override
  void dispose(){
    timer?.cancel();

    super.dispose();
  }

  Future cheackEmailVerified() async{
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if(isEmailVerified){
      timer?.cancel();
      Navigator.pushNamed(context, '/signupBirthday');
    }
  }

  Future sendVerificationEmail() async{
    try {
      /*send verify email*/
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      /*now he/she can not resend email again*/
      setState(() {
        canResendEmail = false;
      });
      /*after 5 sec they can */
      await Future.delayed(
          const Duration(
              seconds: 5
          )
      );
      /*resend okay*/
      setState(() {
        canResendEmail= true;
      });


    }catch(e){
      //error msg
      Alert(
          context: context,
          title: "Something went wrong!" ,
          desc: e.toString(),
          buttons: [
            DialogButton(
              child: const Text(
                "Camcel",
                style: TextStyle(
                    color: Palette.backgroundColor
                ),
              ),
              onPressed: (){
                /*go to sign up page*/
                Navigator.pushNamed(context, '/signup');
              },
              gradient:canResendEmail
                  ?const LinearGradient(
                  colors: [
                    Palette.buttonColor,
                    Palette.nameColor,
                  ]
              )
                  :const LinearGradient(
                  colors: [
                    Palette.buttonDisableColor,
                    Palette.nameDisablColor,
                  ]
              ),
            ),
          ]
      ).show();
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ?const Profile_page()
      :Scaffold(
    backgroundColor: Palette.backgroundColor,

    appBar: AppBar(
      backgroundColor: Palette.backgroundColor,
      foregroundColor: Palette.textColor,
      elevation: 0,//no shadow
      automaticallyImplyLeading: false,//no arrow
    ),
    //fix overloade error
    resizeToAvoidBottomInset: false,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [


        /*first column*/
        Expanded(
          child: Container(
            margin:  const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*Enter your email*/
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  // color: Colors.red,
                  child:const Center(
                    child: Text(
                      "Cheek your email",//${widget.email}
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: Palette.textColor,
                      ),
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric( vertical: 10),
                  child: Center(
                    child:  RichText(
                      textAlign: TextAlign.center,
                      text:  const TextSpan(
                        children: [
                          TextSpan(
                            text: 'To confirm your email address, tap the the link that we just send you.',
                            style:  TextStyle(
                              fontSize: 18,
                              color: Palette.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),



                /*form*/
                Form(
                  child: Column(
                      children:[ Column(
                        children: [

                          /*next button*/
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 50.0,
                            /*button colors*/
                            decoration:  BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                              gradient:canResendEmail
                                  ?const LinearGradient(
                                  colors: [
                                    Palette.buttonColor,
                                    Palette.nameColor,
                                  ]
                              )
                                  :const LinearGradient(
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
                              child: FlatButton(
                                onPressed:canResendEmail?
                                    (){
                                  sendVerificationEmail();
                                }
                                    :null,
                                child: const Text('Resend Email',
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
                      ),]
                  ),
                ),
                /*end form*/
              ],
            ),
          ),
        ),

        /*log out?*/
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Divider(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    //Log in
                    InkWell(
                      child:  const Text(
                        'Back',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Palette.link,
                        ),
                      ),
                      onTap: () => Navigator.pushNamed(context, '/signup'),
                    ),
                  ]
              ),
            )
          ],
        )
        //end of back
      ],
    ),
  );
}


