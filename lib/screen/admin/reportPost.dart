import 'package:flutter/material.dart';

import '../../config/palette.dart';
class ReportPost extends StatefulWidget {
  const ReportPost({Key? key}) : super(key: key);

  @override
  State<ReportPost> createState() => _ReportPostState();
}

class _ReportPostState extends State<ReportPost> {
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
            Text("Report Post",
              style: TextStyle(
                  color: Palette.textColor
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Text("Report Post")
        ],
      ),
    );
  }
}
