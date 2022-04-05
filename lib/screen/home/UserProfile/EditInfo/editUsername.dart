import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/*pages */
import 'package:gp1_7_2022/screen/auth/signup_login.dart';
import 'package:gp1_7_2022/screen/auth/signup/userAuth/signup.dart';
/*colors */
import 'package:gp1_7_2022/config/palette.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EditUsername extends StatefulWidget {
  final uid;
  const EditUsername({Key? key, this.uid}) : super(key: key);

  @override
  _EditUsernameState createState() => _EditUsernameState();
}

class _EditUsernameState extends State<EditUsername> {

  //Username
  String username="";
  String errMsg = "This user name is already exists, try another one.";
  late TextEditingController _UsernameController ;
  //database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //button
  bool isButtonActive = false;
  //form
  final _formKey = GlobalKey<FormState>();
  //user id
  var uid= FirebaseAuth.instance.currentUser!.uid;
  /*user data*/
  var userData = {};
  //for key go up
  final focus = FocusNode();

  /* get data method */
  getData() async {
    try {
      if (uid != null) {
        //we have uid
        var userSnap = await FirebaseFirestore.instance.collection('users').doc(
            uid).get();
        if(userSnap.data()!=null) {
          //we have user data
          userData = userSnap.data()!;
          setState(() {
            if(userData['username'].toString().isNotEmpty){
              username = userData['username'].toString();
              _UsernameController = TextEditingController(text:userData['username'].toString());
              isButtonActive= true;
            }else username ="";
          });

          _UsernameController.addListener(() {
            final isusernameNotEmpty = _UsernameController.text.isNotEmpty ;

            setState(() {
              isButtonActive = isusernameNotEmpty;
            });
          });

        }else
          Navigator.of(context).popAndPushNamed('/Signup_Login');
      }
    }
    catch(e){
      Alert(
        context: context,
        title: "Invalid input!",
        desc: e.toString(),
      ).show();
    }

  }

  @override
  void initState(){
    super.initState();
    //getting user info
    getData();

    //this to know if the user full the Username filed to disabile the button
    _UsernameController = TextEditingController();

  }
//this method > for controler > for naem
  @override
  void dispose(){
    _UsernameController.dispose();

    super.dispose();
  }
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Palette.backgroundColor,

      //header
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        elevation: 0,//no shadow
        automaticallyImplyLeading: false,//no arrow

        title:Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(
                  textColor: Palette.textColor,
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed('/editProfile');
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                  shape: CircleBorder(
                      side: BorderSide(
                          color: Colors.transparent
                      )
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Text(
                    "Edit username",
                    style: TextStyle(
                      color: Palette.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                FlatButton(
                  textColor: Palette.link,
                  onPressed: isButtonActive && userData['username'].toString().compareTo(username)!=0
                      ?editUsername
                      :null,

                  child: Text("Save", style: TextStyle(fontSize: 18, color: isButtonActive && userData['username'].toString().compareTo(username)!=0?Palette.link:Palette.grey),),
                  shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
                ),
              ],
            ),
            //line
            Divider(
              height: 1,
            ),
          ],
        ),

      ),

      //fix overload error
      resizeToAvoidBottomInset: false,

      //body
      body: Container(
        child: Column(

          children: [

            /*first column*/
            Expanded(
              child: Container(
                margin:  EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    /*form*/
                    Form(
                      child: Column(
                          children:[ Column(
                            children: [

                              /*Username*/
                              Form(
                                key: _formKey,
                                child:
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: TextFormField(

                                    /*to make the keyboard go up */
                                    focusNode: focus,
                                    autofocus:true,

                                    /*go next when submitted*/
                                    onFieldSubmitted: (value) {
                                      if (isButtonActive && userData['username'].toString().compareTo(username)!=0)
                                        editUsername();
                                    },

                                    //function
                                    onChanged: (val){
                                      /*change the val of pass*/
                                      setState(() {
                                        username = val;
                                      });
                                    },

                                    /*value*/
                                    validator: (val){
                                      if(val!.isEmpty){
                                        return "username should not be empty";
                                      }
                                      if (val.length > 35) {
                                        return "Create a shorter user under 35 characters.";
                                      }
                                      if((
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
                                              val.contains("?")||
                                              val.contains("/")||
                                              val.contains(" ")
                                      )){
                                        return "username should not contain space or special characters. only '-', '_' and '.'.";
                                      }
                                      return null;
                                    },
                                    /*controller for button enable*/
                                    controller: _UsernameController,

                                    //design
                                    decoration: InputDecoration(
                                      hintText: "username",
                                      hintStyle: TextStyle(
                                          fontSize: 18.0,
                                          color: Palette.grey
                                      ),


                                    ),

                                  ),
                                ),
                              ),



                            ],
                          ),]
                      ),
                    ),
                    /*/form*/
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  void editUsername()async{
    if(_formKey.currentState!.validate()){
      /*add to database*/
      try {

        final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: username.toLowerCase()).get();
        // .get;
        final valid = await snapshot.docs.isEmpty;

        if (valid) {
          // username not exists
          var uid =   FirebaseAuth.instance.currentUser!.uid;
          print(uid);
          await _firestore.collection("users").doc(uid).update({
            'username': username.toLowerCase(),
          });

          /*go to sign up page*/
          Navigator.pushNamed(context, '/editProfile');
        }
        else if(username.isEmpty &&
            username.toLowerCase().compareTo(userData['username'].toString())==0){
          /*go to sign up page*/
          Navigator.pushNamed(context, '/editProfile');
        }else{
          print(snapshot.docs);
          Alert(
            context: context,
            title: "Invalid input!" ,
            desc: errMsg,
          ).show();
          print(errMsg);
        }

      }catch(e){
        Alert(
          context: context,
          title: "Invalid input!" ,
          desc: e.toString(),

        ).show();
        print(e);
      }
    }

  }
}

