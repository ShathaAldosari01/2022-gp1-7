import 'package:flutter/material.dart';
import 'package:gp1_7_2022/config/palette.dart';
class Empty extends StatelessWidget {
  const Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Text(""),
    );
  }
}
