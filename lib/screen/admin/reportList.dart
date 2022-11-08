import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:gp1_7_2022/screen/admin/reportedPost.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Widgets/refresh_widget.dart';
import '../../config/palette.dart';
import '../auth/signup/userInfo/photo/utils.dart';
import '../home/Lists/listCountent.dart';
import '../home/UserProfile/Profile_Page.dart';
import '../services/firestore_methods.dart';
class ReportList extends StatefulWidget {
  const ReportList({Key? key}) : super(key: key);

  @override
  State<ReportList> createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  /*attribute*/
  var userData = [];
  List<bool> _isloaded = [];

  late Future<QuerySnapshot<Map<String, dynamic>>> data;

  @override
  void initState() {
    data =  FirebaseFirestore.instance
        .collection('reportList')
        .orderBy("date", descending: true)
        .get();
    super.initState();
  }

  /*update when refresh*/
  Future updateReportData()async{
    try {
      setState(() {
        data =  FirebaseFirestore.instance
            .collection('reportList')
            .orderBy("date", descending: true)
            .get();
      });
    } catch (e) {
      print("try 1");
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
                Text("Report List",
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

      body: RefreshWidget(
        onRefresh: updateReportData,
        child: ListView(
          children: [
            /*report List*/
            FutureBuilder(
              future:data,
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
                        "No list report yet!",
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
                      childAspectRatio: 2.8,
                    ),
                    itemBuilder: (context, index) {
                      DocumentSnapshot snap =
                      (snapshot.data! as dynamic).docs[index];

                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        color: Palette.midgrey,
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child:  Row(
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

                                      /*reported content */
                                      InkWell(
                                        onTap: () {
                                          //todo: show reported list
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ListCountent(
                                                listId: snap['listId'],
                                              ),
                                            ),
                                          );
                                        },
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'Show reported list.',
                                            style: TextStyle(
                                              color: Palette.link,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      )
                                      /*end of reported content */

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
                                              desc: "This will indicate that the reported list will be permanently deleted.",
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
                                                  onPressed: ()  async {
                                                    Navigator.pop(context);
                                                    await FireStoreMethods().AcceptListReport(snap["listId"],snap["reportId"]);
                                                      showSnackBar(context, "Report has been accepted successfully!");
                                                    setState(() {
                                                      updateReportData();
                                                    });
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
                                              desc: "This will indicate that the list will remain and report will be ignored.",
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
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                    await FireStoreMethods().DeclineListReport(snap["reportId"],snap["listId"],);
                                                      showSnackBar(context, "Report has been declined successfully!");
                                                    setState(() {
                                                      updateReportData();
                                                    });
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

