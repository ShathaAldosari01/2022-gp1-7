import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../config/palette.dart';
import '../../auth/signup/userInfo/photo/utils.dart';

class Following extends StatefulWidget {
  final following ;
  const Following({Key? key, required this.following}) : super(key: key);

  @override
  _FollowingState createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  /*attribute*/
  var following =[];
  bool islouded = false;
  var usersData= [];


  @override
  void initState() {
    super.initState();
    setState(() {
      following = widget.following;
    });
    getFollowing();
  }

  void getFollowing() {
    for(var user in following){
      setState(() {
        print(user);
        // print(getUser(user));
        usersData.add( getUser(user));
      });
    }
    setState(() {
      islouded = true;
    });
  }

  getUser(uid)async{
    try {
      if (uid != null) {
        var userSnap = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get();
        var userData = userSnap.data()!;

        // print(userSnap.data()!["username"].toString());
        return Text(userData['username']);
      }
    }catch(e){
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        //appBar style
        elevation: 0,
        backgroundColor: Palette.backgroundColor,
        iconTheme: IconThemeData(
          color: Palette.textColor, //change your color here
        ),
        // automaticallyImplyLeading: false, //no arrow
        centerTitle: true,
        //username
        title: Text(
          "Following",
          style: TextStyle(
            color: Palette.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
        body: !islouded?
      const Center(
        child: CircularProgressIndicator(),
      ):following.isNotEmpty?
      Column(
        children: [
          for(var user in usersData)
            user,

        ],
      ):Text("No following yet!"),
    );
  }

}
