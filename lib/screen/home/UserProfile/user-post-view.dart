import 'dart:math';
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
import '../Lists/addList.dart';
import '../TimeLine/ImageDisplayer.dart';
import '../UserProfile/Profile_Page.dart';

class UserPost extends StatefulWidget {
  final uid;
  final index;
  final theUserData;
  final fromList;
  final listInfo;
  const UserPost({Key? key, required this.uid, required this.index, required this.theUserData, this.fromList, this.listInfo}) : super(key: key);

  @override
  _UserPostState createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {

  late Future<void> _launched;
  var test = 0;
  var theUserData ={};
  bool _isTheUserLoaded = false;
  String phoneNumber ="";
  var isContentShow = [];
  bool isFromList = false;
  var listData = {};
  var userData = [];
  List<bool> _isloaded = [];
  //database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var homePosts;

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

    if(widget.fromList!= null && widget.listInfo !=null)
      setState(() {
        isFromList = true;
        listData = widget.listInfo;
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
          print("done");
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }


  Future loadPost() async{
    print("hi 1");
    setState(() {
      _isloaded = [];
      userData = [];
    });
    print("hi 2");
    getTheData();
    print("hi 3");
    setState(() {
      homePosts = FirebaseFirestore.instance.collection('posts').orderBy("datePublished", descending: true).where('uid', whereIn: theUserData['following']).snapshots();
    });
    print("hi 4");
    StreamBuilder(
        stream: homePosts,
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          int len = snapshot.data?.docs.length??0;
          for(int i = 0 ; i < len ; i++){
            _isloaded.add(false);
            userData.add('');
          }
          for(int i = 0 ; i < len ; i++){
            if(!_isloaded[i]) {
              getData(snapshot.data!.docs[i].data()['uid'], i);
            }
          }

          return SizedBox();
        }
    );


  }

  deletePost(String postId) async {
    try {
      await FireStoreMethods().deletePost(postId);
      showSnackBar(context, "post was deleted successfully!");
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

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
              isFromList?(context) => Profile_page(
                uid: userData[index]['uid'].toString(),
              )
                  :(context) => Profile_page(uid: theUserData['uid'].toString(),),
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

          Text(isFromList?listData["Title"]:
          _isTheUserLoaded?theUserData['name']:"",
            style: TextStyle(
              color: Palette.backgroundColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          )
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
          stream: isFromList?
          FirebaseFirestore.instance.collection('posts')
          // .orderBy("datePublished", descending: true)
              .where('postId',  whereIn: listData['postIds'])
              .snapshots()
              :FirebaseFirestore.instance.collection('posts')
              .orderBy("datePublished", descending: true)
              .where('uid', isEqualTo :widget.uid)
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
                controller: PageController(initialPage: widget.index, viewportFraction: 1),
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
                                                  isFromList?
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
                                                  )
                                                      :InkWell(
                                                    onTap: (){
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder:
                                                              (context) => Profile_page(uid: theUserData['uid'].toString(), ),
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
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height:7,
                                                    ),
                                                    /*profile img*/
                                                    isFromList?
                                                    _isloaded[index]?buildProfile(userData[index]['photoPath'].toString(), index):
                                                    Container(
                                                      margin: EdgeInsets.all(32),
                                                      child: CircularProgressIndicator(
                                                        backgroundColor: Palette.lightgrey,
                                                        valueColor:
                                                        AlwaysStoppedAnimation<Color>(Palette.midgrey),
                                                      ),
                                                    )
                                                        :
                                                    buildProfile(theUserData['photoPath'].toString(), 0) ,
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 7,
                                                        ),
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
                                                          onTap: (){
                                                            addPostToList(snapshot.data!.docs[index].data()["postId"].toString() );
                                                          },
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

                                                        /*more*/
                                                        InkWell(
                                                          onTap: (){
                                                            onMore(snapshot.data!.docs[index].data()["postId"].toString(), snapshot.data!.docs[index].data()['uid'].toString(),  snapshot.data!.docs[index].data()["datePublished"].toDate());
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
                                                            builder:
                                                            isFromList? (context) => Profile_page(
                                                              uid: userData[index]['uid'].toString(),
                                                            )
                                                                :(context) => Profile_page(uid: theUserData['uid'].toString(), ),
                                                          ),
                                                        );
                                                      },
                                                      child: Text(
                                                        isFromList?
                                                        "@" + userData[index]['username'].toString()
                                                            :"@"+theUserData['username'].toString(),
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
                                                    isFromList?
                                                    buildProfile(userData[index]['photoPath'].toString(), index)
                                                        :buildProfile(theUserData['photoPath'].toString(),0),
                                                    Column(
                                                      children: [

                                                        SizedBox(
                                                          height: 7,
                                                        ),
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
                                                          onTap: (){
                                                            addPostToList(snapshot.data!.docs[index].data()["postId"].toString() );
                                                          },
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

                                                        /*more*/
                                                        InkWell(
                                                          onTap: (){
                                                            onMore(snapshot.data!.docs[index].data()["postId"].toString(), snapshot.data!.docs[index].data()['uid'].toString(), snapshot.data!.docs[index].data()["datePublished"].toDate());
                                                          },
                                                          child: Icon(
                                                            Icons.more_horiz,
                                                            size: 30,
                                                            color: Palette.backgroundColor,
                                                          ),
                                                        ),
                                                        /*end of more*/

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
// For adding post to list
  void addPostToList(String postId) {
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        color: Color(0xFF737373),
        height: 180/3+22+200,
        child: Container(
          child: addPostToListPressed(postId, theUserData['listIds'],theUserData["uid"]),
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
  ListView addPostToListPressed(String postId, listIds, uid) {
    // var x = retrieveListData(listIds, uid);
    return ListView(
      children:  [
        Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child:Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween ,
              children: [
                Text(
                  "Save post to...",
                  style: TextStyle(
                    color: Palette.textColor,
                    fontSize: 18,
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => AddList(pid: postId),
                      ),
                    );
                  },
                  child: Text(
                    "+ NEW LIST",
                    style: TextStyle(
                      color: Palette.link,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            )
        ),

        //retrieve list from database
        FutureBuilder(
            future: retrieveListData(listIds, uid),
            builder: (context, snapchat) {
              if (snapchat.hasData) {
                var data = snapchat.data!;
                List<Cut> listIdTitle = [];
                int startIdIndex = 0;
                int endIdIndex = 0;
                String id = "";

                int startTitleIndex = 0;
                int endTitleIndex = 0;
                String title = "";

                int startPostIdsIndex = 0;
                int endPostIdsIndex = 0;
                List<String> postIds = [];
                String postIdTemp = "";
                bool isLastPost= false;
                bool isInList = false;

                print('data');
                print(data);

                while (true) {
                  isLastPost = false;
                  isInList = false;
                  postIds = [];
                  //list id
                  startIdIndex =
                      data.toString().indexOf("ListID:", startIdIndex + 1) + 8;
                  endIdIndex =
                      data.toString().indexOf(", postIds:", endIdIndex + 1);

                  //title
                  startTitleIndex =
                      data.toString().indexOf("Title:", startTitleIndex + 1) +
                          7;
                  endTitleIndex =
                      data.toString().indexOf(", users:", endTitleIndex + 1);

                  //list id
                  if (startIdIndex != -1 && endIdIndex != -1)
                    id = data.toString().substring(startIdIndex, endIdIndex);
                  else {
                    break;
                  }

                  //PostIds
                  startPostIdsIndex =
                      data.toString().indexOf("postIds:", startPostIdsIndex + 1) + 10;

                  int endPostIdsIndex1 = data.toString().indexOf("]", startPostIdsIndex + 1);
                  int endPostIdsIndex2 = data.toString().indexOf(", ", startPostIdsIndex + 1);
                  endPostIdsIndex = min(endPostIdsIndex1, endPostIdsIndex2);

                  if(endPostIdsIndex ==endPostIdsIndex1){
                    isLastPost = true;
                  }

                  while(endPostIdsIndex!=-1 && startPostIdsIndex < endPostIdsIndex && startPostIdsIndex != -1 && startPostIdsIndex+1 != endPostIdsIndex){
                    postIdTemp = data.toString().substring(startPostIdsIndex, endPostIdsIndex);
                    postIds.add(postIdTemp);

                    if(isLastPost){
                      break;
                    }

                    //update start and end
                    startPostIdsIndex = data.toString().indexOf(", ", endPostIdsIndex)+ 2;
                    int endPostIdsIndex1 = data.toString().indexOf("]", startPostIdsIndex + 1);
                    int endPostIdsIndex2 = data.toString().indexOf(", ", startPostIdsIndex + 1);
                    endPostIdsIndex = min(endPostIdsIndex1, endPostIdsIndex2);

                    if(endPostIdsIndex ==endPostIdsIndex1){
                      isLastPost = true;
                    }
                  }

                  /*check if the post id exist? */
                  isInList = postIds.contains(postId);

                  //title
                  if (startTitleIndex != -1 && endTitleIndex != -1)
                    title = data
                        .toString()
                        .substring(startTitleIndex, endTitleIndex);
                  else {
                    break;
                  }

                  listIdTitle.add(Cut(id: id, title: title, isInList: isInList));
                }

                return StatefulBuilder(
                    builder: (BuildContext context, setState) => Column(
                      children: listIdTitle.map((e) {
                        return ListTile(
                          onTap: () {
                            print("before");
                            print(e.isInList);
                            /*update to the the database*/
                            if(e.isInList)
                              removePostToDatabase(postId, e.id, e.title);
                            else
                              addPostToDatabase(postId, e.id, e.title);
                            setState(() {
                              e.isInList = !e.isInList;
                            });
                            print("after");
                            print(e.isInList);
                          },
                          leading: Checkbox(
                              value: e.isInList,
                              onChanged: (bool? value) {
                                if(e.isInList)
                                  removePostToDatabase(postId, e.id, e.title);
                                else
                                  addPostToDatabase(postId, e.id, e.title);
                                setState(() {
                                  e.isInList = value!;
                                });
                              }),
                          title: Text(
                            e.title,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        );
                      }).toList(),
                    )
                );;
              } else {
                return SizedBox();
              }
            })

      ],
    );
  }

  void onMore(String postId, puid, date) {
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        color: Color(0xFF737373),
        height: 180/3+22,
        child: Container(
          child: onMorePressed(postId, puid, date),
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

  void onContentShow() {
    showModalBottomSheet(context: context, builder: (context){
      return Container(
          color: Color(0xFF737373),
          height: 0,
          child: SizedBox()
      );


    });
  }

  Column onMorePressed(String postId, puid, date) {
    return Column(
      children:  [
        Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child:RichText(
              text: TextSpan(
                text: 'Date posted: ',
                style: TextStyle(
                  color: Palette.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text:  DateFormat('dd/MM/yyyy').format(date).toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Palette.textColor,
                        fontWeight: FontWeight.normal,
                      )
                  ),
                ],
              ),
            )
        ),

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

  void addPostToDatabase(String postId, String listId, String title) async{
    /*todo add to database*/
    try {
      var uid = FirebaseAuth.instance.currentUser!.uid;
      print(uid);
      await _firestore.collection("posts").doc(postId).update({
        'listIds': FieldValue.arrayUnion([listId]),
      });
    } catch (e) {
      print(e);
    }

    try {
      var uid = FirebaseAuth.instance.currentUser!.uid;
      print(uid);
      await _firestore.collection("Lists").doc(listId).update({
        'postIds': FieldValue.arrayUnion([postId]),
      });
      Navigator.pop(context);
      showSnackBar(context, "Post has been added to "+title+" successfully!");
    } catch (e) {
      print(e);
    }
  }

  void removePostToDatabase(String postId, String listId, String title) async{

    print("postId");
    print(postId);
    print("listId");
    print(listId);

    try {
      var uid = FirebaseAuth.instance.currentUser!.uid;
      print(uid);
      await _firestore.collection("posts").doc(postId).update({
        'listIds': FieldValue.arrayRemove([listId]),
      });
      Navigator.pop(context);
      showSnackBar(context, "Post has been removed from "+title+"  successfully!");
    } catch (e) {
      print("something went wrong in removing post from list in post");
      print(e);
    }

    try {
      var uid = FirebaseAuth.instance.currentUser!.uid;
      print(uid);
      await _firestore.collection("Lists").doc(listId).update({
        'postIds': FieldValue.arrayRemove([postId]),
      });
    } catch (e) {
      print("something went wrong in removing post from list in list");
      print(e);
    }
  }

  Future retrieveListData(listIds, uid) async {
    print("here we go again!");
    print(listIds);
    var listData = [];
    int counter = 0;

    try {
      if (uid != null && listIds.isNotEmpty) {
        for (int i = 0; i < listIds.length; i++) {
          var snap = await FirebaseFirestore.instance
              .collection('Lists')
              .doc(listIds[i])
              .get();

          if (snap.data() != null) {
            if (snap.data()!["uid"] == uid) {
              listData.add(snap.data()!);
            }
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }

    return listData;
  }

}
class Cut {
  String id;
  String title;
  bool isInList;

  Cut({required this.id, required this.title, required this.isInList});
}

