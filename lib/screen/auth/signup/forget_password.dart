import 'package:flutter/material.dart';
import 'package:gp1_7_2022/config/palette.dart';
/*services */
import 'package:gp1_7_2022/screen/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp1_7_2022/config/palette.dart';
/*services */
import 'package:gp1_7_2022/screen/services/auth.dart';
import 'package:gp1_7_2022/screen/auth/signup/forget_password.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
                mainAxisAlignment:MainAxisAlignment.end ,

                children: [
                  Container(
                    margin: const EdgeInsets.all(14),
                    child: const Center(
                      child:Text(
                        "Odyssey",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 50,
                          color: Palette.link,
                          fontFamily: 'Handlee',
                          letterSpacing: 2,
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
                              /*controller for button enble*/
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
              flex: 6,

              child:Column(

                children: [


                  /*log in button*/
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
                        onPressed: (){
                         auth.sendPasswordResetEmail(email: email);
                         Navigator.of(context).pop();






                        },
                           child: Text (
                                  'send email'

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
