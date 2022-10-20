import 'package:flutter/material.dart';

import '../../config/palette.dart';
class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //appBar style
        elevation: 0.5,
        backgroundColor: Palette.backgroundColor,
        automaticallyImplyLeading: false, //no arrow,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Report",
              style: TextStyle(
                color: Palette.textColor
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Text("Report")
        ],
      ),
    );
  }
}
