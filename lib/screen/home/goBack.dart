import 'package:flutter/material.dart';

class GoBack extends StatefulWidget {
  const GoBack({Key? key}) : super(key: key);

  @override
  State<GoBack> createState() => _GoBackState();
}

class _GoBackState extends State<GoBack> {
  @override
  void initState() {
    super.initState();
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
