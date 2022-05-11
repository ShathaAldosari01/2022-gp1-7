import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp1_7_2022/config/palette.dart';
import 'package:gp1_7_2022/screen/home/UserProfile/Profile_Page.dart';
import 'package:gp1_7_2022/screen/home/TimeLine/home_page.dart';
import 'package:gp1_7_2022/screen/home/navBar/lists.dart';
import 'package:gp1_7_2022/screen/home/navBar/notification_page.dart';
import 'package:gp1_7_2022/screen/home/navBar/search_page.dart';

import '../addPost/AddPostPage.dart';
import 'empty.dart';

class navigationBar extends StatefulWidget {
  final int ind;
  const navigationBar({Key? key, required this.ind}) : super(key: key);
  @override
  _navigationBarState createState() => _navigationBarState();
}

class _navigationBarState extends State<navigationBar> {
  int index = 0;

  final screens = [
    HomePage(),
    SearchPage(),
    Empty(),
    lists(),
    Profile_page(uid: FirebaseAuth.instance.currentUser!.uid, ),
  ];

  @override
  void initState() {
    setState(() {
      index = widget.ind;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home, size: 30, color: index==0? Palette.buttonColor: Palette.textColor),
      Icon(Icons.search, size: 30, color: index==1? Palette.darkButtonColor: Palette.textColor),
      Icon(Icons.add, size: 30, color: index==2? Palette.darkButtonColor:  Palette.textColor),
      Icon(Icons.list, size: 30, color: index==3? Palette.darkButtonColor: Palette.textColor),
      Icon(Icons.person, size: 30, color: index==4? Palette.darkButtonColor:  Palette.textColor),
    ];

    return   WillPopScope(
        onWillPop: () async{

      return false;
    },
    child:Scaffold(
      extendBody: true,
      backgroundColor: Palette.backgroundColor,
      body: IndexedStack(
        index: index,
        children: screens,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(),
        ),
        child: CurvedNavigationBar(
          color: Palette.icongrey,
          backgroundColor: Colors.transparent,
          height: 50,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          index: index,
          items: items,
          onTap: (index) {
            setState(() {this.index = index;});
            if(index == 2){
              Navigator.of(context).popAndPushNamed('/addPost');
            }
          },
        ),
      ),
    ));
  }
}
