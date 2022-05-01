import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
/*pages */
/*colors */
import 'package:gp1_7_2022/config/palette.dart';
import 'package:gp1_7_2022/Widgets/follow_button.dart';
import 'package:gp1_7_2022/screen/home/TimeLine/home_page.dart';
import 'package:gp1_7_2022/screen/home/navBar/lists.dart';
import 'package:gp1_7_2022/screen/home/navBar/notification_page.dart';
import 'package:gp1_7_2022/screen/home/navBar/search_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Profile_page extends StatefulWidget {
  final uid;
  const Profile_page({Key? key, required this.uid}) : super(key: key);

  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {
  bool _isloaded = false;
  var padding = 0.8;
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
        var userSnap = await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.uid)
            .get();
        if (userSnap.data() != null) {
          userData = userSnap.data()!;
          setState(() {
            _isloaded = true;
          });
          if (userData['name'].toString().isEmpty) {
            Navigator.of(context).popAndPushNamed('/name');
          } else if (userData["birthday"].toString().isEmpty) {
            Navigator.of(context).popAndPushNamed('/signupBirthday');
          } else if (userData['username'].toString().isEmpty) {
            Navigator.of(context).popAndPushNamed('/signupUsername');
          } else if (userData['questions']["married"]
                  .toString()
                  .compareTo("-1") ==
              0) {
            Navigator.of(context).popAndPushNamed('/question1');
          } else if (userData['questions']["children"]
                  .toString()
                  .compareTo("-1") ==
              0) {
            Navigator.of(context).popAndPushNamed('/question2');
          } else if (userData['questions']["gender"]
                  .toString()
                  .compareTo("-1") ==
              0) {
            Navigator.of(context).popAndPushNamed('/gender');
          } else if ((userData['questions']["countries"]["Middle eastern"]
                      .toString()
                      .compareTo("0") ==
                  0) &&
              (userData['questions']["countries"]["Asian"]
                      .toString()
                      .compareTo("0") ==
                  0) &&
              (userData['questions']["countries"]["European"]
                      .toString()
                      .compareTo("0") ==
                  0) &&
              (userData['questions']["countries"]["American"]
                      .toString()
                      .compareTo("0") ==
                  0) &&
              (userData['questions']["countries"]["African"]
                      .toString()
                      .compareTo("0") ==
                  0)) {
            Navigator.of(context).popAndPushNamed('/question4');
          } else if ((userData['questions']["places"]["Restaurants and cafes"]
                      .toString()
                      .compareTo("0") ==
                  0) &&
              (userData['questions']["places"]["Museums"]
                      .toString()
                      .compareTo("0") ==
                  0) &&
              (userData['questions']["places"]["Shopping malls"]
                      .toString()
                      .compareTo("0") ==
                  0) &&
              (userData['questions']["places"]["Parks"]
                      .toString()
                      .compareTo("0") ==
                  0) &&
              (userData['questions']["places"]["Sports attractions"]
                      .toString()
                      .compareTo("0") ==
                  0)) {
            //  Navigator.of(context).popAndPushNamed('/question5');
          }
        } else
          Navigator.of(context).popAndPushNamed('/Signup_Login');
      }else
        Navigator.of(context).popAndPushNamed('/navigationBar');
    } catch (e) {
      Navigator.of(context).popAndPushNamed('/Signup_Login');
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
        automaticallyImplyLeading: false, //no arrow
        centerTitle: true,
        //username
        title: _isloaded
            ? Text(
                userData['username'],
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              )
            : Container(
                width: 100,
                child: LinearProgressIndicator(
                  minHeight: 15,
                  backgroundColor: Palette.lightgrey,
                  valueColor: AlwaysStoppedAnimation<Color>(Palette.midgrey),
                ),
              ),

        //setting icon
        actions: [
          FocusedMenuHolder(
            //
            menuWidth: MediaQuery.of(context).size.width * 0.4,
            menuOffset: 0,
            menuItemExtent: 49,

            //list
            menuItems: [
              /*Log out*/
              FocusedMenuItem(
                  title: const Text("Log out"),
                  trailingIcon: const Icon(Icons.logout),
                  onPressed: () {
                    /*conform msg*/
                    Alert(
                        context: context,
                        /*text*/
                        title: "Are you want to log out",
                        buttons: [
                          /*cancel button*/
                          DialogButton(
                            color: Palette.darkGray,
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Palette.backgroundColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          /*end of cancel button*/

                          /*Log out*/
                          DialogButton(
                            color: Palette.red,
                            child: const Text(
                              "Log out",
                              style: TextStyle(
                                  color: Palette.backgroundColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            onPressed: ()  async {
                              /*go to sign up page*/
                              Navigator.pushNamed(context, '/');
                              return FirebaseAuth.instance.signOut();
                            },
                          )
                          /*log out*/
                        ]).show();
                    /*end of conform msg*/
                  }),
              /*end of Log out*/

              /*Settings*/
              FocusedMenuItem(
                title: const Text("Settings"),
                trailingIcon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).popAndPushNamed('/settings');
                },
              ),
              /*end of Settings*/

              /*Edit Profile*/
              FocusedMenuItem(
                title: const Text("Edit Profile"),
                trailingIcon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).popAndPushNamed('/editProfile');
                },
              ),
              /*end of Edit Profile*/
            ],

            openWithTap: true,
            onPressed: () {},

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
            alignment: Alignment.center,
            child: Column(
              children: [
                _isloaded
                    ? userData['photoPath'] != "no"
                        ? CircleAvatar(
                            backgroundColor: Palette.grey,
                            backgroundImage:
                                NetworkImage(userData['photoPath']),
                            radius: 45)
                        //user photo
                        : CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 45,
                            child: Icon(
                              Icons.account_circle_sharp,
                              color: Colors.grey,
                              size: 90,
                            ),
                          )
                    : Container(
                        margin: EdgeInsets.all(32),
                        child: CircularProgressIndicator(
                          backgroundColor: Palette.lightgrey,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Palette.midgrey),
                        ),
                      ),

                //username
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: _isloaded
                      ? Text("@"+
                          userData['username'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                      : Container(
                          width: 100,
                          child: LinearProgressIndicator(
                            minHeight: 15,
                            backgroundColor: Palette.lightgrey,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Palette.midgrey),
                          ),
                        ),
                ),
                //end of username

                //bio
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                  child: _isloaded
                      ? userData['bio'].toString().isNotEmpty
                          ? Text(
                              userData['bio'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            )
                          : SizedBox()
                      : Container(
                          width: 100,
                          child: LinearProgressIndicator(
                            minHeight: 15,
                            backgroundColor: Palette.lightgrey,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Palette.midgrey),
                          ),
                        ),
                ),
                //end of bio

                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(flex: 10, child: buildStatColumn(0, "Posts")),
                      Expanded(
                          flex: 10, child: buildStatColumn(0, "Followers")),
                      Expanded(
                          flex: 10, child: buildStatColumn(0, "Following")),
                    ],
                  ),
                ),
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
    children: [
      Text(
        num.toString(),
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      Container(
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
