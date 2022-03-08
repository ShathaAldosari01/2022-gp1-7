import 'package:flutter/material.dart';
/*pages */
/*colors */
import 'package:gp1_7_2022/config/palette.dart';
import 'package:gp1_7_2022/Widgets/follow_button.dart';

class Profile_page extends StatefulWidget {
  const Profile_page({Key? key}) : super(key: key);

  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
    appBar: AppBar(
    elevation: 0,
    backgroundColor: Palette.backgroundColor,
       title: Text('UserName',

              style: TextStyle(
                color: Colors.black,
             fontWeight: FontWeight.bold,
             fontSize: 18,
           ),

                  ),

    centerTitle: true,
),

      body: ListView(
       children: [
         Padding(
           padding: const EdgeInsets.all(16),
           child: Column(
             children: [
               Row(
                 children: [
                   CircleAvatar(
                    backgroundColor: Colors.grey ,
                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1635098996118-1ae0b325024e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80') ,
                     radius: 40,
                   ),
               Expanded(
                 flex: 1,
                 child: Column(
                   children: [
                     Row(
                      mainAxisSize: MainAxisSize.max,
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        buildStatColumn(20, "posts"),
                        buildStatColumn(150, "Followers"),
                        buildStatColumn(10, "Following"),
                       ],
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         FollowButton(
                           text: 'edit profile',
                           backgroundColor: Palette.backgroundColor,
                           borderColor: Colors.black,
                           textColor: Colors.black,
                           function: () {},
                         )
                       ],
                     )
                   ],
                 ),
               ),
                 ],
               ),
               Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 15,),
              child: Text( 'userName',
              style: TextStyle(
              fontWeight: FontWeight.bold,
                ),
              ),
               ),
               Container(
                 alignment: Alignment.centerLeft,
                 padding: const EdgeInsets.only(top: 1,),
                 child: Text( 'bio',
                 ),
               ),
             ],
           ),
         ),
       ],
      ),
    );
  }

  }





// function to show following/followers/# of posts

Column buildStatColumn(int num, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

      Text(
        num.toString(),
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,

        ),

      ),


      Container(
        margin: const EdgeInsets.only(top: 4),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),

        ),
      ),

    ],

  );

}
