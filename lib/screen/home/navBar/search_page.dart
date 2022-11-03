import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gp1_7_2022/config/palette.dart';
import 'package:gp1_7_2022/config/palette.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:uuid/uuid.dart';
import '../../auth/signup/userInfo/photo/utils.dart';
import '../../services/firestore_methods.dart';
import '../Lists/listCountent.dart';
import '../UserProfile/Profile_Page.dart';
import '../UserProfile/user-post-view.dart';
import 'package:http/http.dart'as http;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController =
      TextEditingController(text: "");

  getUserData(puid) async {
    try {
      if (puid != null) {
        var userSnap = await FirebaseFirestore.instance
            .collection('users')
            .doc(puid)
            .get();

        setState(() {
          userData = userSnap.data()!;
          _isUserLoaded = true;
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
  /*attributes*/

  /*userInfo*/
  var uid=FirebaseAuth.instance.currentUser!.uid;
  int age= 0;
  String socialState="";
  String haveChildren="";
  String gender="";
  String countries="";
  String places="";
  String tags="";

  bool _isUserLoaded = false;
  var userData = {};
  var userId; //the user visiting the page

  bool isShowUsers = true;
  bool isShowPosts = false;

  /*icons color*/
  Color UsersColor = Color(0xff1bd3db);
  Color PostsColor = Palette.darkGray;
  Color ListsColor = Palette.darkGray;

  /*visabilaty*/
  bool SUsers = true;
  bool SPosts = false;
  bool SLists = false;

  /*for recommender system*/
  List <String> finalRuselt = [];
  final _formkey = GlobalKey<FormState>();
  String title ="";

  /*reportController*/
  late TextEditingController reportController;

  /*list of list*/
  List<dynamic> listOfList =["0a3cb540-3fb3-11ed-9753-b34f46defa19"];

  @override
  void dispose() {
    reportController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    getUser();
    beforSearch();
    reportController = TextEditingController();
    userId = FirebaseAuth.instance.currentUser!.uid;
    getUserData(userId);
    super.initState();
  }

  Future<void> beforSearch() async {
    title="";
    // final url ='http://127.0.0.1:5000';
    final response = await http.post(Uri.parse('http://192.168.100.9:5000/title'),body: json.encode(
        {'userID': FirebaseAuth.instance.currentUser!.uid,"title":title,"places":places,"countries":countries,"gender":gender,"haveChildren":haveChildren,"socialState":socialState,"age":age,"tags":tags}));
    var listOfLists = json.decode(response.body);
    setState(() {
      listOfList = listOfLists;
    });
  }

  getUser() async {
    var uid=FirebaseAuth.instance.currentUser!.uid;
    try {
      if (uid != null) {
        print(uid);
        var userSnap = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get();

        userData = userSnap.data()!;

        String country = "";
        if (userData["questions"]["countries"]["Middle eastern"]==1){
          //Middle-eastern, Asian, European, American, Afr...
          country+="Middle-eastern";
        }
        if (userData["questions"]["countries"]["Asian"]==1){
          //Middle-eastern, Asian, European, American, Afr...
          if(country=="")
            country+="Asian";
          else{
            country+=", Asian";
          }
        }
        print(userData["questions"]["countries"]["European"].toString());
        print("here");
        if (userData["questions"]["countries"]["European"]==1){
          //Middle-eastern, Asian, European, American, Afr...
          if(country=="")
            country+="European";
          else{
            country+=", European";
          }
        }


        if (userData["questions"]["countries"]["American"]==1){
          //Middle-eastern, Asian, European, American, Afr...
          if(country=="")
            country+="American";
          else{
            country+=", American";
          }
        }
        if (userData["questions"]["countries"]["African"]==1){
          //Middle-eastern, Asian, European, American, Afr...
          if(country=="")
            country+="African";
          else{
            country+=", African";
          }
        }

        //places
        String place ="";
        if (userData["questions"]["places"]["Restaurants and cafes"]==1){
          //Restaurants, malls, Parks, Sports
          place+="Restaurants";
        }

        if (userData["questions"]["places"]["Shopping malls"]==1){
          //Restaurants, malls, Parks, Sports
          if(place=="")
            place+="malls";
          else{
            place+=", malls";
          }
        }

        if (userData["questions"]["places"]["Parks"]==1){
          //Restaurants, malls, Parks, Sports
          if(place=="")
            place+="Parks";
          else{
            place+=", Parks";
          }
        }

        if (userData["questions"]["places"]["Museums"]==1){
          //Restaurants, malls, Parks, Sports
          if(place=="")
            place+="Museums";
          else{
            place+=", Museums";
          }
        }

        if (userData["questions"]["places"]["Sports attractions"]==1){
          //Restaurants, malls, Parks, Sports
          if(place=="")
            place+="Sports";
          else{
            place+=", Sports";
          }
        }

        //calculate age
        DateTime birthday = DateTime.now();
        int now = birthday.year;
        int birth = userData["birthday"].toDate().year;
        int ageyear = now - birth;

        int nowMonth = birthday.month;
        int birthMonth = userData["birthday"].toDate().month;
        int ageMonth = nowMonth - birthMonth;

        int nowDay = birthday.day;
        int birthDay = userData["birthday"].toDate().day;
        int ageDay = nowDay - birthDay;

        if(ageDay <0)
          ageMonth--;

        if(ageMonth <0)
          ageyear--;

        String listOfTags = "";
        userData["tags"].forEach((tag){
          listOfTags+=tag+", ";
        });

        setState(() {
          userData = userSnap.data()!;
          age = ageyear;
          socialState = userData["questions"]["married"]==1?"Married":"Single";
          haveChildren = userData["questions"]["children"]==1?"Children":"noKids";
          gender = userData["questions"]["gender"]==0?"Female":"Male";
          countries = country;
          places = place;
          tags = listOfTags;
        });
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
        toolbarHeight: 120,
        backgroundColor: Palette.backgroundColor,
        flexibleSpace: Column(
          children: [

            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Form(
                key:_formkey,
                child: TextFormField(
                  onSaved: (value) async{

                  },
                  controller: searchController,
                  decoration: const InputDecoration(labelText: 'Search for ...'),
                  onFieldSubmitted: (String _) async{
                    title=_!;
                    // final url ='http://127.0.0.1:5000';
                    final response = await http.post(Uri.parse('http://192.168.100.9:5000/title'),body: json.encode(
                        {'userID': FirebaseAuth.instance.currentUser!.uid,"title":title,"places":places,"countries":countries,"gender":gender,"haveChildren":haveChildren,"socialState":socialState,"age":age,"tags":tags}));
                    var listOfLists = json.decode(response.body);
                    print("fund ne");
                    setState(() {
                      listOfList = listOfLists;
                    });
                  },
                ),
              ),
            ),

            SizedBox(
              height: 8,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //for search users
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(0.0),
                      child: IconButton(
                        //to remove the icon padding
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          onPressed: () {
                            setState(() {
                              UsersColor = Color(0xff1bd3db);
                              PostsColor = Palette.darkGray;
                              ListsColor = Palette.darkGray;

                              SUsers = true;
                              SPosts = false;
                              SLists = false;

                              isShowPosts = false;
                              isShowUsers = true;
                            });
                          },
                          icon: Icon(
                            Icons.account_circle,
                            color: UsersColor,
                            size: 30,
                          )),
                    ),

                    SizedBox(
                      height: 7,
                    ),

                    Container(
                      child: Text('  Users',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Palette.darkGray
                        ),
                      ),
                    ),
                  ],
                ),



                Container(
                    height: 25,
                    child: VerticalDivider(
                      color: Palette.darkGray,
                    )),

                //for search posts
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(0.0),
                      child: IconButton(
                        //to remove the icon padding
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: () {
                          setState(() {
                            UsersColor = Palette.darkGray;
                            PostsColor = Color(0xff1bd3db);
                            ListsColor = Palette.darkGray;

                            SUsers = false;
                            SPosts = true;
                            SLists = false;

                            isShowPosts = true;
                            isShowUsers = false;
                          });
                        },
                        icon: Icon(
                          Icons.amp_stories_sharp,
                          color: PostsColor,
                          size: 30,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),

                    Container(
                      child: Text('  Posts',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Palette.darkGray
                        ),
                      ),
                    ),
                  ],
                ),

                Container(
                    height: 25,
                    child: VerticalDivider(
                      color: Palette.darkGray,
                    )),

                //for search lists
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(0.0),
                      child: IconButton(
                        //to remove the icon padding
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: () {
                          setState(() {
                            UsersColor = Palette.darkGray;
                            PostsColor = Palette.darkGray;
                            ListsColor = Color(0xff1bd3db);

                            SUsers = false;
                            SPosts = false;
                            SLists = true;

                            isShowPosts = false;
                            isShowUsers = false;
                          });
                        },
                        icon: Icon(
                          Icons.list,
                          color: ListsColor,
                          size: 30,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 7,
                    ),

                    Container(
                      child: Text('  Lists',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Palette.darkGray
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

          ],
        ),
      ),

      resizeToAvoidBottomInset: false,
      body: ListView(
        children: [
          //vis for search users
          Visibility(
            visible: SUsers,
            child: Column(
              children: [
                isShowUsers
                    ? FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .where('username',
                              isGreaterThanOrEqualTo: searchController.text,
                            )
                            .get(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return (snapshot.data! as dynamic).docs == null
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      (snapshot.data! as dynamic).docs.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => Profile_page(
                                            uid: (snapshot.data! as dynamic)
                                                .docs[index]['uid'],
                                          ),
                                        ),
                                      ),
                                      child: (snapshot.data! as dynamic)
                                              .docs[index]['username']
                                              .toString()
                                              .isNotEmpty
                                          ? ListTile(
                                              leading: (snapshot.data!
                                                                  as dynamic)
                                                              .docs[index]
                                                          ['photoPath'] !=
                                                      "no"
                                                  ? CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                        (snapshot.data!
                                                                    as dynamic)
                                                                .docs[index]
                                                            ['photoPath'],
                                                      ),
                                                      radius: 16,
                                                    )
                                                  : CircleAvatar(
                                                      backgroundColor: Colors
                                                          .white
                                                          .withOpacity(0.8),
                                                      radius: 16,
                                                      child: Icon(
                                                        Icons
                                                            .account_circle_sharp,
                                                        color: Colors.grey,
                                                        size: 35,
                                                      ),
                                                    ),
                                              title: Text(
                                                (snapshot.data! as dynamic)
                                                    .docs[index]['username'],
                                              ),
                                            )
                                          : SizedBox(),
                                    );
                                  },
                                );
                        },
                      )
                    : FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('posts')
                            .orderBy('datePublished')
                            .get(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Text("hi");
                        }),
              ],
            ),
          ),


          //vis for search posts
          Visibility(
            visible: SPosts,
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('posts')
                  .where('address', isGreaterThanOrEqualTo: searchController.text
                  .toString()
                  .toUpperCase(),)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }


                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 1.5,
                    childAspectRatio: 0.6,
                  ),
                  itemBuilder: (context, index) {
                    DocumentSnapshot snap =
                    (snapshot.data! as dynamic).docs[index];

                    return Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: (size.width / 3) * (100 / 60) - 5.6,
                              color: Palette.backgroundColor,
                              child: snap['imgsPath'][0] != "no"
                                  ? Image(
                                image:
                                NetworkImage(snap['imgsPath'][0]),
                                fit: BoxFit.cover,
                              )
                                  : Center(
                                child: Container(
                                  color: Palette.buttonColor,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 4),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 3),
                                  child: Text(
                                    snap['title'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Palette.textColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: userData.isNotEmpty
                                    ? (context) =>  UserPost(
                                  searchPost: searchController.text.toString(),
                                  fromSearch: true,
                                  theUserData: userData,
                                  uid: snap['uid'].toString(),
                                  index: index,
                                )
                                    : (context) => UserPost(
                                    theUserData: null,
                                    uid: snap['uid'].toString(),
                                    index: index),
                              ),
                            );
                          },
                          child: Container(
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                onMore(
                                    snap["postId"].toString(),
                                    snap['uid'].toString(),
                                    snap["datePublished"].toDate());
                              },
                              child: Container(
                                padding:
                                const EdgeInsets.fromLTRB(20, 4, 0, 20),
                                child: Icon(
                                  Icons.more_vert_rounded,
                                  color: Palette.backgroundColor,
                                  size: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: userData.isNotEmpty
                                        ? (context) => UserPost(
                                        theUserData: userData,
                                        uid: snap['uid'].toString(),
                                        index: index)
                                        : (context) => UserPost(
                                        theUserData: null,
                                        uid: snap['uid'].toString(),
                                        index: index),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 7),
                                child: snap['imgsPath'][0] != "no"
                                    ? Text(
                                  snap['title'],
                                  style: TextStyle(
                                      color: Palette.backgroundColor,
                                      fontWeight: FontWeight.bold),
                                )
                                    : SizedBox(),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ),



          //vis for search lists
          Visibility(
            visible: true,
            child: Column(
              children: [
                //lists
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('Lists')
                          .where('ListID', whereIn: listOfList)
                          .where('Access', isEqualTo:true)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: (snapshot.data! as dynamic).docs.length,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 0.5,
                            mainAxisSpacing: 12,
                            childAspectRatio: 2,
                          ),
                          itemBuilder: (context, index) {
                            DocumentSnapshot snap =
                            (snapshot.data! as dynamic).docs[index];

                            return Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                                Palette.buttonColor,
                                                Palette.nameColor
                                              ])),

                                      height: size.height / 4.45,
                                      width: size.width - 20,
                                      child: snap['Cover'] != ""
                                          ? Container(
                                        child: ClipRRect(
                                          borderRadius:BorderRadius.circular(20) ,
                                          child: ColorFiltered(
                                            colorFilter:
                                            ColorFilter.mode(Colors.black.withOpacity(0.3),
                                                BlendMode.darken),
                                            child: Image(
                                              image: NetworkImage(
                                                  snap['Cover']),
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                      )
                                          : Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                            gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: [
                                                  Palette.buttonColor,
                                                  Palette.nameColor
                                                ])),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 4),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 6,
                                                  vertical: 7),
                                              child: Text(
                                                snap['Title'],
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: Palette
                                                      .backgroundColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ListCountent(
                                            listId: snap["ListID"],
                                          )),
                                    );
                                  },
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ListCountent(
                                                    listId: snap["ListID"],
                                                  )),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 7),
                                        child: snap['Cover'] != ""
                                            ? Text(
                                          snap['Title'],
                                          style: TextStyle(
                                              color: Palette
                                                  .backgroundColor,
                                              fontWeight:
                                              FontWeight.bold),
                                        )
                                            : SizedBox(),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          },
                        );
                      }),
                )



              ],
            ),
          )

        ],
      ),
    );
  }
  //functions

  void onMore(String postId, puid, date) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 180 / 3 + 22,
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
      children: [
        Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: RichText(
              text: TextSpan(
                text: 'Date posted: ',
                style: TextStyle(
                  color: Palette.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: DateFormat('dd/MM/yyyy').format(date).toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Palette.textColor,
                        fontWeight: FontWeight.normal,
                      )),
                ],
              ),
            )
        ),
        ListTile(
          leading: (FirebaseAuth.instance.currentUser!.uid == puid ||FirebaseAuth.instance.currentUser!.uid=="miostwrsWghrmT0qkc4Q0uhpA842")
              ? Icon(Icons.delete)
              : Icon(Icons.flag),
          title: (FirebaseAuth.instance.currentUser!.uid == puid || FirebaseAuth.instance.currentUser!.uid=="miostwrsWghrmT0qkc4Q0uhpA842")
              ? Text("Delete post")
              : Text("Report post"),
          onTap: () {
            Navigator.pop(context);
            if (FirebaseAuth.instance.currentUser!.uid == puid || FirebaseAuth.instance.currentUser!.uid=="miostwrsWghrmT0qkc4Q0uhpA842") {
              Alert(
                  context: context,
                  title: FirebaseAuth.instance.currentUser!.uid=="miostwrsWghrmT0qkc4Q0uhpA842"?"Are you sure you want to delete this post?":"Are you sure you want to delete your post?",
                  desc:FirebaseAuth.instance.currentUser!.uid=="miostwrsWghrmT0qkc4Q0uhpA842"?"This post will be permanently deleted. You can't undo this action.":
                  "Your post will be permanently deleted. You can't undo this action.",
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
                      onPressed: () {
                        Navigator.pop(context);
                        deletePost(postId);
                      },
                    )
                  ]).show();
            } else {
              openDialog(postId);
            }
          },
        )
      ],
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
  void reportPost(String postId, String reason) async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    String reportId = const Uuid().v1();
    try{
      String res = await FireStoreMethods().createReportPost(uid, postId, reportId,reason, DateTime.now() );
      if(res== "success"){

        showSnackBar(context, "Report has been send successfully!");
      }else{
        showSnackBar(context, res);
      }
    }catch(e){
      showSnackBar(context, e.toString());
    }
  }

  Future openDialog(String postId) {
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Report Post"),
            content: Container(
              height:96,
              child: Column(
                children: [
                  Text(
                    'Let us know more by adding a comment.',
                    style: TextStyle(
                        color: Palette.darkGray
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: reportController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Comment",
                    ),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Palette.grey,
                  ),
                ) ,
                onPressed: (){
                  reportController.clear();
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(
                  "Report",
                  style: TextStyle(
                    color: Palette.link,
                  ),
                ) ,
                onPressed: (){
                  reportPost(postId, reportController.text);
                  reportController.clear();
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
    );
  }



}


