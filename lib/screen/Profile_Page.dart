import 'package:flutter/material.dart';
/*pages */
/*colors */
import 'package:gp1_7_2022/config/palette.dart';


class Profile_page extends StatefulWidget {
  const Profile_page({Key? key}) : super(key: key);

  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {
  @override
  Widget build(BuildContext context) {
    return Container( child: Text('profile page',
      style: TextStyle(
        color: Palette.backgroundColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
    );
  }
}
