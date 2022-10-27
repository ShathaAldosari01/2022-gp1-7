
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:gp1_7_2022/screen/admin/reportedPost.dart';
import 'package:timeago/timeago.dart' as tago;
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Widgets/refresh_widget.dart';
import '../../config/palette.dart';
import '../auth/signup/userInfo/photo/utils.dart';
import '../home/UserProfile/Profile_Page.dart';
import '../services/firestore_methods.dart';
class ReportComment extends StatefulWidget {
  const ReportComment({Key? key}) : super(key: key);

  @override
  State<ReportComment> createState() => _ReportCommentState();
}

class _ReportCommentState extends State<ReportComment> {
  /*attribute*/
  var userData = [];
  List<bool> _isloaded = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<dynamic> commentsData =[];
  bool isLouded= false;

  @override
  void initState() {
    getComment();
    super.initState();
  }
  getComment() async{
    CollectionReference _collectionRef =
    await _firestore.collection('reportComment');

    Future<void> getData() async {
      List<dynamic> comments =[];
      // Get docs from collection reference
      QuerySnapshot querySnapshot = await _collectionRef.get();

      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

      allData.forEach((comment) async{
        String commentId = await (comment as dynamic)["commentId"];
        String postId = await (comment as dynamic)["postId"];


        var comSnap = await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).get();
        var comData = comSnap.data();
        comments.add(comData);
      });



      setState(() {
        isLouded = true;
        commentsData = comments;
      });
      print(allData);

    }
    await getData();
    // print(commentsData[0]["cid"]);
  }

  /*update when refresh*/
  Future updateReportData()async{
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('reportComment')
          .orderBy("date", descending: true)
          .get();

      setState(() {

      });
    } catch (e) {
      print(e.toString());
    }
  }

  /*retrieve date of the user who reported*/
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        //appBar style
        elevation: 0.5,
        backgroundColor: Palette.backgroundColor,
        automaticallyImplyLeading: false, //no arrow,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /*to make title at the center*/
            Padding(
              padding: const EdgeInsets.all(24),
              child:
              Icon(Icons.arrow_back, color: Palette.backgroundColor),
            ),

            /*title */
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Report Comment",
                  style: TextStyle(
                      color: Palette.textColor
                  ),
                ),
              ],
            ),

            /*log out*/
            FocusedMenuHolder(
              //
              menuWidth: MediaQuery.of(context).size.width * 0.4,
              menuOffset: 0,
              menuItemExtent: 49,

              //list
              menuItems: [
                /*Log out*/
                FocusedMenuItem(
                    title: const Text("Log out"),
                    trailingIcon: const Icon(Icons.logout),
                    onPressed: () {
                      /*conform msg*/
                      Alert(
                          context: context,
                          /*text*/
                          title: "Do you want to log out?",
                          buttons: [
                            /*cancel button*/
                            DialogButton(
                              color: Palette.darkGray,
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
                            /*end of cancel button*/

                            /*Log out*/
                            DialogButton(
                              color: Palette.red,
                              child: const Text(
                                "Log out",
                                style: TextStyle(
                                    color: Palette.backgroundColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              onPressed: () async {
                                /*go to sign up page*/
                                Navigator.pop(context);
                                Navigator.pushNamed(context, '/');
                                return FirebaseAuth.instance.signOut();
                              },
                            )
                            /*log out*/
                          ]).show();
                      /*end of conform msg*/
                    }),
                /*end of Log out*/

              ],

              openWithTap: true,
              onPressed: () {},

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Image.asset(
                  "assets/menu-icon.png",
                  height: 25,
                  width: 25,
                ),
              ),
            )
          ],
        ),

      ),

      body: !isLouded? Container(
        margin: EdgeInsets.all(32),
        child: CircularProgressIndicator(
          backgroundColor: Palette.lightgrey,
          valueColor:
          AlwaysStoppedAnimation<Color>(Palette.midgrey),
        ),
      ):
      RefreshWidget(
        onRefresh: updateReportData,
        child: ListView(
          children: [
            /*report posts*/
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('reportComment')
                  .orderBy("date", descending: true)
                  .get(),
              builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
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

                /*no reports?*/
                if (snapshot.data == null) {
                  return Center(
                    child: Container(
                      child: Text(
                        "No comment report yet!",
                        style: TextStyle(
                          color: Palette.textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }

                if((snapshot.data! as dynamic).docs.length ==0){
                  return Container();
                }
                else
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 0.5,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.8,
                    ),
                    itemBuilder: (context, index) {
                      DocumentSnapshot snap =
                      (snapshot.data! as dynamic).docs[index];

                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        color: Palette.midgrey,
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child:  Column(
                              children: [
                                Row(
                                  children: [
                                    /*left*/
                                    SizedBox(
                                      width:size.width- 122,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [_isloaded[index]
                                        /*username*/
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
                                                    text: userData[index]['username'].toString(),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Palette.textColor,
                                                      fontWeight: FontWeight.normal,
                                                    )),
                                              ],
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

                                          SizedBox(
                                              height: 5
                                          ),

                                          /*reason*/
                                          snap["reason"]==""?SizedBox():
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
                                                        text: snap["reason"],
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
                                                        text: DateFormat('dd MMM yyyy').format(snap["date"].toDate()),
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

                                          SizedBox(
                                              height: 5
                                          ),

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
                                                  desc: "This will indicate that the reported comment will be permanently deleted.",
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
                                                        if(FireStoreMethods().AcceptCommentReport(snap["commentId"],snap["postId"],snap["reportId"])=="")
                                                          showSnackBar(context, "Report has been accepted successfully!");

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
                                                  desc: "This will indicate that the comment will remain and report will be ignored.",
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
                                                        if(FireStoreMethods().DeclineCommentReport(snap["reportId"],snap["postId"],snap["commentId"] )=="success")
                                                          showSnackBar(context, "Report has been declined successfully!");
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
                                /*reported content */
                                Container(
                                  color: Palette.backgroundColor,
                                  child: SizedBox(
                                    width: size.width-50,
                                    child: ListTile(
                                      /*user photo*/
                                      leading: commentsData[index]['profilePhoto'] !='no' ?
                                      Container(
                                        child: CircleAvatar(
                                          backgroundColor: Colors.black,
                                          radius: 25,
                                          backgroundImage: NetworkImage(commentsData[index]['profilePhoto']),
                                        ),
                                      ):
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 25,
                                        child: Icon(
                                          Icons.account_circle_sharp,
                                          color: Colors.grey,
                                          size: 60,
                                        ),
                                      ),
                                      /*end of user photo*/

                                      title: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              /*username*/
                                              InkWell(
                                                onTap: () {  Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => Profile_page(
                                                      uid: commentsData[index]['uid'],
                                                    ),
                                                  ),
                                                ); },
                                                child: Text("${commentsData[index]['username']}  ",
                                                  style:  TextStyle(fontSize: 16,
                                                      color: Palette.textColor,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                              /*end of username*/

                                              SizedBox(height: 3,),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [

                                                  /*comment content*/
                                                  SizedBox(
                                                    width: size.width- 148,
                                                    child:
                                                    Text(commentsData[index]['comment'],
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Palette.textColor,
                                                          fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
                                                  /*end of comment content*/

                                                ],
                                              ),

                                              SizedBox(height: 3,),
                                            ],
                                          )


                                        ],
                                      ),
                                      /*date of comment*/
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            tago.format(commentsData[index]['datePublished'].toDate()),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Palette.darkGray,
                                                fontWeight: FontWeight.w700
                                            ),
                                          ),
                                        ],
                                      ),
                                      /*end of date of comment */

                                    ),
                                  ),
                                )
                                /*end of reported content */
                              ],
                            )
                        ),
                      );

                    },
                  );
              },
            ),


          ],
        ),
      ),
    );
  }
}

