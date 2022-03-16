import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService{

  final FirebaseAuth  _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firstore = FirebaseFirestore.instance;

  //sign up with everything
Future<String>signupUser({
  //req att.
    required String email,
  required String password,
  required String username,
  required String name,
  required String birthday,
  required String bio,
  required Uint8List file,
  required String q1,
  required String q2,
  required String q3,
  required String q4,
  required String q5,
})async{
  //default value for error msg
  String res = "some error occurred";
  //try to sign up
  try{
    //step 1: validate
    if(email.isNotEmpty &&
        password.isNotEmpty &&
        username.isNotEmpty &&
        name.isNotEmpty &&
        bio.isNotEmpty &&
        q1.isNotEmpty &&
        q2.isNotEmpty &&
        q3.isNotEmpty &&
        q4.isNotEmpty &&
        file != null
    ){
      //step 2: sign up email, password
      UserCredential crad = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    }

  }catch(err){
    res = err.toString();
  }
  return res;
}

  //log in with email, password

  //log out

}