import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../config/palette.dart';
import '../auth/signup/userInfo/photo/utils.dart';
import '../home/TimeLine/ImageDisplayer.dart';
import '../home/TimeLine/comment_screen.dart';
import '../home/UserProfile/Profile_Page.dart';
import '../services/firestore_methods.dart';

class ReportedPost extends StatefulWidget {
  final report;
  const ReportedPost({Key? key, required this.report,}) : super(key: key);

  @override
  _ReportedPostState createState() => _ReportedPostState();
}

class _ReportedPostState extends State<ReportedPost> {

  /*attributes*/
  bool isLouded = false;
  var test = 0;
  String phoneNumber ="";
  var isContentShow = [];
  bool isFromList = false;
  var listData = {};
  var userData = [];
  List<bool> _isloaded = [];
  //database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var homePosts;

  // List<String> postIds =[];
  // List<dynamic> reportInfo =[];
  //
  // List<String> userIds =[];
  String usernames ="";


  @override
  void initState() {
    getUsername(widget.report["uid"]);
    super.initState();
  }

  getUsername(String uid)async{
    try {
      if (uid != null) {
        var userSnap = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get();

        setState(() {
          usernames = userSnap["username"].toString();
          isLouded= true;
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  /*get reported post ids*/


  /* get data method */
  getData(puid,index) async {
    try {
      if (puid != null) {
        var userSnap = await FirebaseFirestore.instance
            .collection('users')
            .doc(puid)
            .get();

        if (userSnap.data() != null) {
          userData[index] = (userSnap.data()!);
          setState(() {
            _isloaded[index] = true;
          });
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  /*user photo*/
  buildProfile(String profilePhoto, int index) {
    return SizedBox(
      width: 50,
      height: 50,
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => Profile_page(
                uid: userData[index]['uid'].toString(),
              ),
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
          title:

          Text("Reported Post",
            style: TextStyle(
              color: Palette.backgroundColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          )
      ),

      //fix overflowed error
      resizeToAvoidBottomInset: false,

      body:
      !isLouded?
      Container(
        margin: EdgeInsets.all(32),
        child: CircularProgressIndicator(
          backgroundColor: Palette.lightgrey,
          valueColor:
          AlwaysStoppedAnimation<Color>(Palette.midgrey),
        ),
      ):
      StreamBuilder(
          stream:
          FirebaseFirestore.instance.collection('posts')
              .where('postId', isEqualTo : widget.report["postId"])
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            int len = snapshot.data?.docs.length ?? 0;
            for (int i = 0; i < len; i++) {
              _isloaded.add(false);
              userData.add('');
            }
            for (int i = 0; i < len; i++) {
              if (!_isloaded[i]) {
                getData(snapshot.data!.docs[i].data()['uid'], i);
              }
            }

            if (snapshot.data == null) {
              return Center(
                child: Container(
                  child: Text(
                    isFromList?"No post has been added yet!"
                        :"User have no posts yet!",
                    style: TextStyle(
                      color: Palette.textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }
            else {
              int len = snapshot.data?.docs.length??0;
              for (int i=0; i<len ; i++){
                isContentShow.add([]);
              }
              return PageView.builder( //to make the page scroll
                itemCount: snapshot.data?.docs.length??0,
                controller: PageController(initialPage: 0, viewportFraction: 1),
                scrollDirection: Axis.vertical, //to scroll vertically
                itemBuilder: (context, index) {
                  int len = snapshot.data!.docs[index].data()['counter']+1;
                  for (int i=0; i<len ; i++){
                    isContentShow[index].add(true);
                  }
                  return PageView.builder( //to make the page scroll
                    itemCount: snapshot.data!.docs[index].data()['counter']+1,
                    controller: PageController(initialPage: 0, viewportFraction: 1),
                    scrollDirection: Axis.horizontal, //to scroll horizontally
                    itemBuilder: (context, indexIn) {
                      return indexIn==0?
                      Stack(
                        children: [
                          /*image*/
                          InkWell(
                            onTap:(){
                              isContentShow[index][indexIn]= !isContentShow[index][indexIn];
                            },
                            child: ImageDisplayer(
                              paths: snapshot.data!.docs[index].data()['imgsPath'].cast<String>(), title: snapshot.data!.docs[index].data()['title'], index: indexIn, isCover: snapshot.data!.docs[index].data()['isCoverPage'].cast<bool>(),
                            ),
                          ),
                          true?
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(2,80,2,0),
                                        color: Palette.backgroundColor,
                                        height: 3,
                                      ),
                                    ),
                                    for(int i=0; i< snapshot.data!.docs[index].data()['counter']; i++)
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(2,80,2,0),
                                          color: Palette.darkGray,
                                          height: 3,
                                        ),
                                      )
                                  ]
                              ),
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
                                                  _isloaded[index]
                                                      ? InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => Profile_page(
                                                            uid: userData[index]['uid'].toString(),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      "@" + userData[index]['username'].toString(),
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Palette.backgroundColor,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  )
                                                      : Container(
                                                    width: 100,
                                                    child: LinearProgressIndicator(
                                                      minHeight: 15,
                                                      backgroundColor: Colors.black.withOpacity(0.3),
                                                      valueColor: AlwaysStoppedAnimation<Color>(Palette.midgrey),
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
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height:7,
                                                    ),
                                                    /*profile img*/
                                                    _isloaded[index]?buildProfile(userData[index]['photoPath'].toString(), index):
                                                    Container(
                                                      margin: EdgeInsets.all(32),
                                                      child: CircularProgressIndicator(
                                                        backgroundColor: Palette.lightgrey,
                                                        valueColor:
                                                        AlwaysStoppedAnimation<Color>(Palette.midgrey),
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 7,
                                                        ),

                                                        /*report info*/
                                                        InkWell(
                                                          onTap: (){
                                                            onMore(widget.report, usernames, size);
                                                          },
                                                          child: Icon(
                                                            Icons.description,
                                                            size: 30,
                                                            color: Palette.backgroundColor,
                                                          ),
                                                        ),
                                                        /*end of report*/

                                                        SizedBox(
                                                          height: 25,
                                                        ),

                                                        /*comment*/
                                                        InkWell(
                                                          onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  CommentScreen(postId:  snapshot.data!.docs[index].data()['postId'].toString() ,postUid:  snapshot.data!.docs[index].data()['uid'].toString() ,),),),
                                                          child: Icon(
                                                            Icons.comment,
                                                            size: 30,
                                                            color: Palette.backgroundColor,
                                                          ),
                                                        ),

                                                        SizedBox(
                                                          height: 4,
                                                        ),

                                                        //num of comment
                                                        SizedBox(
                                                          child: Text(snapshot.data!.docs[index].data()['numOfComments'].toString(),
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Palette.backgroundColor
                                                            ),
                                                          ),
                                                        ),

                                                        /*end of comment*/
                                                        SizedBox(
                                                          height: 25,
                                                        ),

                                                      ],
                                                    )
                                                  ],
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
                                                  onTap: () {},
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
                          ): SizedBox(),
                        ],
                      )
                          : Stack(
                        children: [
                          /*image*/
                          ImageDisplayer(
                            paths: snapshot.data!.docs[index].data()['imgsPath'].cast<String>(), title: snapshot.data!.docs[index].data()['title'], index: indexIn, isCover: snapshot.data!.docs[index].data()['isCoverPage'].cast<bool>() ,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                  children: [
                                    for(int i=0; i< snapshot.data!.docs[index].data()['counter']+1; i++)
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(2,80,2,0),
                                          color: i!=indexIn?Palette.darkGray:Palette.backgroundColor,
                                          height: 3,
                                        ),
                                      )
                                  ]
                              ),
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
                                                            builder: (context) => Profile_page(
                                                              uid: userData[index]['uid'].toString(),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Text(
                                                        "@" + userData[index]['username'].toString(),
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
                                                      height: 12,
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
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 7,
                                                    ),
                                                    /*profile img*/
                                                    buildProfile(userData[index]['photoPath'].toString(), index),
                                                    Column(
                                                      children: [

                                                        SizedBox(
                                                          height: 7,
                                                        ),

                                                        /*report info*/
                                                        InkWell(
                                                          onTap: (){
                                                            onMore(widget.report, usernames, size);
                                                          },
                                                          child: Icon(
                                                            Icons.description,
                                                            size: 30,
                                                            color: Palette.backgroundColor,
                                                          ),
                                                        ),
                                                        /*end of report*/

                                                        SizedBox(
                                                          height: 25,
                                                        ),

                                                        /*comment*/
                                                        InkWell(
                                                          onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  CommentScreen(postId:  snapshot.data!.docs[index].data()['postId'].toString() ,postUid:  snapshot.data!.docs[index].data()['uid'].toString() ,),),),
                                                          child: Icon(
                                                            Icons.comment,
                                                            size: 30,
                                                            color: Palette.backgroundColor,
                                                          ),
                                                        ),

                                                        SizedBox(
                                                          height: 4,
                                                        ),

                                                        //num of comment
                                                        SizedBox(
                                                          child: Text(snapshot.data!.docs[index].data()['numOfComments'].toString(),
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Palette.backgroundColor
                                                            ),
                                                          ),
                                                        ),

                                                        /*end of comment*/
                                                        SizedBox(
                                                          height: 25,
                                                        ),

                                                        SizedBox(
                                                          height: 65,
                                                        ),

                                                      ],
                                                    )
                                                  ],
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
          }
      ),
    );
  }

  void onMore(reportInfo, username, size) {
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        color: Color(0xFF737373),
        height: 125,
        child: Container(
          child: onMorePressed(reportInfo, username, size),
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

  Column onMorePressed(reportInfo, username,size ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Row(
            children: [
              /*left*/
              SizedBox(
                width:size.width- 122,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*username*/
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Profile_page(
                              uid: reportInfo['uid'].toString(),
                            ),
                          ),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Reporter: ',
                          style: TextStyle(
                            color: Palette.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: username,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Palette.textColor,
                                  fontWeight: FontWeight.normal,
                                )),
                          ],
                        ),
                      ),
                    ),
                    /*end of username*/

                    SizedBox(
                        height: 5
                    ),

                    /*reason*/
                    reportInfo["reason"]==""?SizedBox():
                    Container(
                      child:SizedBox(
                        width: size.width- 122,
                        child: RichText(
                          text: TextSpan(
                            text: 'Reason: ',
                            style: TextStyle(
                              color: Palette.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: reportInfo["reason"],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Palette.textColor,
                                    fontWeight: FontWeight.normal,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    /*end of reason*/

                    SizedBox(
                        height: 5
                    ),

                    /*date of the report*/
                    Container(
                      child:SizedBox(
                        width: size.width- 122,
                        child: RichText(
                          text: TextSpan(
                            text: 'Date: ',
                            style: TextStyle(
                              color: Palette.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: DateFormat('dd MMM yyyy').format(reportInfo["date"].toDate()),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Palette.textColor,
                                    fontWeight: FontWeight.normal,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    /*end of date of report*/



                  ],
                ),
              ),

              SizedBox(
                width: 25,
              ),
              /*right*/
              Column(
                children: [
                  /*Accept */
                  IconButton(
                    /*no padding */
                      padding: EdgeInsets.all(10),
                      constraints: BoxConstraints(),
                      onPressed: (){
                        Alert(
                            context: context,
                            title: "Accept Report",
                            desc: "This will indicate that the reported post will be permanently deleted.",
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
                                color: Palette.green,
                                child: const Text(
                                  "Accept",
                                  style: TextStyle(
                                      color: Palette.backgroundColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                onPressed: ()  {
                                  Navigator.pop(context);
                                  FireStoreMethods().AcceptPostReport(reportInfo["postId"],reportInfo["reportId"]);
                                  setState(() {});
                                },
                              )
                            ]).show();

                      },
                      icon: Icon(
                        Icons.done,
                        size: 25,
                        color: Palette.green,
                      )
                  ),

                  /*decline */
                  IconButton(
                    /*no padding */
                      padding: EdgeInsets.all(10),
                      constraints: BoxConstraints(),
                      onPressed: (){
                        Alert(
                            context: context,
                            title: "Decline Report",
                            desc: "This will indicate that the post will remain and report will be ignored.",
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
                                  "Decline",
                                  style: TextStyle(
                                      color: Palette.backgroundColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                onPressed: ()  {
                                  Navigator.pop(context);
                                  FireStoreMethods().DeclinePostReport(reportInfo["reportId"], reportInfo["postId"],);
                                  setState(() {});
                                },
                              )
                            ]).show();
                      },
                      icon: Icon(
                        Icons.close,
                        size: 25,
                        color: Palette.red,
                      )
                  ),

                ],
              )
            ],
          ),
        ),
      ],
    );
  }


}
class Cut {
  String id;
  String title;
  bool isInList;

  Cut({required this.id, required this.title, required this.isInList});
}

