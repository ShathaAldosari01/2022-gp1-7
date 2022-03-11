import 'package:flutter/material.dart';
/*extra */

/*pages */

/*colors */
import 'package:gp1_7_2022/config/palette.dart';

class signupPassword extends StatefulWidget {
  final String email;
  const signupPassword({Key? key,  required this.email}) : super(key: key);

  @override
  State<signupPassword> createState() => _signupPasswordState();
}

class _signupPasswordState extends State<signupPassword> {
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
                    child: Column(
                        children:[ Column(
                          children: [

                            /*password*/
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
                                //function
                                onChanged: (val){

                                },
                              ),
                            ),
                            /*end of password*/

                            /*password*/
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
                                //function
                                onChanged: (val){

                                },
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
                                  Navigator.pushNamed(context, '/signupBirthday');
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


