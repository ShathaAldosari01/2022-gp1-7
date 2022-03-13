import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
/*services */
import 'package:gp1_7_2022/screen/services/auth.dart';
/*pages */
import 'package:gp1_7_2022/screen/auth/signup/signupConfirmationCode.dart';
import 'package:gp1_7_2022/screen/auth/signup/signup.dart';
/*colors */
import 'package:gp1_7_2022/config/palette.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class signupPassword extends StatefulWidget {
  final String email;
  const signupPassword({Key? key,  required this.email}) : super(key: key);

  @override
  State<signupPassword> createState() => _signupPasswordState();
}

class _signupPasswordState extends State<signupPassword> {
  //for service
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String password = "",
         repassword="";

  //for button disavle
  bool isPassEmpty= true,
      isReEmpty = true;
  bool isButtonActive = false;
  late TextEditingController _passwordController, _rePasswordController;

  @override
  void initState(){
    super.initState();

    _passwordController = TextEditingController();
    _rePasswordController = TextEditingController();

    _passwordController.addListener(() {
      final isPassNotEmpty = _passwordController.text.length>=8 ;

      setState(() {
        isPassEmpty = !isPassNotEmpty;
        isButtonActive = (!isPassEmpty && !isReEmpty);
      });
    });

    _rePasswordController.addListener(() {
      final isReNotEmpty = _rePasswordController.text.length>=8 ;

      setState(() {
        isReEmpty = !isReNotEmpty;
        isButtonActive = (!isPassEmpty && !isReEmpty);
      });
    });
  }

  @override
  void dispose(){
    _passwordController.dispose();
    _rePasswordController.dispose();

    super.dispose();
  }
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Palette.backgroundColor,

      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        foregroundColor: Palette.textColor,
        elevation: 0,//no shadow
        /*back arowe */
        leading: IconButton(
          icon: const Icon(
              Icons.arrow_back, color: Palette.textColor
          ),
          onPressed: () => Navigator.pushNamed(context, '/signup'),
        ),
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
                        "Create a password",
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
                    child: const Center(
                      child:  Text(
                        'You need to enter your password twice, to mack sure you enter it right.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Palette.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),



                  /*form*/
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [

                        /*password*/
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
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
                                return "Password should not be empty";
                              }if(val.length>255){
                                return "Create a shorter password under 255 characters.";
                              }if(val.length<8){
                                return "Password should contain at least 8 characters.";
                              }if(!val.contains(RegExp(r'[A-Z]'), 0)){
                                return "Password should contain upper case.";
                              }if(!val.contains(RegExp(r'[a-z]'), 0)){
                                return "Password should contain lower case.";
                              }if(!val.contains(RegExp(r'[0-9]'), 0)){
                                return "Password should contain number.";
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
                                return "Password should contain special characters.";
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

                        /*password*/
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            //function
                            onChanged: (val){
                              /*change the val of pass*/
                              setState(() {
                                repassword = val;
                              });
                            },
                            /*value*/
                            validator: (val){
                              if(val!=password){
                                return "password mismatch";
                              }else {
                                if (val!.isEmpty) {
                                  return "Password should not be empty";
                                }
                                if (val.length > 255) {
                                  return "Create a shorter password under 255 characters.";
                                }
                                if (val.length < 8) {
                                  return "Password should contain at least 8 characters.";
                                }
                                if (!val.contains(RegExp(r'[A-Z]'), 0)) {
                                  return "Password should contain upper case.";
                                }
                                if (!val.contains(RegExp(r'[a-z]'), 0)) {
                                  return "Password should contain lower case.";
                                }
                                if (!val.contains(RegExp(r'[0-9]'), 0)) {
                                  return "Password should contain number.";
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
                                  return "Password should contain special characters.";
                                }
                              }
                              return null;
                            },
                            /*controller for button enble*/
                            controller: _rePasswordController,
                            //design
                            decoration: const InputDecoration(

                              /*background color*/
                              fillColor: Palette.lightgrey,
                              filled: true,

                              /*hint*/
                              border: OutlineInputBorder(),
                              hintText: "Confirm password",
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


                        /*next button*/
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
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

                                  // //showDialog
                                  // showDialog(
                                  //   context: context,
                                  //   barrierDismissible: false,
                                  //   builder: (context)=> const Center(child: CircularProgressIndicator()),
                                  // );
                                  /*add to database*/
                                  try {

                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                        email: widget.email,
                                        password: password
                                    );
                                    /*go to Profile_Page page*/
                                    Navigator.of(context).popUntil((route) => route.isFirst);
                                    /*go to sign up page*/
                                    var route =  MaterialPageRoute(
                                        builder: (BuildContext context)=>
                                            ConfirmationCode(email: widget.email)
                                    );
                                    Navigator.of(context).push(route);

                                  }on FirebaseAuthException catch(e){
                                    //something went wrong
                                    /*go to Profile_Page page*/
                                    // Navigator.of(context).popUntil((route) => route.isFirst);
                                    //error msg
                                    Alert(
                                        context: context,
                                        title: "Something went wrong!" ,
                                        desc: e.message.toString()+" Try to log in to you account or try to sign up with different email address.",
                                        buttons: [
                                          DialogButton(
                                              child: Text(
                                                "Sign up",
                                                style: TextStyle(
                                                    color: Palette.backgroundColor
                                                ),
                                              ),
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
                                                ),
                                              ),
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
                      //Already have an account?
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Palette.grey,
                        ),
                      ),
                      //Log in
                      InkWell(
                        child: const Text(
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
          //ean of login?

        ],
      ),
    );
  }
}


