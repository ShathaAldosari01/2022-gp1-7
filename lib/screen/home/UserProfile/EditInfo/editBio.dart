import 'package:flutter/material.dart';

class EditBio extends StatefulWidget {
  final uid;
  const EditBio({Key? key, this.uid}) : super(key: key);

  @override
  _EditBioState createState() => _EditBioState();
}

class _EditBioState extends State<EditBio> {
  @override
  Widget build(BuildContext context) {
    return Text("bio");
  }
}
