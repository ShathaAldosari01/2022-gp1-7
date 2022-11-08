import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:uuid/uuid.dart';
import '../../auth/signup/userInfo/photo/utils.dart';
import '../../services/firestore_methods.dart';
import '../UserProfile/Profile_Page.dart';
import 'comment_controller.dart';
import 'package:timeago/timeago.dart' as tago;
import '../../../config/palette.dart';

class CommentScreen extends StatefulWidget {
  final  postId;
  final  postUid;//the user id of the one how created the post
  CommentScreen({Key? key, required this.postId, required this.postUid}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  bool isLouded= false;
  //comment controller
  final TextEditingController _commentController = TextEditingController();
  CommentController commentController = Get.put(CommentController());

  @override
  void initState() {
    commentController.updatePostId(widget.postId);
    isLouded = true;
    reportController = TextEditingController();
    super.initState();
  }

  /*reportController*/
  late TextEditingController reportController;

  @override
  void dispose() {
    reportController.dispose();

    super.dispose();
  }


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
            /* make own arrow*/
            IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: Palette.textColor),
                onPressed: () {
                  Navigator.pop(context);
                }),

            /*title (comment)*/
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: Text(
                "Comments",
                style: TextStyle(
                  color: Palette.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),

            /*to make title at the center*/
            Padding(
              padding: const EdgeInsets.all(15.0),
              child:
              Icon(Icons.arrow_back, color: Palette.backgroundColor),
            ),

          ],
        ),
      ),

      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height-100,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                    return ListView.builder(
                        itemCount: commentController.comments.length,
                        itemBuilder: (context, index) {
                          final comment = commentController.comments[index];
                          return ListTile(
                            /*user photo*/
                            leading:
                            // comment.profilePhoto !='no' ?
                            // Container(
                            //   child: CircleAvatar(
                            //     backgroundColor: Colors.black,
                            //     radius: 25,
                            //     backgroundImage: NetworkImage(comment.profilePhoto),
                            //   ),
                            // )
                            //     :
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
                                            uid: comment.uid,
                                          ),
                                        ),
                                      ); },
                                      child: Text("${comment.username}  ",
                                        style:  TextStyle(fontSize: 16,
                                            color: widget.postUid ==comment.uid? Palette.link: Palette.textColor,
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
                                          width: size.width- 122,
                                          child:
                                          Text(comment.comment ,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Palette.textColor,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                        /*end of comment content*/

                                        /*more*/
                                        Container(
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            onPressed: (){
                                              var uid = FirebaseAuth.instance.currentUser!.uid;
                                              onMore(comment.cid, comment.uid, uid, widget.postUid);
                                            },
                                            icon: Icon(
                                              Icons.more_vert,
                                            ),
                                          ),
                                        )
                                        /*end of more*/
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
                                  tago.format(comment.datePublished.toDate()),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Palette.darkGray,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                              ],
                            ),
                            /*end of date of comment */

                          );
                        });
                } ),
              ),
              const Divider(),
              FirebaseAuth.instance.currentUser!.uid=="miostwrsWghrmT0qkc4Q0uhpA842"? SizedBox():
              ListTile(
                title: TextFormField(
                  controller: _commentController ,
                  style:  TextStyle(fontSize: 16, color: Palette.textColor, ),
                  decoration: InputDecoration(
                    labelText: 'Comment',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Palette.link,
                      fontWeight: FontWeight.bold,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Palette.link,),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Palette.link,),
                    ),
                  ),
                  //for multi line
                  minLines: 1,
                  maxLines: 5,
                  // allow user to enter 10 line in text field
                  keyboardType: TextInputType.multiline,
                ),
                trailing: TextButton(
                  onPressed: () {
                    commentController.postComment(_commentController.text);
                    _commentController.clear();
                  },
                  child: Text(
                    'Send',
                    style: TextStyle(
                      fontSize: 16,
                      color: Palette.link,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  /*function */
  void onMore(String commentId, commentUid, uid, postUid) {
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        color: Color(0xFF737373),
        height: 180/3,
        child: Container(
          child: onMorePressed(widget.postId, commentId, commentUid, uid, postUid),
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

  /*on more pressed*/
  Column onMorePressed(String postId, commentId, commentUid, uid, postUid) {
    return Column(
      children:  [

        ListTile(
          leading: (uid == commentUid || uid == postUid ||uid =="miostwrsWghrmT0qkc4Q0uhpA842")?
          Icon(Icons.delete):
          Icon(Icons.flag),
          title: (uid == commentUid || uid == postUid || uid =="miostwrsWghrmT0qkc4Q0uhpA842")?
          Text("Delete comment"):
          Text("Report comment"),
          onTap: () {
            Navigator.pop(context);
            if(uid == commentUid || uid == postUid || uid =="miostwrsWghrmT0qkc4Q0uhpA842"){
              Alert(
                  context: context,
                  title: uid == commentUid ?"Are you sure you want to delete your comment?":"Are you sure you want to delete this comment?",
                  desc:  uid == commentUid ? "Your comment will be permanently deleted. You can't undo.": "This comment will be permanently deleted. You can't undo.",
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
                        deleteComment(commentId, postId);
                        setState(() {});
                      },
                    )
                  ]).show();
            }else{
              openDialog(postId, commentId,uid);
            }

          },
        )
      ],
    );
  }

  /*report comment*/
  Future openDialog(String postId, commentId, uid) {
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Report Comment"),
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
                  reportComment(postId, commentId, reportController.text);
                  reportController.clear();
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
    );
  }

  /*report comment*/
  void reportComment(String postId, commentId, reason) async {
    print("we're in!");
    print(postId);
    print(commentId);
    print(reason);
    var uid = FirebaseAuth.instance.currentUser!.uid;
    String reportId = const Uuid().v1();
    try{
      String res = await FireStoreMethods().createReportComment(uid, postId, commentId, reportId,reason,DateTime.now() );
      if(res== "success"){

        showSnackBar(context, "Report has been send successfully!");
      }else{
        showSnackBar(context, res);
      }
    }catch(e){
      showSnackBar(context, e.toString());
    }
  }

  //delete comment
  deleteComment(String commentId,String postId) async {
    try {
      await FireStoreMethods().deleteComment(commentId,postId);
      showSnackBar(context, "Comment was deleted successfully!");
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

}

