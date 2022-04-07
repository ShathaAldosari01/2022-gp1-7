import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp1_7_2022/config/palette.dart';
import 'package:gp1_7_2022/screen/home/UserProfile/Profile_Page.dart';
import 'package:gp1_7_2022/screen/home/navBar/home_page.dart';
import 'package:gp1_7_2022/screen/home/navBar/lists.dart';
import 'package:gp1_7_2022/screen/home/navBar/notification_page.dart';
import 'package:gp1_7_2022/screen/home/navBar/search_page.dart';
import 'package:gp1_7_2022/screen/home/navBar/add_post_page.dart';


class navigationBar extends StatefulWidget {
  @override
  _navigationBarState createState() => _navigationBarState();
}

class _navigationBarState extends State<navigationBar> {
  int index = 0;

  final screens = [
    HomePage(),
    SearchPage(),
    AddPostPage(),
    lists(),
    NotificationPage(),
    Profile_page(uid: FirebaseAuth.instance.currentUser!.uid),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home, size: 30),
      Icon(Icons.search, size: 30),
      Icon(Icons.add, size: 30),
      Icon(Icons.list, size: 30),
      Icon(Icons.notifications_none, size: 30),
      Icon(Icons.person, size: 30),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: Palette.backgroundColor,


      body: IndexedStack(
        index: index,
        children: screens,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(color: Colors.white),
        ),

        child: CurvedNavigationBar(
          color: Palette.buttonColor,
          // buttonBackgroundColor: Palette.link,
          backgroundColor: Colors.transparent,
          height: 60,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          index: index,
          items: items,
          onTap: (index) => setState(() => this.index = index),
        ),
      ),
    );
  }
}

