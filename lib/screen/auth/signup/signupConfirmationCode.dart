// import 'dart:io';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/*extra */
// import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';

/*pages */
import 'package:gp1_7_2022/screen/auth/signup/signupPassword.dart';
// import 'package:gp1_7_2022/screen/auth/signup/signup.dart';
/*colors */
import 'package:gp1_7_2022/config/palette.dart';

class ConfirmationCode extends StatefulWidget {
  final String email;
  const ConfirmationCode({Key? key,  required this.email}) : super(key: key);

  @override
  State<ConfirmationCode> createState() => _ConfirmationCodeState();
}

class _ConfirmationCodeState extends State<ConfirmationCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        "Enter confirmation code",//${widget.email}
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
                        text:  TextSpan(
                          children: [
                             const TextSpan(
                              text: 'Enter the confirmation code we send to you. ',
                              style:  TextStyle(
                                fontSize: 18,
                                color: Palette.grey,
                              ),
                            ),
                             TextSpan(
                              text: 'Resend confirmation code.',
                              style:  const TextStyle(
                                color: Palette.link,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              recognizer:  TapGestureRecognizer()..onTap = () {
                                Navigator.pushNamed(context, '/login');
                              },
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

                            /*email*/
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                //design
                                decoration: const InputDecoration(

                                  /*background color*/
                                  fillColor: Palette.lightgrey,
                                  filled: true,

                                  /*hint*/
                                  border: OutlineInputBorder(),
                                  hintText: "Confirmation code",
                                  hintStyle: TextStyle(
                                      fontSize: 18.0,
                                      color: Palette.grey
                                  ),

                                  /*Border*/
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Palette.midgrey,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Palette.midgrey,
                                      width: 2.0,
                                    ),
                                  ),
                                ),

                                //function
                                onChanged: (val){

                                },
                              ),
                            ),
                            /*end of email*/


                            /*next button*/
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 50.0,
                              /*button colors*/
                              decoration: const BoxDecoration(
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
                                  /*go to sign up page*/
                                  var route =  MaterialPageRoute(
                                      builder: (BuildContext context)=>
                                          signupPassword(email: widget.email)
                                  );
                                  Navigator.of(context).push(route);
                                },
                                  child: const Text('Next',
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
}


