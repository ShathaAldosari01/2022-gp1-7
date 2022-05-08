import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/palette.dart';
import '../../auth/signup/userInfo/photo/utils.dart';
import '../../services/firestore_methods.dart';
import '../TimeLine/ImageDisplayer.dart';
import '../UserProfile/Profile_Page.dart';

class UserPost extends StatefulWidget {
  final uid;
  final index;
  final theUserData;
  const UserPost({Key? key, required this.uid, required this.index, required this.theUserData}) : super(key: key);

  @override
  _UserPostState createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {

  late Future<void> _launched;
  var theUserData ={};
  bool _isTheUserLoaded = false;
  String phoneNumber ="";
  String _launchUrl="https://www.google.com";

  @override
  void initState() {
    if(widget.theUserData==null){
      getTheData();
    }
    else
      setState(() {
         theUserData = widget.theUserData;
        _isTheUserLoaded = true;
      });
    super.initState();
  }

  /* get data method */
  getTheData() async {
    try {
      if ( widget.uid!= null) {
        var userSnap = await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.uid)
            .get();

        /*end*/
        if (userSnap.data() != null) {
          theUserData = userSnap.data()!;
          setState(() {
            _isTheUserLoaded = true;
          });

        }
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }


  deletePost(String postId) async {
    try {
      await FireStoreMethods().deletePost(postId);
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }


  Future<void> _launchInBrowser(String url) async{
    if(await canLaunch(url)){
      await launch(url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String> {'header_key': 'header_value'},
      );
    }else{
      throw 'Could not launch $url';
    }
  }

  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 50,
      height: 50,
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: theUserData.isNotEmpty?
                  (context) => Profile_page(uid: theUserData['uid'].toString(), userData: theUserData,):
                  (context) => Profile_page(uid: theUserData['uid'].toString(), userData: null,),
            ),
          );
        },
        child: Stack(
            children: [
              profilePhoto != "no"?
              Positioned(
                child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:
                      Image(
                        image: NetworkImage(profilePhoto),
                        fit: BoxFit.cover,
                      ),
                    )
                ),
              ): CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.8),
                radius: 25,
                child: Icon(
                  Icons.account_circle_sharp,
                  color: Colors.grey,
                  size: 50,
                ),
              )
            ]
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar:true,
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        foregroundColor: Palette.textColor,
        elevation: 0,
        //no shadow
        iconTheme: IconThemeData(
          color: Palette.backgroundColor, //change your color here
        ),
          centerTitle: true,
          title: _isTheUserLoaded
              ? Text(theUserData['name'],
            style: TextStyle(
              color: Palette.backgroundColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ):SizedBox()
      ),

      body:  !_isTheUserLoaded?
      Container(
        margin: EdgeInsets.all(32),
        child: CircularProgressIndicator(
          backgroundColor: Palette.lightgrey,
          valueColor:
          AlwaysStoppedAnimation<Color>(Palette.midgrey),
        ),
      ):
      StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').orderBy("datePublished", descending: true).where('uid', isEqualTo:widget.uid).snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data == null) {
              return Center(
                child: Container(
                  child: Text(
                    "User have no posts yet!",
                    style: TextStyle(
                      color: Palette.textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }
            else return PageView.builder( //to make the page scroll
              itemCount: snapshot.data?.docs.length??0,
              controller: PageController(initialPage: widget.index, viewportFraction: 1),
              scrollDirection: Axis.vertical, //to scroll vertically
              itemBuilder: (context, index) {
                return PageView.builder( //to make the page scroll
                  itemCount: snapshot.data!.docs[index].data()['counter']+1,
                  controller: PageController(initialPage: 0, viewportFraction: 1),
                  scrollDirection: Axis.horizontal, //to scroll horizontally
                  itemBuilder: (context, indexIn) {
                    return indexIn==0?
                    Stack(
                      children: [
                        /*image*/
                        ImageDisplayer(
                          paths: snapshot.data!.docs[index].data()['imgsPath'].cast<String>(), title: snapshot.data!.docs[index].data()['title'], index: index, isCover: snapshot.data!.docs[index].data()['isCoverPage'].cast<bool>(),
                        ),
                        Column(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      Container(
                                        width: size.width-49,
                                        color: Colors.black.withOpacity(0.3),
                                        padding: EdgeInsets.only(left: 15),
                                        child: Row(
                                          children: [
                                            /*left*/
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                /*title*/
                                                snapshot.data!.docs[index].data()['imgsPath'][0]!= "no"
                                                    ?Container(
                                                  width: size.width-168,// to avoid over... problem
                                                  child: Text(
                                                    snapshot.data!.docs[index].data()['title'].toString(),
                                                    textAlign:TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Palette.backgroundColor,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                ): SizedBox(),
                                                /*end of title*/

                                                SizedBox(height: 5),

                                                /*username*/
                                                InkWell(
                                                  onTap: (){
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: theUserData.isNotEmpty?
                                                            (context) => Profile_page(uid: theUserData['uid'].toString(), userData: theUserData,):
                                                            (context) => Profile_page(uid: theUserData['uid'].toString(), userData: null,),
                                                      ),
                                                    );
                                                  },
                                                  child: Text(
                                                    "@"+theUserData['username'].toString(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Palette.backgroundColor,
                                                      fontWeight:FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                /*end of username*/

                                                SizedBox(height: 5),

                                                /*location*/
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(0,2,2,2),
                                                      child: const Icon(
                                                        Icons.corporate_fare ,
                                                        size: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),

                                                    Container(
                                                      width: size.width-90,
                                                      child: Text(
                                                        snapshot.data!.docs[index].data()['name'].toString(),
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                /*end of location*/

                                              ],
                                            ),
                                            /*end of left*/

                                          ],
                                        ),
                                      ),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            /*right icons */
                                            Container(
                                              color: Colors.black.withOpacity(0.3),
                                              margin: EdgeInsets.only(top:size.height/8),
                                              child: Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height:7,
                                                    ),
                                                    /*profile img*/
                                                    buildProfile(theUserData['photoPath'].toString()) ,
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
                                                          onTap: (){
                                                            onMore(snapshot.data!.docs[index].data()["postId"].toString(), snapshot.data!.docs[index].data()['uid'].toString());
                                                          },
                                                          child: Icon(
                                                            Icons.more_horiz,
                                                            size: 30,
                                                            color: Palette.backgroundColor,
                                                          ),
                                                        ),
                                                        /*end of more*/

                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            /*end of right icons */

                                          ],
                                        ),
                                      ),

                                    ],
                                  ),

                                  Container(
                                    color: Colors.black.withOpacity(0.3),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 15),
                                          child:Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 5),
                                              /*category */
                                              InkWell(
                                                onTap: () {
                                                  _launchInBrowser('https://www.google.com');
                                                },
                                                child: Container(
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(0,2,2,2),
                                                        child: const Icon(
                                                          Icons.folder_open,
                                                          size: 15,
                                                          color: Colors.white,
                                                        ),
                                                      ),

                                                      Text(
                                                        snapshot.data!.docs[index].data()['type'].toString(),
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              /*end of category*/

                                              SizedBox(height: 5),

                                              /*country*/
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(0,2,2,2),
                                                    child: const Icon(
                                                      Icons.place_outlined,
                                                      size: 15,
                                                      color: Colors.white,
                                                    ),
                                                  ),

                                                  Container(
                                                    child: Text(
                                                      snapshot.data!.docs[index].data()['city'].toString() +", "+ snapshot.data!.docs[index].data()['country'].toString(),
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              /*end of country*/

                                            ],
                                          ),
                                        ),


                                        /*right*/
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                                          child: Column(
                                            // mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 5),
                                              /*rating*/
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  for ( var i = 0; i < snapshot.data!.docs[index].data()['rating']; i++)
                                                    Icon(
                                                      Icons.star,
                                                      color: Palette.backgroundColor,
                                                      size: 18,
                                                    ),
                                                  for ( var i = 0; i < (5-snapshot.data!.docs[index].data()['rating']); i++)
                                                    Icon(
                                                      Icons.star_border,
                                                      color: Palette.backgroundColor,
                                                      size: 18,
                                                    ),

                                                ],
                                              ),

                                              SizedBox(height: 5),

                                              /*date */
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  const Icon(
                                                    Icons.date_range,
                                                    size: 15,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 2),
                                                  Text(DateFormat('MMM yyyy').format(snapshot.data!.docs[index].data()['dateVisit'].toDate()),
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              /*end of date*/

                                              SizedBox(height: 5),
                                            ],
                                          ),
                                        ),
                                        /*end of right*/
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                        : Stack(
                      children: [
                        /*image*/
                        ImageDisplayer(
                          paths: snapshot.data!.docs[index].data()['imgsPath'].cast<String>(), title: snapshot.data!.docs[index].data()['title'], index: indexIn, isCover: snapshot.data!.docs[index].data()['isCoverPage'].cast<bool>() ,
                        ),
                        Column(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      Container(
                                        color: Colors.black.withOpacity(0.3),
                                        padding: EdgeInsets.only(left: 15),
                                        child: Row(
                                          children: [
                                            /*left*/
                                            Container(
                                              width: size.width-64,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [

                                                  SizedBox(height: 5),

                                                  /*username*/

                                                  InkWell(
                                                    onTap: (){
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: theUserData.isNotEmpty?
                                                              (context) => Profile_page(uid: theUserData['uid'].toString(), userData: theUserData,):
                                                              (context) => Profile_page(uid: theUserData['uid'].toString(), userData: null,),
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      "@"+theUserData['username'].toString(),
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Palette.backgroundColor,
                                                        fontWeight:FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  /*end of username*/

                                                  SizedBox(height: 5),

                                                  /*username*/
                                                  Text(
                                                    snapshot.data!.docs[index].data()['bodies'][indexIn-1].toString(),
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Palette.backgroundColor,
                                                    ),
                                                  ),
                                                  /*end of username*/

                                                  SizedBox(
                                                    height: 5,
                                                  ),

                                                ],
                                              ),
                                            ),
                                            /*end of left*/
                                          ],
                                        ),
                                      ),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            /*right icons */
                                            Container(
                                              color: Colors.black.withOpacity(0.3),
                                              child: Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 7,
                                                    ),
                                                    /*profile img*/
                                                    buildProfile(theUserData['photoPath'].toString()),
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
                                                          onTap: (){
                                                            onMore(snapshot.data!.docs[index].data()["postId"].toString(), snapshot.data!.docs[index].data()['uid'].toString());
                                                          },
                                                          child: Icon(
                                                            Icons.more_horiz,
                                                            size: 30,
                                                            color: Palette.backgroundColor,
                                                          ),
                                                        ),
                                                        /*end of more*/

                                                        SizedBox(
                                                          height: 140,
                                                        ),

                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            /*end of right icons */

                                          ],
                                        ),
                                      ),

                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            );
          }
      ),
    );
  }

  void onMore(String postId, puid) {
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        color: Color(0xFF737373),
        height: 180/3,
        child: Container(
          child: onMorePressed(postId, puid),
          decoration: BoxDecoration(
            color: Palette.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10),
              topRight: const Radius.circular(10),

            ),
          ),
        ),
      );


    });
  }

  Column onMorePressed(String postId, puid) {
    return Column(
      children:  [
        ListTile(
          leading: (FirebaseAuth.instance.currentUser!.uid== puid)?
          Icon(Icons.delete):
          Icon(Icons.flag),
          title: (FirebaseAuth.instance.currentUser!.uid== puid)?
          Text("Delete Post"):
          Text("Report Post"),
          onTap: () {
            Navigator.pop(context);
            print("delete");
            if(FirebaseAuth.instance.currentUser!.uid== puid){
              Alert(
                  context: context,
                  title: "Are you sure you want to delete your post?",
                  desc: "Your post will be permanently deleted. You can't undo.",
                  buttons: [
                    DialogButton(
                      color: Palette.grey,
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            color: Palette.backgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    DialogButton(
                      color: Palette.red,
                      child: const Text(
                        "Delete",
                        style: TextStyle(
                            color: Palette.backgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      onPressed: ()  {
                        Navigator.pop(context);
                        deletePost(postId);
                        setState(() {});
                      },
                    )
                  ]).show();
            }else{
              Alert(
                context: context,
                title: "Report Post",
                desc: "Report post will be implemented next release stay tuned!",
              ).show();
            }

          },
        )
      ],
    );
  }
}
