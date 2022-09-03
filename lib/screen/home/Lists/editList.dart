//EditList
import 'package:flutter/material.dart';
class EditList extends StatefulWidget {
  final listData;
  const EditList({Key? key, required this.listData}) : super(key: key);

  @override
  State<EditList> createState() => _EditListState();
}

class _EditListState extends State<EditList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text('${widget.listData["Title"]}'),
      ),
    );
  }
}
