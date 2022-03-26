import 'package:flutter/material.dart';
import 'package:gp1_7_2022/config/palette.dart';
/*services */
import 'package:gp1_7_2022/screen/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp1_7_2022/config/palette.dart';
/*services */
import 'package:gp1_7_2022/screen/services/auth.dart';
import 'package:gp1_7_2022/screen/auth/Login/forget_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class forget_password extends StatefulWidget {
  const forget_password({Key? key}) : super(key: key);

  @override
  _forget_passwordState createState() => _forget_passwordState();
}

class _forget_passwordState extends State<forget_password> {

  //for service
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
final auth = FirebaseAuth.instance ; 
  // text field state
  String email = "";


  //for button disable
  bool isEmailEmpty = true;
  bool isButtonActive = false;
  late TextEditingController _emailController;

  get navigatorKey => GlobalKey<NavigatorState>();

  @override
  void initState(){
    super.initState();

    _emailController = TextEditingController();


    _emailController.addListener(() {
      final isEmailOkay = _emailController.text.isNotEmpty ;

      setState(() {
        isEmailEmpty = !isEmailOkay;
        isButtonActive = (!isEmailEmpty);
      });
    });


      setState(() {

        isButtonActive = (!isEmailEmpty);
      });
    }

  @override




  @override
  void dispose(){
    _emailController.dispose();


    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
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
            onPressed: () => Navigator.pushNamed(context, '/'),
          ),
        ),
        //fix overload error
        resizeToAvoidBottomInset: false,
        body:Column(
          children:[


            Expanded(
              flex:8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
              //  mainAxisAlignment:MainAxisAlignment.end ,

                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Center(
                      child:Text(
                        "Reset Password",
                        style: TextStyle(
                       //   fontWeight: FontWeight.w900,
                          fontSize: 30,
                          color: Palette.textColor,
                      //    fontFamily: 'Handlee',
                        //  letterSpacing: 2,
                        ),



                      ),
                    ),

                  ),



                  /*enter email and we'll send an email */
                  Container(
                   margin:  const EdgeInsets.symmetric(horizontal: 40),
                  padding: const EdgeInsets.symmetric(vertical: 10),

                    child:const Center(
                      child: Text(
                        "Enter your email and we'll send an email with instructions to reset your password.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Palette.grey,
                        ),
                      ),
                    ),
                  ),




                  Form(
                      key: _formKey,
                      child: Column(
                        children: [

                          /*email*/
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                            child: TextFormField(
                              //function
                              onChanged: (val){
                                /*change the val of email*/
                                setState(() {
                                  email = val;
                                });
                              },
                              /*value*/
                              validator: (val){
                                if(val!.isEmpty){
                                  return "Please enter a valid email.";
                                }if(val.length>254){
                                  return "Enter an email address under 254 characters.";
                                }
                                return null;
                              },
                              /*controller for button enable*/
                              controller: _emailController,
                              //design
                              decoration: const InputDecoration(

                                /*background color*/
                                fillColor: Palette.lightgrey,
                                filled: true,

                                /*hint*/
                                border: OutlineInputBorder(),
                                hintText: "Email address",
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
                            ),
                          ),
                          /*end of email*/

                        ],
                      )
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 13,

              child:Column(

                children: [


                  /*send email button*/
                  Container(
                    margin: const EdgeInsets.symmetric( horizontal:50, vertical: 10),
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50.0,
                    /*button colors*/
                    decoration:  BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      gradient: isButtonActive
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
                        onPressed:  isButtonActive ? ()  async {

                          try {
                            await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                            // Utils.showSnackBar("Password Reset Email Sent");
                            Navigator.of(context).pop();
                          }on FirebaseAuthException catch(e){
                            Alert(
                                context: context,
                                title: "Invalid input!" ,
                                desc: e.message.toString(),
                                buttons: [
                                  DialogButton(
                                      child: Text(
                                        "Sign up",
                                        style: TextStyle(
                                            color: Palette.backgroundColor
                                        ),),
                                      onPressed: (){
                                        /*go to sign up page*/
                                        Navigator.pushNamed(context, '/signup');
                                      },
                                      gradient:const LinearGradient(
                                          colors: [
                                            Palette.buttonColor,
                                            Palette.nameColor,
                                          ]
                                      )
                                  ),
                                  DialogButton(
                                      child: const Text(
                                        "Log in",
                                        style: TextStyle(
                                            color: Palette.backgroundColor
                                        ),),
                                      onPressed: (){
                                        /*go to sign up page*/
                                        Navigator.pushNamed(context, '/login');
                                      },
                                      gradient:const LinearGradient(
                                          colors: [
                                            Palette.buttonColor,
                                            Palette.nameColor,
                                          ]
                                      )
                                  )
                                ]
                            ).show();
                            print(e);

                          }


                        }
                        :null,
                           child: Text ('Send Email',
                            style: TextStyle(
                            color: Palette.backgroundColor,
                            fontSize: 18,
                            ),
                           ),
                        ),
                      ),
                    ),

                  /*end of log in button */
     ] ) ,
    ),
    ] ),

              ),
            );



  }



}
