import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gp1_7_2022/model/user.dart' as model;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
    await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  //sign up with everything
  Future<String> signupUser({
    //req att.
    required String email,
    required String password,

  }) async {
    //default value for error msg
    String res = "some error occurred";
    //try to sign up
    try {
      //step 1: validate
      if (email.isNotEmpty &&
          password.isNotEmpty ) {
        //step 2: sign up email, password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password
        );
        //step 3:
        model.User _user = model.User(
          username: "",
          uid: cred.user!.uid,
          name: "",
          email: email,
          photoPath: "no",
          bio: "",
          birthday: DateTime.now(),

          married: -1,
          children: -1,
          gender: -1,

          middle: 0,
          asian: 0,
          european: 0,
          american: 0,
          african: 0,

          restaurants: 0,
          museums: 0,
          shopping: 0,
          parks: 0,
          sports: 0,

          followers: [],
          following: [],
        );

        //step 4: adding user in our database
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(_user.toJson());

        //step5
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // log out user
  Future<void> signOut() async {
    await _auth.signOut();
  }

}
