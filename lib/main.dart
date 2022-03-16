import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp1_7_2022/screen/auth/signup/userInfo/name.dart';
import 'package:gp1_7_2022/screen/auth/signup/question1.dart';
import 'package:gp1_7_2022/screen/auth/signup/question2.dart';
import 'package:gp1_7_2022/screen/auth/signup/question3.dart';
import 'package:gp1_7_2022/screen/auth/signup/question4.dart';
import 'package:gp1_7_2022/screen/auth/signup/question5.dart';
import 'package:gp1_7_2022/screen/auth/signup/userInfo/photo.dart';
import 'package:gp1_7_2022/screen/home/Profile_Page.dart';
import 'package:firebase_core/firebase_core.dart';
/*pages */
import 'package:gp1_7_2022/screen/auth/signup_login.dart';
import 'package:gp1_7_2022/screen/auth/signup/userAuth/signup.dart';
import 'package:gp1_7_2022/screen/auth/Login/login.dart';
import 'package:gp1_7_2022/screen/auth/signup/userAuth/signupConfirmationCode.dart';
import 'package:gp1_7_2022/screen/auth/signup/userAuth/signupPassword.dart';
import 'package:gp1_7_2022/screen/auth/signup/userInfo/signupBirthday.dart';
import 'package:gp1_7_2022/screen/auth/signup/userInfo/signupUsername.dart';
import 'package:gp1_7_2022/screen/auth/Login/forget_password.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MaterialApp(
          initialRoute: "/",
          routes: {
            "/": (context) => MainPage(),
            "/signup": (context)=> Signup(),
            '/login':(context)=>Login(),
            '/Profile_Page':(context) => Profile_page(uid: FirebaseAuth.instance.currentUser!.uid),
            // '/confirmationCode':(context) => ConfirmationCode(),
            // '/signupPassword':(context) => signupPassword(),
            '/signupBirthday':(context) => SignupBirthday(),
            '/signupUsername':(context) => SignupUsername(),
           '/forget_password':(context) => forget_password(),
            '/name':(context) => name(),
            '/question1':(context) => question1(),
            '/question2':(context) => question2(),
            '/question3':(context) => question3(),
            '/question4':(context) => question4(),
            '/question5':(context) => question5(),
            '/photo':(context) => Photo(),
          }
      )
  );
}
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder<User?>(

        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }else if(snapshot.hasError){
            return const Center(child: Text("Something went wrong!"));
          }else if(snapshot.hasData){
            if(FirebaseAuth.instance.currentUser!.emailVerified){
              var uid = FirebaseAuth.instance.currentUser!.uid;
              return  Profile_page(uid: uid,);
            }else{
              String? x = FirebaseAuth.instance.currentUser!.email;
              String y= x??" ";
              return  ConfirmationCode(email: y);
            }
          } else{
            return const Signup_Login();

          }
        },
      ),
    );
  }
}

