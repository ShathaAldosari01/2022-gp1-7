import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp1_7_2022/config/palette.dart';
import 'package:gp1_7_2022/screen/admin/reportComment.dart';
import 'package:gp1_7_2022/screen/admin/reportList.dart';
import 'package:gp1_7_2022/screen/admin/reportPost.dart';


class AdminNavigationBar extends StatefulWidget {
  final int ind;
  const AdminNavigationBar({Key? key, required this.ind}) : super(key: key);
  @override
  _AdminNavigationBarState createState() => _AdminNavigationBarState();
}

class _AdminNavigationBarState extends State<AdminNavigationBar> {
  int index = 0;

  final screens = [
    ReportPost(),
    ReportComment(),
    ReportList(),
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
      Icon(Icons.amp_stories_sharp, size: 30, color: index==0? Palette.buttonColor: Palette.textColor),
      Icon(Icons.comment, size: 30, color: index==1? Palette.darkButtonColor: Palette.textColor),
      Icon(Icons.list, size: 30, color: index==2? Palette.darkButtonColor:  Palette.textColor),
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
              },
            ),
          ),
        ));
  }
}
