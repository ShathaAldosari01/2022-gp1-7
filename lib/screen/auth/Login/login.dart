import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp1_7_2022/config/palette.dart';
import 'package:gp1_7_2022/screen/auth/Login/forget_password.dart';
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
  String email = "", password = "";

  // for show/hide password
  bool isHidden = true;

  //for button disable
  bool isPassEmpty = true, isEmailEmpty = true;
  bool isButtonActive = false;
  late TextEditingController _emailController, _passwordController;

  get navigatorKey => GlobalKey<NavigatorState>();

  //for button go next
  final focus = FocusNode();

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailController.addListener(() {
      final isEmailOkay = _emailController.text.isNotEmpty;

      setState(() {
        isEmailEmpty = !isEmailOkay;
        isButtonActive = (!isPassEmpty && !isEmailEmpty);
      });
    });
    _passwordController.addListener(() {
      final isPassOkay = _passwordController.text.length >= 8;
// not active bouttem the bouton only if email not empty and pass length>=8 and pass not empty
      setState(() {
        isPassEmpty = !isPassOkay;
        isButtonActive = (!isPassEmpty && !isEmailEmpty);
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: Scaffold(
        backgroundColor: Palette.backgroundColor,
        appBar: AppBar(
          backgroundColor: Palette.backgroundColor,
          foregroundColor: Palette.textColor,
          elevation: 0, //no shadow
          /*back arrow */
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Palette.textColor),
            onPressed: () => Navigator.pushNamed(context, '/Signup_Login'),
          ),
        ),
        //fix overload error
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    // margin: const EdgeInsets.all(14),
                    child: const Center(
                      child: Text(
                        "Odyssey",
                        style: TextStyle(
                           fontWeight: FontWeight.w500,
                          fontSize: 65,
                          color: Palette.link,
                          fontFamily: 'Cookie',
                      //    letterSpacing: 2,
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
                            margin: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5),
                            child: TextFormField(
                              //function
                              onChanged: (val) {
                                /*change the val of email*/
                                setState(() {
                                  email = val;
                                });
                              },
                              /*value*/
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please enter a valid email.";
                                }
                                if (val.length > 254) {
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

                                /* email icon */
                                prefixIcon:
                                    Icon(Icons.email, color: Colors.grey),

                                /*hint*/
                                border: OutlineInputBorder(),
                                hintText: "Email address",
                                hintStyle: TextStyle(
                                    fontSize: 18.0, color: Palette.grey),

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

                              /*go to next field*/
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (v) {
                                FocusScope.of(context).requestFocus(focus);
                              },
                            ),
                          ),
                          /*end of email*/

                          /*Password*/
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5),
                            child: TextFormField(
                              focusNode: focus,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (value) {
                                if (isButtonActive) goProfilePage();
                              },

                              //function
                              onChanged: (val) {
                                /*change the val of pass*/
                                setState(() {
                                  password = val;
                                });
                              },

                              /*controller for button enable*/
                              controller: _passwordController,
                              //design
                              decoration: InputDecoration(
                                /*background color*/
                                fillColor: Palette.lightgrey,
                                filled: true,

                                /* password icon */
                                prefixIcon:
                                    Icon(Icons.lock, color: Colors.grey),

                                /* show/hide password */
                                suffixIcon: IconButton(
                                  icon: isHidden
                                      ? Icon(Icons.visibility,
                                          color: Colors.grey)
                                      : Icon(Icons.visibility_off,
                                          color: Colors.grey),
                                  onPressed: togglePasswordVisibility,
                                ),

                                /*hint*/
                                border: OutlineInputBorder(),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    fontSize: 18.0, color: Palette.grey),

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
                              obscureText: isHidden,
                            ),
                          ),
                          /*end of password*/
                        ],
                      )),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextButton(
                        onPressed: () {
                          /*go to Forgot password page*/
                          var route = MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  forget_password(
                                      email: _emailController.text));
                          Navigator.of(context).push(route);
                        },
                        child: Text(
                          'Forgot password?',
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
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50.0,
                    /*button colors*/
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                      gradient: isButtonActive
                          ? const LinearGradient(colors: [
                              Palette.buttonColor,
                              Palette.nameColor,
                            ])
                          : const LinearGradient(colors: [
                              Palette.buttonDisableColor,
                              Palette.nameDisablColor,
                            ]),
                    ),
                    /*button*/
                    child: ButtonTheme(
                      height: 50.0,
                      minWidth: 350,
                      child: FlatButton(
                        onPressed: isButtonActive ? goProfilePage : null,
                        child: const Text(
                          'Log in',
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
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Divider(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 25),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: Palette.grey,
                              ),
                            ),
                            FlatButton(
                              // color: Colors.red,
                              padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                              onPressed: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                              child: const Text(
                                " Sign up.",
                                style: TextStyle(
                                  color: Palette.link,
                                ),
                              ),
                            ),
                          ]),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);

  void goProfilePage() async {
    if (_formKey.currentState!.validate()) {
      //showDialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      /*log in using database*/
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        /*go to Profile_Page page*/
        Navigator.of(context).popUntil((route) => route.isFirst);
      } on FirebaseAuthException catch (e) {
        Alert(
            context: context,
            title: "Invalid input",
            desc: e.message.toString(),
            buttons: [
              DialogButton(
                  child: Text(
                    "Sign up",
                    style: TextStyle(color: Palette.backgroundColor),
                  ),
                  onPressed: () {
                    /*go to sign up page*/
                    Navigator.pushNamed(context, '/signup');
                  },
                  gradient: const LinearGradient(colors: [
                    Palette.buttonColor,
                    Palette.nameColor,
                  ])),
              DialogButton(
                  child: const Text(
                    "Log in",
                    style: TextStyle(color: Palette.backgroundColor),
                  ),
                  onPressed: () {
                    /*go to sign up page*/
                    Navigator.pushNamed(context, '/login');
                  },
                  gradient: const LinearGradient(colors: [
                    Palette.buttonColor,
                    Palette.nameColor,
                  ]))
            ]).show();
        print(e);
      }
      /*deactivate the button*/
      setState(() {
        isButtonActive = false;
      });
    }
  }
}
