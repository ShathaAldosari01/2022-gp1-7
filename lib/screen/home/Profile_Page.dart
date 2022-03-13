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

class Profile_page extends StatefulWidget {
  const Profile_page({Key? key}) : super(key: key);

  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {
  var padding= 0.8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,

      appBar: AppBar(
        //appBar style
        elevation: 0,
        backgroundColor: Palette.backgroundColor,
        automaticallyImplyLeading: false,//no arrow
        //username
        title: const Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text(
            'UserName',
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
                    return FirebaseAuth.instance.signOut();
                  }
              ),
            ],

            openWithTap: true,
            onPressed: (){},

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Image.asset(
                "assets/menu-icon.png",
                height: 30,
                width: 30,
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
                    //user photo
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 1, 0, 0),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey ,
                        backgroundImage: NetworkImage('https://images.unsplash.com/photo-1635098996118-1ae0b325024e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80') ,
                        radius: 40,
                      ),
                    ),
                    //end user photo

                    Expanded(
                      flex: 1,
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
                  padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                  child: const Text(
                    'userName',
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
          fontSize: 22,
          fontWeight: FontWeight.bold,

        ),

      ),


      Container(
        margin: const EdgeInsets.only(top: 4),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),

        ),
      ),

    ],

  );

}