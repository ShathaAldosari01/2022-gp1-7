// import 'dart:io';
//import 'package:flutter/cupertino.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
/*pages */
import 'package:gp1_7_2022/screen/auth/signup/userAuth/signupPassword.dart';
/*colors */
import 'package:gp1_7_2022/config/palette.dart';
import 'package:gp1_7_2022/screen/services/auth.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  //for service
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = "";

  //for button disavle
  bool isButtonActive = false;
  late TextEditingController _emailController;

  @override
  void initState(){
    super.initState();

    _emailController = TextEditingController();
    _emailController.addListener(() {
      final isButtonActive = _emailController.text.isNotEmpty;

      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
  }

  @override
  void dispose(){
    _emailController.dispose();

    super.dispose();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(

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
                        "Enter Your Email",
                        style: TextStyle(
                          fontSize: 30,
                          color: Palette.textColor,
                        ),
                      ),
                    ),
                  ),

                  /*enter your email so that you */
                  Container(
                    padding: const EdgeInsets.symmetric( vertical: 10),
                    // color: Colors.blue,
                    child:const Center(
                      child: Text(
                        "Enter your email to register in Odyssey.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Palette.grey,
                        ),
                      ),
                    ),
                  ),

                  /*form*/
                  Form(
                    key: _formKey,
                    child: Column(
                        children:[ Column(
                          children: [

                            /*email*/
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
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
                                  }else if(val.length>254){
                                    return "Enter an email address under 254 characters.";
                                  }else if(!EmailValidator.validate(email)){
                                    return "Please enter a valid email.";
                                  }
                                  return null;
                                },
                                /*controller for button enable*/
                                controller: _emailController,

                                //design//
                                decoration: const InputDecoration(

                                  /*background color*/
                                  fillColor: Palette.lightgrey,
                                  filled: true,

                                  /* email icon */
                                  prefixIcon: Icon(Icons.email, color: Colors.grey),

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


                            /*next button*/
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 50.0,
                              /*button colors*/
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                gradient:isButtonActive
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
                                  onPressed:isButtonActive ?() async {
                                    if(_formKey.currentState!.validate()){
                                      /*deactivate the button*/
                                      setState(() {
                                        isButtonActive= false;
                                      });
                                      // /*clear the text*/
                                      /*go to sign up page*/
                                      var route =  MaterialPageRoute(
                                          builder: (BuildContext context)=>
                                              signupPassword(email: _emailController.text)
                                      );
                                      Navigator.of(context).push(route);
                                    }
                                  }
                                      :null,
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
                  /*/form*/
                ],
              ),
            ),
          ),


          /*log in?*/
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
                      //Already have an account?
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Palette.grey,
                        ),
                      ),
                      //Log in
                      InkWell(
                        child:  const Text(
                          'Log In.',
                          style: TextStyle(
                            color: Palette.link,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () => Navigator.pushNamed(context, '/login'),
                      ),


                    ]
                ),
              )
            ],
          )
          //end of log in?
        ],
      ),
    );

  }
}