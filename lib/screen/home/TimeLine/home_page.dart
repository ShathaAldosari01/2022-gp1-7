import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/palette.dart';
import 'ImageDisplayer.dart';

class HomePage extends StatelessWidget {

  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Stack(
          children: [
            Positioned(
              left: 5,
              child: Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: NetworkImage(profilePhoto),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ]
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        foregroundColor: Palette.textColor,
        elevation: 0,
        //no shadow
        automaticallyImplyLeading: false,
        //no arrow

        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.of(context).popAndPushNamed('/notification');
            },
          )
        ],
      ),
      body: PageView.builder( //to make the page scroll
        // itemCount: ,
        controller: PageController(initialPage: 0, viewportFraction: 1),
        scrollDirection: Axis.vertical, //to scroll vertically
        itemBuilder: (context, index) {
          return Stack(
            children: [
              /*image*/
              ImageDisplayer(
                  path: ""),
              Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            /*title*/
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: size.width-65,
                                    padding: EdgeInsets.fromLTRB(15, 3,15, 3 ),
                                    child: Text(
                                      "Title",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Palette.backgroundColor,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            /*end of title*/

                            /*right icons */
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  /*profile img*/
                                  buildProfile('https://firebasestorage.googleapis.com/v0/b/odyssey-f8a9d.appspot.com/o/profilePics%2FYUsRp7aY2AZkyuvvmrxIblhxY402?alt=media&token=b57db267-795d-46bf-ac78-171efd43c288'),
                                  Column(
                                    children: [
                                      /*like*/
                                      InkWell(
                                        onTap: (){},
                                        child: Icon(
                                          Icons.favorite_border,
                                          size: 30,
                                          color: Palette.backgroundColor,
                                        ),
                                      ),

                                      SizedBox(
                                        height: 4,
                                      ),

                                      Text(
                                        "200",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Palette.backgroundColor
                                        ),
                                      ),
                                      /*end of like*/

                                      SizedBox(
                                        height: 7,
                                      ),

                                      /*comment*/
                                      InkWell(
                                        onTap: (){},
                                        child: Icon(
                                          Icons.comment,
                                          size: 30,
                                          color: Palette.backgroundColor,
                                        ),
                                      ),

                                      SizedBox(
                                        height: 4,
                                      ),

                                      Text(
                                        "2",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Palette.backgroundColor
                                        ),
                                      ),
                                      /*end of comment*/

                                      SizedBox(
                                        height: 7,
                                      ),

                                      /*list*/
                                      InkWell(
                                        onTap: (){},
                                        child: Icon(
                                          Icons.playlist_add,
                                          size: 30,
                                          color: Palette.backgroundColor,
                                        ),
                                      ),

                                      SizedBox(
                                        height: 4,
                                      ),

                                      Text(
                                        "2",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Palette.backgroundColor
                                        ),
                                      ),
                                      /*end of list*/

                                      SizedBox(
                                        height: 7,
                                      ),

                                      /*share*/
                                      InkWell(
                                        onTap: (){},
                                        child: Icon(
                                          Icons.reply,
                                          size: 30,
                                          color: Palette.backgroundColor,
                                        ),
                                      ),

                                      SizedBox(
                                        height: 4,
                                      ),

                                      Text(
                                        "2",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Palette.backgroundColor
                                        ),
                                      ),
                                      /*end of share*/

                                      SizedBox(
                                        height: 7,
                                      ),

                                      /*more*/
                                      InkWell(
                                        onTap: (){},
                                        child: Icon(
                                          Icons.more_horiz,
                                          size: 30,
                                          color: Palette.backgroundColor,
                                        ),
                                      ),
                                      /*end of more*/

                                      SizedBox(
                                        height: 4,
                                      ),

                                    ],
                                  )
                                ],
                              ),
                            ),
                            /*end of right icons */
                          ],
                        ),


                        /*content*/
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              /*left*/
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    /*username*/
                                    Text(
                                      "@username",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Palette.backgroundColor,
                                      ),
                                    ),
                                    /*end of username*/

                                    SizedBox(height: 5),

                                    /*location*/
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          "location | Country, City",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    /*end of location*/

                                    SizedBox(height: 5),

                                    /*category */
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.all_inbox_rounded,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          "category",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    /*end of category*/

                                    SizedBox(
                                      height: 80,
                                    ),

                                  ],
                                ),
                              ),
                              /*end of left*/

                              /*right*/
                              Column(
                                // mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  /*rating*/
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Palette.backgroundColor,
                                        size: 18,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Palette.backgroundColor,
                                        size: 18,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Palette.backgroundColor,
                                        size: 18,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Palette.backgroundColor,
                                        size: 18,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Palette.backgroundColor,
                                        size: 18,
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 5),

                                  /*date */
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.date_range,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        "date",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  /*end of date*/

                                  SizedBox(height: 65),
                                ],
                              ),
                              /*end of right*/
                            ],
                          ),
                        ),
                        /*end of content*/

                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
