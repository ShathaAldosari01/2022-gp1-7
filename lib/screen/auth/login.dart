import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp1_7_2022/config/palette.dart';
/*services */
import 'package:gp1_7_2022/screen/services/auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  //for service
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = "",
      password="";

  //for button disable
  bool isPassEmpty= true,
      isEmailEmpty = true;
  bool isButtonActive = false;
  late TextEditingController _emailController, _passwordController;

  get navigatorKey => GlobalKey<NavigatorState>();

  @override
  void initState(){
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailController.addListener(() {
      final isEmailOkay = _emailController.text.isNotEmpty ;

      setState(() {
        isEmailEmpty = !isEmailOkay;
        isButtonActive = (!isPassEmpty && !isEmailEmpty);
      });
    });
    _passwordController.addListener(() {
      final isPassOkay = _passwordController.text.length>=8 ;

      setState(() {
        isPassEmpty = !isPassOkay;
        isButtonActive = (!isPassEmpty && !isEmailEmpty);
      });
    });

  }

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();

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

                          /*Password*/
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                            child: TextFormField(
                              //function
                              onChanged: (val){
                                /*change the val of pass*/
                                setState(() {
                                  password = val;
                                });
                              },
                              /*value*/
                              validator: (val){
                                if(val!.isEmpty){
                                  return "Password mismatch.";
                                }if(val.length>255){
                                  return "Password mismatch.";
                                }if(val.length<8){
                                  return "Password mismatch.";
                                }if(!val.contains(RegExp(r'[A-Z]'), 0)){
                                  return "Password mismatch.";
                                }if(!val.contains(RegExp(r'[a-z]'), 0)){
                                  return "Password mismatch.";
                                }if(!val.contains(RegExp(r'[0-9]'), 0)){
                                  return "Password mismatch.";
                                }if(!(
                                    val.contains('&')||
                                        val.contains("#")||
                                        val.contains("*")||
                                        val.contains("!")||
                                        val.contains("%")||
                                        val.contains("~")||
                                        val.contains("`")||
                                        val.contains("@")||
                                        val.contains("^")||
                                        val.contains("(")||
                                        val.contains(")")||
                                        val.contains("_")||
                                        val.contains("-")||
                                        val.contains("+")||
                                        val.contains("=")||
                                        val.contains("{")||
                                        val.contains("[")||
                                        val.contains("}")||
                                        val.contains("]")||
                                        val.contains("|")||
                                        val.contains(":")||
                                        val.contains(";")||
                                        val.contains("<")||
                                        val.contains(">")||
                                        val.contains(",")||
                                        val.contains(".")||
                                        val.contains("?")
                                )){
                                  return "Password mismatch.";
                                }
                                return null;
                              },
                              /*controller for button enble*/
                              controller: _passwordController,
                              //design
                              decoration: const InputDecoration(

                                /*background color*/
                                fillColor: Palette.lightgrey,
                                filled: true,

                                /*hint*/
                                border: OutlineInputBorder(),
                                hintText: "Password",
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
                              obscureText: true,
                            ),
                          ),
                          /*end of password*/


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

                  Align (
                    alignment: Alignment.topRight,
                    child:
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      child: TextButton( onPressed: (){
                        Navigator.pushNamed(context, '/forget_password');
                      }, child: Text('forget password?',
                        style: TextStyle(
                          fontSize: 17,
                          color: Palette.link,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ),

                    ),
                  ),

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
                        onPressed:isButtonActive
                            ?() async {
                          if(_formKey.currentState!.validate()){
                            //showDialog
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context)=> const Center(child: CircularProgressIndicator()),
                            );
                            /*log in using database*/
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                  email: email,
                                  password: password
                              );
                              /*go to Profile_Page page*/
                              Navigator.of(context).popUntil((route) => route.isFirst);

                            }on FirebaseAuthException catch(e){
                              Alert(
                                  context: context,
                                  title: "Something went wrong!" ,
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
                            /*deactivate the button*/
                            setState(() {
                              isButtonActive= false;
                            });

                          }
                        }
                            :null,
                        child: const Text('Log in',
                          style: TextStyle(
                            color: Palette.backgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  /*end of log in button */
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Divider(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[

                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: Palette.grey,
                              ),
                            ),

                            FlatButton(
                              // color: Colors.red,
                              padding: const EdgeInsets.fromLTRB(0, 0,30, 0),
                              onPressed: (){
                                Navigator.pushNamed(context, '/signup');
                              },
                              child: const Text(
                                " Sign up.",
                                style: TextStyle(
                                  color: Palette.link,
                                ),
                              ),
                            ),

                          ]
                      ),
                    )
                  ],

                )
            )
          ],
        ),
      ),
    );
  }
}
