import 'package:flutter/material.dart';

import '../../config/palette.dart';
class ReportComment extends StatefulWidget {
  const ReportComment({Key? key}) : super(key: key);

  @override
  State<ReportComment> createState() => _ReportCommentState();
}

class _ReportCommentState extends State<ReportComment> {
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
            Text("Report Comment",
              style: TextStyle(
                  color: Palette.textColor
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Text("Report Comment")
        ],
      ),
    );
  }
}
