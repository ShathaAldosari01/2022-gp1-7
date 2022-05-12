import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';
import '../../../Widgets/follow_button.dart';
import '../../../Widgets/refresh_widget.dart';
import '../../auth/signup/userInfo/photo/utils.dart';
import 'package:gp1_7_2022/screen/home/UserProfile/EditInfo/editProfile.dart';
import 'package:gp1_7_2022/screen/home/UserProfile/settings.dart';

/*colors */
import 'package:gp1_7_2022/config/palette.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../services/firestore_methods.dart';
import 'following.dart';
import 'user-post-view.dart';

class Profile_page extends StatefulWidget {
  final uid;
  const Profile_page({Key? key, required this.uid}) : super(key: key);

  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {
  bool _isloaded = false;
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  var padding = 0.8;
  var userData = {};
  var uid;
  var theUserId = FirebaseAuth.instance.currentUser!.uid;
  bool isActive = true;

  @override
  void initState() {
    uid = widget.uid;
    getUser();
    super.initState();
  }
  getUser()async{
    try {
      if (widget.uid != null) {
        var userSnap = await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.uid)
            .get();

        setState(() {
          userData = userSnap.data()!;
          followers = userData['followers'].length;
          following = userData['following'].length;
          isFollowing =userData['followers']
              .contains(FirebaseAuth.instance.currentUser!.uid);
        });
        getData();
      }
    }catch(e){
      print(e.toString());
    }
  }

  /* get data method */
  getData() async {
    try {
      if (widget.uid != null) {

        /*get user post*/
        var postSnap = await FirebaseFirestore.instance
            .collection("posts")
            .orderBy("datePublished", descending: false)
            .where('uid', isEqualTo: widget.uid)
            .get();

        postLen = postSnap.docs.length;

        setState(() {});
        /*end*/
        if (userData!= null) {
          setState(() {
            _isloaded = true;
          });
          if(widget.uid==FirebaseAuth.instance.currentUser!.uid)
          if (userData['name'].toString().isEmpty) {
            Navigator.of(context).popAndPushNamed('/name');
          } else if (userData["birthday"].toString().isEmpty) {
            Navigator.of(context).popAndPushNamed('/signupBirthday');
          } else if (userData['username'].toString().isEmpty) {
            Navigator.of(context).popAndPushNamed('/signupUsername');
          } else if (userData['questions']["married"]
              .toString()
              .compareTo("-1") ==
              0) {
            Navigator.of(context).popAndPushNamed('/question1');
          } else if (userData['questions']["children"]
              .toString()
              .compareTo("-1") ==
              0) {
            Navigator.of(context).popAndPushNamed('/question2');
          } else if (userData['questions']["gender"]
              .toString()
              .compareTo("-1") ==
              0) {
            Navigator.of(context).popAndPushNamed('/gender');
          } else if ((userData['questions']["countries"]["Middle eastern"]
              .toString()
              .compareTo("0") ==
              0) &&
              (userData['questions']["countries"]["Asian"]
                  .toString()
                  .compareTo("0") ==
                  0) &&
              (userData['questions']["countries"]["European"]
                  .toString()
                  .compareTo("0") ==
                  0) &&
              (userData['questions']["countries"]["American"]
                  .toString()
                  .compareTo("0") ==
                  0) &&
              (userData['questions']["countries"]["African"]
                  .toString()
                  .compareTo("0") ==
                  0)) {
            Navigator.of(context).popAndPushNamed('/question4');
          } else if ((userData['questions']["places"]["Restaurants and cafes"]
              .toString()
              .compareTo("0") ==
              0) &&
              (userData['questions']["places"]["Museums"]
                  .toString()
                  .compareTo("0") ==
                  0) &&
              (userData['questions']["places"]["Shopping malls"]
                  .toString()
                  .compareTo("0") ==
                  0) &&
              (userData['questions']["places"]["Parks"]
                  .toString()
                  .compareTo("0") ==
                  0) &&
              (userData['questions']["places"]["Sports attractions"]
                  .toString()
                  .compareTo("0") ==
                  0)) {


          }
        } else
          Navigator.of(context).popAndPushNamed('/Signup_Login');
      }else
        Navigator.of(context).popAndPushNamed('/navigationBar');
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

  Future updateUserData()async{
    getUser();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        //appBar style
        elevation: 0,
        backgroundColor: Palette.backgroundColor,
        iconTheme: IconThemeData(
          color: Palette.textColor, //change your color here
        ),
        // automaticallyImplyLeading: false, //no arrow
        centerTitle: true,
        //username
        title: _isloaded
            ? Text(
          userData['name'],
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        )
            : Container(
          width: 100,
          child: LinearProgressIndicator(
            minHeight: 15,
            backgroundColor: Palette.lightgrey,
            valueColor: AlwaysStoppedAnimation<Color>(Palette.midgrey),
          ),
        ),

        //setting icon
        actions: [
          uid==FirebaseAuth.instance.currentUser!.uid?
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
                            onPressed: ()  async {
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

              /*Settings*/
              FocusedMenuItem(
                title: const Text("Settings"),
                trailingIcon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> settings())
                  );
                },
              ),
              /*end of Settings*/
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
          ):FocusedMenuHolder(
            //
            menuWidth: MediaQuery.of(context).size.width * 0.4,
            menuOffset: 0,
            menuItemExtent: 49,

            //list
            menuItems: [

              /*Log out*/
              FocusedMenuItem(
                  title: userData['username'].toString().length<4?
                  Container(child: Text("Share @"+userData['username'].toString())):
                  Container(child: Text("Share @"+userData['username'].toString().substring(0,4)+"...")),
                  trailingIcon: const Icon(Icons.logout),
                  onPressed: () {
                    showSnackBar(context, "This feature will be available next release. Stay tuned");
                  },
              ),
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
          ),
        ],
      ),

