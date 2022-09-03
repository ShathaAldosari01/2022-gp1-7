import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp1_7_2022/screen/home/UserProfile/Profile_Page.dart';
import '../../../Widgets/follow_button.dart';
import '../../../config/palette.dart';
import '../../auth/signup/userInfo/photo/utils.dart';
import '../../services/firestore_methods.dart';

class Following extends StatefulWidget {
  final following ;
  final isFollowing;
  const Following({Key? key, required this.following, required this.isFollowing}) : super(key: key);

  @override
  _FollowingState createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  /*attribute*/
  var following =[];
  bool islouded = false;
  var usersData= [];
  var theUserData = {};
  List<bool> isFollow = [];
  List<bool> isActive = [];
  var uid = FirebaseAuth.instance.currentUser!.uid;


  @override
  void initState() {
    print("start");
    print(widget.following.toString());
    print(widget.isFollowing.toString());
    super.initState();
    print("step1");
    setState(() {
      following = widget.following;
    });
    getTheUser();

  }

  void getFollowing() async{
    print("step2");
    int index= 0;
    for(var user in following){
      usersData.add("");
      isFollow.add(false);
      isActive.add(true);
      var x= await getUser(user);
      print(x);
      print("in loop");
      setState(()  {
        print("step4");
        print(user);
         usersData[index] = x;
        isFollow[index] = x.isFollowing;
      });
      index++;
    }
    setState(() {
      islouded = true;
    });
  }

  getUser(uid) async{
    print("step3");
    var username ;
    try {
      if (uid != null) {
        print("in if");
        var userSnap = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get();
        bool isFollow = await isFollowing(userSnap.data()!["uid"].toString());
        print( userSnap.data()!["username"].toString());
        print(userSnap.data()!["photoPath"]!.toString());
        print(userSnap.data()!["uid"].toString());
        print(userSnap.data()!["name"].toString());
        print(isFollow);
        var info = await UserInfo(username: userSnap.data()!["username"].toString(), photoPath: userSnap.data()!["photoPath"].toString(), uid: userSnap.data()!["uid"].toString(), name: userSnap.data()!["name"].toString(), isFollowing: isFollow);
        print(info);
        return info;
        // return await info;

        // print(userSnap.data()!["username"].toString());
        // return userData;
      }
    }catch(e){
      showSnackBar(context, e.toString());
      print(e.toString());
    }
    return username;
  }

  getTheUser()async{
    try {
      if (uid != null) {
        var userSnap = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get();

        setState(() {
          theUserData = userSnap.data()!;
        });

        getFollowing();
      }
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        //appBar style
        elevation: 2,
        backgroundColor: Palette.backgroundColor,
        iconTheme: IconThemeData(
          color: Palette.textColor, //change your color here
        ),

        centerTitle: true,
        //username
        title: Text(
          widget.isFollowing?"Following": "Followers",
          style: TextStyle(
            color: Palette.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
        body: !islouded?
      const Center(
        child: CircularProgressIndicator(),
      ):following.isNotEmpty?
        ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for(var index =0; index< usersData.length; index++)
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Profile_page(uid: usersData[index].uid, ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                            decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(width: 1.0, color: Palette.grey),
                                ),
                            ),
                            child: Row(
                                children:[
                                  Container(
                                    padding:usersData[index].photoPath != "no"?EdgeInsets.symmetric(
                                        horizontal:10):EdgeInsets.fromLTRB(4, 0, 7,0),
                                    child: usersData[index].photoPath != "no"
                                        ? CircleAvatar(
                                        backgroundColor: Palette.grey,
                                        backgroundImage:
                                        NetworkImage(usersData[index].photoPath ),
                                        radius: 25)
                                    //user photo
                                        : CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 30,
                                      child: Icon(
                                        Icons.account_circle_sharp,
                                        color: Colors.grey,
                                        size: 60,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          usersData[index].username,
                                          style: TextStyle(
                                            color: Palette.textColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          usersData[index].name,
                                          style: TextStyle(
                                            color: Palette.darkGray,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: FirebaseAuth.instance.currentUser!.uid != usersData[index].uid ?
                                    isFollow[index]
                                        ? FollowButton(
                                      text: 'Unfollow',
                                      backgroundColor: Colors.white,
                                      textColor: Colors.black,
                                      borderColor: Colors.grey,
                                      function: isActive[index]?() async {
                                        setState(() {
                                          isActive[index] = false;
                                          isFollow[index] = !isFollow[index];
                                        });
                                        await FireStoreMethods()
                                            .followUser(
                                          FirebaseAuth.instance
                                              .currentUser!.uid,
                                          usersData[index].uid,
                                        );
                                        setState(() {
                                          isActive[index] = true;
                                        });
                                        print(usersData[index].uid);
                                        print("unfollow");
                                      }:null,
                                      horizontal: 12,
                                      vertical: 7,
                                    )
                                        : FollowButton(
                                      text: 'Follow',
                                      backgroundColor: Palette.link,
                                      textColor: Palette.backgroundColor,
                                      borderColor: Palette.link,
                                      function: isActive[index]?() async {
                                        setState(() {
                                          isActive[index] = false;
                                          isFollow[index] = !isFollow[index];
                                        });
                                        await FireStoreMethods()
                                            .followUser(
                                          FirebaseAuth.instance
                                              .currentUser!.uid,
                                          usersData[index].uid,
                                        );
                                        setState(() {
                                          isActive[index] = true;
                                        });
                                        print(usersData[index].uid);
                                        print("follow");
                                      }:null,
                                      horizontal: 20,
                                      vertical: 7,
                                    ): SizedBox(),
                                  )
                                ]
                            )
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ):Center(child: Text(
          widget.isFollowing?"No following yet!": "No followers yet!",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500
          ),
        )),
    );
  }

  isFollowing(uid) {
    return theUserData['following'].contains(uid);
  }


}

class UserInfo {
  final String photoPath;
  final String username;
  final String name;
  final String uid;
  final bool isFollowing;

  const UserInfo({required this.username, required this.uid,required this.photoPath, required this.name, required this.isFollowing});

  @override
  String toString() {
    // TODO: implement toString
    return "photoPath: "+ photoPath +", username: "+ username +", name: "+ name+", uid: "+ uid+", isFollowing: "+ isFollowing.toString();
  }
}
