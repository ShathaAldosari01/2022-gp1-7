import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/palette.dart';
import '../../../Widgets/refresh_widget.dart';
import '../../auth/signup/userInfo/photo/utils.dart';
import '../../services/firestore_methods.dart';
import '../UserProfile/Profile_Page.dart';
import 'ImageDisplayer.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //to open link
  var uid = FirebaseAuth.instance.currentUser!.uid;
  late Future<void> _launched;
  var homePosts;
  var userData = [];
  var theUserData ={};
  bool _isTheUserLoaded = false;
  String phoneNumber ="";
  List<bool> _isloaded = [];
  var isContentShow = [];
  String _launchUrl="https://www.google.com";

  @override
  void initState() {
    getTheData();
    super.initState();
  }

  /* get data method */
  getTheData() async {
    try {
      if ( uid!= null) {
        var userSnap = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get();

        /*end*/
        if (userSnap.data() != null) {
          theUserData = userSnap.data()!;
          theUserData['following'].add(uid);
          setState(() {
            _isTheUserLoaded = true;
            homePosts = FirebaseFirestore.instance.collection('posts').orderBy("datePublished", descending: true).where('uid', whereIn: theUserData['following']).snapshots();
          });

        } else
          Navigator.of(context).popAndPushNamed('/Signup_Login');
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

  Future loadPost() async{
    setState(() {
      homePosts = FirebaseFirestore.instance.collection('posts').orderBy("datePublished", descending: true).where('uid', whereIn: theUserData['following']).snapshots();
    });
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
                  (context) => Profile_page(uid: userData[index]['uid'].toString(),),
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
        automaticallyImplyLeading: false,
        //no arrow

        centerTitle: true,
        title: Text(
          "Following",
          style: TextStyle(
              color: Palette.backgroundColor
          ),
        ),
      ),

      body:  !_isTheUserLoaded?
      Center(
        child: Container(
          margin: EdgeInsets.all(32),
          child: CircularProgressIndicator(
            backgroundColor: Palette.lightgrey,
            valueColor:
            AlwaysStoppedAnimation<Color>(Palette.midgrey),
          ),
        ),
      ):
      RefreshWidget(
        onRefresh:loadPost,
        child: StreamBuilder(
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

              if (snapshot.data == null) {
                return Center(
                  child: Container(
                    child: Text(
                      "No posts yet!",
                      style: TextStyle(
                        color: Palette.textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }
              else{
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
                      InkWell(
                        onTap: (){
                          isContentShow[index][indexIn]= !isContentShow[index][indexIn];
                        },
                        child: Stack(
                          children: [
                            /*image*/
                            ImageDisplayer(
                              paths: snapshot.data!.docs[index].data()['imgsPath'].cast<String>(), title: snapshot.data!.docs[index].data()['title'], index: indexIn, isCover: snapshot.data!.docs[index].data()['isCoverPage'].cast<bool>(),
                            ),
                            isContentShow[index][indexIn]?
                            Column(
                              children: [
                                Expanded(
                                  child: Column(
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
                                      Column(
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
                                                        _isloaded[index]?
                                                        InkWell(
                                                          onTap: (){
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) => Profile_page(uid: userData[index]['uid'].toString(), ),
                                                              ),
                                                            );
                                                          },
                                                          child: Text(
                                                            "@"+userData[index]['username'].toString(),
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: Palette.backgroundColor,
                                                              fontWeight:FontWeight.bold,
                                                            ),
                                                          ),
                                                        )
                                                            : Container(
                                                          width: 100,
                                                          child: LinearProgressIndicator(
                                                            minHeight: 15,
                                                            backgroundColor: Colors.black.withOpacity(0.3),
                                                            valueColor:
                                                            AlwaysStoppedAnimation<Color>(Palette.midgrey),
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
                                                            _isloaded[index]?
                                                            buildProfile(userData[index]['photoPath'].toString(), index) : Container(
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

                                                                /*more*/
                                                                InkWell(
                                                                  onTap: (){
                                                                    onMore(snapshot.data!.docs[index].data()["postId"].toString(), snapshot.data!.docs[index].data()['uid'].toString(), snapshot.data!.docs[index].data()['datePublished'].toDate());
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

                                                      SizedBox(height: 60),
                                                    ],
                                                  ),
                                                ),
                                                /*end of right*/
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ):SizedBox(),
                          ],
                        ),
                      )
                          : InkWell(
                        onTap: (){
                          isContentShow[index][indexIn]= !isContentShow[index][indexIn];
                        },
                            child: Stack(
                        children: [
                            /*image*/
                            ImageDisplayer(
                              paths: snapshot.data!.docs[index].data()['imgsPath'].cast<String>(), title: snapshot.data!.docs[index].data()['title'], index: indexIn, isCover: snapshot.data!.docs[index].data()['isCoverPage'].cast<bool>() ,
                            ),
                              isContentShow[index][indexIn]?Column(
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
                                                                  (context) => Profile_page(uid:userData[index]['uid'].toString(),),
                                                            ),
                                                          );
                                                        },
                                                        child: Text(
                                                          "@"+userData[index]['username'].toString(),
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
                                                        height: 70,
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
                                                        buildProfile(userData[index]['photoPath'].toString(), index),
                                                        Column(
                                                          children: [

                                                            SizedBox(
                                                              height: 7,
                                                            ),

                                                            /*more*/
                                                            InkWell(
                                                              onTap: (){
                                                                onMore(snapshot.data!.docs[index].data()["postId"].toString(), snapshot.data!.docs[index].data()['uid'].toString(),  snapshot.data!.docs[index].data()['datePublished'].toDate());
                                                              },
                                                              child: Icon(
                                                                Icons.more_horiz,
                                                                size: 30,
                                                                color: Palette.backgroundColor,
                                                              ),
                                                            ),
                                                            /*end of more*/

                                                            SizedBox(
                                                              height: 117,
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
                            ):SizedBox(),
                        ],
                      ),
                          );
                    },
                  );
                },
              );
              }
            }
        ),
      ),
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
          Text("Delete post"):
          Text("Report post"),
          onTap: () {
            Navigator.pop(context);
            print("delete");
            if(FirebaseAuth.instance.currentUser!.uid== puid){
              Alert(
                  context: context,
                  title: "Are you sure you want to delete your post?",
                  desc: "Your post will be permanently deleted. You can't undo this action.",
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