      //fix overload error
      resizeToAvoidBottomInset: false,

      body: RefreshWidget(
    onRefresh:updateUserData,
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  _isloaded
                      ? userData['photoPath'] != "no"
                      ? CircleAvatar(
                      backgroundColor: Palette.grey,
                      backgroundImage:
                      NetworkImage(userData['photoPath']),
                      radius: 45)
                  //user photo
               : CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 45,
                    child: Icon(
                      Icons.account_circle_sharp,
                      color: Colors.grey,
                      size: 90,
                    ),
                  )
                : Container(
                    margin: EdgeInsets.all(32),
                    child: CircularProgressIndicator(
                      backgroundColor: Palette.lightgrey,
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Palette.midgrey),
                    ),
                  ),

                  //username
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: _isloaded
                    ? Text("@"+
                        userData['username'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                   : Container(
                      width: 100,
                      child: LinearProgressIndicator(
                        minHeight: 15,
                        backgroundColor: Palette.lightgrey,
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Palette.midgrey),
                      ),
                    ),
                  ),
                  //end of username

                  //bio
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                    child: _isloaded
                        ? userData['bio'].toString().isNotEmpty
                        ? Text(
                      userData['bio'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )
                        : SizedBox()
                        : Container(
                      width: 100,
                      child: LinearProgressIndicator(
                        minHeight: 15,
                        backgroundColor: Palette.lightgrey,
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Palette.midgrey),
                      ),
                    ),
                  ),
                  //end of bio

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            flex: 10,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:userData.isNotEmpty?
                                        (context) => UserPost(theUserData: userData,uid: widget.uid.toString(),index: 0):
                                        (context) => UserPost(theUserData: null,uid: widget.uid.toString(),index: 0),
                                  ),
                                );
                              },
                                child: buildStatColumn(postLen, "Posts")
                            )
                        ),
                        Expanded(
                            flex: 10,
                            child: InkWell(
                                onTap:(){
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => Following(following:userData['followers'], isFollowing: false),
                                  ),
                                );
                                },
                                child: buildStatColumn(followers, "Followers")
                            )
                        ),
                        Expanded(
                            flex: 10,
                            child: InkWell(
                                onTap:(){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => Following(following:userData['following'],isFollowing: true, ),
                                    ),
                                  );
                                },
                                child: buildStatColumn(following, "Following")
                            )
                        ),
                      ],
                    ),
                  ),


                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    children: [
                      FirebaseAuth.instance.currentUser!.uid !=
                          widget.uid
                          ?
                      isFollowing
                          ? FollowButton(
                        text: 'Unfollow',
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        borderColor: Colors.grey,
                        function: isActive?() async {
                          setState(() {
                            isActive = false;
                            isFollowing = false;
                            followers--;
                          });
                          await FireStoreMethods()
                              .followUser(
                            FirebaseAuth.instance
                                .currentUser!.uid,
                            userData['uid'],
                          );
                          setState(() {
                            isActive =true;
                          });
                        }:null,
                        horizontal: (size.width/2)-50,
                        vertical: 9,
                      )
                          : FollowButton(
                        text: 'Follow',
                        backgroundColor: Palette.link,
                        textColor: Palette.backgroundColor,
                        borderColor: Palette.link,
                        function: isActive?() async {
                          setState(() {
                            isActive= false;
                            isFollowing = true;
                            followers++;
                          });
                          await FireStoreMethods()
                              .followUser(
                            FirebaseAuth.instance
                                .currentUser!.uid,
                            userData['uid'],
                          );
                          setState(() {
                            isActive= true;
                          });
                        }:null,
                        horizontal: (size.width/2)-50,
                        vertical: 9,
                      ):
                      FollowButton(
                        text: 'Edit Profile',
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        borderColor: Colors.grey,
                        function: () async {
                          if(userData.isNotEmpty)
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context)=> EditProfile( uid: FirebaseAuth.instance.currentUser!.uid))
                            );
                          else
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context)=> EditProfile( uid: FirebaseAuth.instance.currentUser!.uid))
                            );
                        },
                        horizontal: (size.width/2)-50,
                        vertical: 9,
                      )
                    ],
                  ),


                ],
              ),
            ),
            const Divider(),
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy("datePublished", descending: true)
                  .where('uid', isEqualTo: widget.uid)
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
                              height: (size.width/3)*(100/60)-5.6,
                              color:Palette.backgroundColor,
                              child: snap['imgsPath'][0]!= "no"?
                              Image(
                                image: NetworkImage(snap['imgsPath'][0]),
                                fit: BoxFit.cover,
                              ):Center(
                                child: Container(
                                  color: Palette.buttonColor,
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 3),
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
                          onTap:(){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:userData.isNotEmpty?
                                    (context) => UserPost(theUserData: userData,uid: snap['uid'].toString(),index: index):
                                    (context) => UserPost(theUserData: null,uid: snap['uid'].toString(),index: index)
                                ,
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
                              onTap: (){
                                onMore(snap["postId"].toString(), snap['uid'].toString(), snap["datePublished"].toDate());
                              },
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(20,4,0,20),
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
                              onTap:(){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:userData.isNotEmpty?
                                        (context) => UserPost(theUserData: userData,uid: snap['uid'].toString(),index: index):
                                        (context) => UserPost(theUserData: null,uid: snap['uid'].toString(),index: index),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal:6, vertical: 7 ),
                                child:snap['imgsPath'][0]!= "no"?
                                Text(
                                    snap['title'],
                                  style: TextStyle(
                                      color: Palette.backgroundColor,
                                    fontWeight: FontWeight.bold
                                  ),
                                ):SizedBox(),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                );
              },
            )
          ],
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
                        setState(() {
                          postLen--;
                        });
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

// function to show following/followers/# of posts

Column buildStatColumn(int num, String label) {
  return Column(
    children: [
      Text(
        num.toString(),
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      Container(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      ),
    ],
  );

}