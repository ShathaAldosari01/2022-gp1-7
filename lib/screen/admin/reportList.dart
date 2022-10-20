import 'package:flutter/material.dart';

import '../../config/palette.dart';
class ReportList extends StatefulWidget {
  const ReportList({Key? key}) : super(key: key);

  @override
  State<ReportList> createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
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
            Text("Report List",
              style: TextStyle(
                  color: Palette.textColor
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Text("Report List")
        ],
      ),
    );
  }
}
