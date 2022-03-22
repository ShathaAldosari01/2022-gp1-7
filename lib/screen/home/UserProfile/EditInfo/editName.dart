import 'package:flutter/material.dart';

class EditName extends StatefulWidget {
  final uid;
  const EditName({Key? key, this.uid}) : super(key: key);

  @override
  _EditNameState createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  @override
  Widget build(BuildContext context) {
    return Text("name");
  }
}
