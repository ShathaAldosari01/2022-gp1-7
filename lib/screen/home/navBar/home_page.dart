import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/palette.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Palette.backgroundColor,
        appBar: AppBar(
          backgroundColor: Palette.backgroundColor,
          foregroundColor: Palette.textColor,
          elevation: 0, //no shadow
          automaticallyImplyLeading: false, //no arrow

          actions: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                Navigator.of(context).popAndPushNamed('/notification');
              },
            )
          ],
        ),
        body: Center(
          child: Text(
            'Home',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
      );
}
