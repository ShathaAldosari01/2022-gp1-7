import 'package:flutter/material.dart';

class EditUsername extends StatefulWidget {
  final uid;
  const EditUsername({Key? key, this.uid}) : super(key: key);

  @override
  _EditUsernameState createState() => _EditUsernameState();
}

class _EditUsernameState extends State<EditUsername> {
  @override
  Widget build(BuildContext context) {
    return Text("username");
  }
}
