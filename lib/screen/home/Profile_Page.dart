// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
/*pages */
/*colors */
import 'package:gp1_7_2022/config/palette.dart';
import 'package:gp1_7_2022/Widgets/follow_button.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:gp1_7_2022/screen/home/settings.dart';

class Profile_page extends StatefulWidget {
  final uid;
  const Profile_page({Key? key, required this.uid}) : super(key: key);

  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {
  bool _isloaded = false;
  var padding= 0.8;
  var userData = {};
  @override
  void initState() {
    getData();
    super.initState();
  }
  /* get data method */
  getData() async {
  try {
    if (widget.uid != null) {
      var userSnap = await FirebaseFirestore.instance.collection('users').doc(
          widget.uid).get();
      if(userSnap.data()!=null) {
        userData = userSnap.data()!;
        print("in");
        if (userData['name']
            .toString()
            .isEmpty) {
          Navigator.of(context).popAndPushNamed('/name');
        } else if (userData["birthday"]
            .toString()
            .isEmpty) {
          Navigator.of(context).popAndPushNamed('/signupBirthday');
        } else if (userData['username']
            .toString()
            .isEmpty) {
          Navigator.of(context).popAndPushNamed('/signupUsername');
        }
        setState(() {
          _isloaded = true;
        });
      }else
        Navigator.of(context).popAndPushNamed('/Signup_Login');
    }
  }
    catch(e){
      Alert(
          context: context,
          title: "Something went wrong!",
          desc: e.toString(),
      ).show();
    }

  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return _isloaded == false ?
    Center(
      child: CircularProgressIndicator(), // Show indicator
    )
  : Scaffold(
      backgroundColor: Palette.backgroundColor,

      appBar: AppBar(
        //appBar style
        elevation: 0,
        backgroundColor: Palette.backgroundColor,
        automaticallyImplyLeading: false,//no arrow
        //username
        title:  Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: Text(
              userData['username'],
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),

        //setting icon
        actions:[
          FocusedMenuHolder(
            //
            menuWidth: MediaQuery.of(context).size.width * 0.4,
            menuOffset: 0,
            menuItemExtent: 49,

            //list
            menuItems: [
              FocusedMenuItem(
                  title: const Text("Log out"),
                  trailingIcon: const Icon(Icons.logout),
                  onPressed: (){
                    /*go to sign up page*/
                    Navigator.pushNamed(context, '/');
                    return FirebaseAuth.instance.signOut();
                  }
              ),
              FocusedMenuItem(
                  title: const Text("Settings"),
                  trailingIcon: const Icon(Icons.settings),
                  onPressed: (){
                    Navigator.of(context).popAndPushNamed('/settings');
                  },
              ),
            ],

            openWithTap: true,
            onPressed: (){},

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Image.asset(
                "assets/menu-icon.png",
                height: 25,
                width: 25,
              ),
            ),

          ),
        ],
      ),

      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    userData['photoPath']!="no"?
                    CircleAvatar(
                      backgroundColor: Palette.grey,
                      backgroundImage:NetworkImage(userData['photoPath']),
                        radius:44
                    )
                    //user photo
                    :CircleAvatar(
                    backgroundColor: Colors.white ,
                      radius: 44,
                      child:  Icon(
                     Icons.account_circle_sharp,
                     color: Colors.grey,
                     size: 90,


                    ),


                    ),
                    //end user photo

                    Expanded(
                      flex: 7,
                      child: Column(
                        children: [
                          //post, followers and following
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildStatColumn(20, "posts"),
                              buildStatColumn(150, "Followers"),
                              buildStatColumn(10, "Following"),
                            ],
                          ),
                          //end post, followers and following

                        ],
                      ),
                    ),
                  ],
                ),

                //username
                Container(
                  alignment: Alignment.centerLeft,
                  padding:  EdgeInsets.fromLTRB(10, 40, 0, 0),
                  child:  Text(
                    userData['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                //end of username

                //bio
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(10, 1, 0, 0),
                  child: const Text(
                    'bio',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                //end of bio

                //edit profile button
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FollowButton(
                      text: 'Edit profile',
                      backgroundColor: Palette.backgroundColor,
                      borderColor: Palette.grey,
                      textColor: Colors.black,
                      function: () {},
                    )
                  ],
                ),
                //end of button



              ],
            ),
          ),
        ],
      ),
    );
  }
}





// function to show following/followers/# of posts

Column buildStatColumn(int num, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

      Text(
        num.toString(),
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,

        ),

      ),


      Container(
        margin: const EdgeInsets.only(top: 4),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),

        ),
      ),

    ],

  );

}