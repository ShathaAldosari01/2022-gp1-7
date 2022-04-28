import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/palette.dart';
import 'ImageDisplayer.dart';

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
        body: PageView.builder(
         // itemCount: ,
          controller: PageController(initialPage: 0 , viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Stack(
              children: [
             ImageDisplayer(path:"https://firebasestorage.googleapis.com/v0/b/odyssey-f8a9d.appspot.com/o/profilePics%2FYUsRp7aY2AZkyuvvmrxIblhxY402?alt=media&token=b57db267-795d-46bf-ac78-171efd43c288")
              ],
            );
          },
        ),
      );
}
