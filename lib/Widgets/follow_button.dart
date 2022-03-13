import 'package:flutter/material.dart';
import 'package:gp1_7_2022/screen/home/Profile_Page.dart';
import 'package:gp1_7_2022/config/palette.dart';
class FollowButton extends StatelessWidget {
  final Function()? function;
  final Color backgroundColor ;
  final Color borderColor ;
  final String text;
  final Color textColor;
  const FollowButton({Key? key, required this.function, required this.backgroundColor, required this.borderColor, required this.text, required this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: function ,
      child:
      Container(
        padding: const EdgeInsets.all(9),
        //style
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor,),
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: Text(text,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}