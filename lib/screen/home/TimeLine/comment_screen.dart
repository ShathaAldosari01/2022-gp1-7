import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../UserProfile/Profile_Page.dart';
import 'comment_controller.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatefulWidget {
  final  postId;
   CommentScreen({Key? key, required this.postId}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  //comment controller
  final TextEditingController _commentController = TextEditingController();

  CommentController commentController = Get.put(CommentController());

  @override

  void initState() {
    commentController.updatePostId(widget.postId);
    super.initState();
  }


  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                  child: Obx(() {
                      return ListView.builder(
                          itemCount: commentController.comments.length,
                          itemBuilder: (context, index) {
                            final comment = commentController.comments[index];
                            return ListTile(
                              leading: comment.profilePhoto !='no' ? CircleAvatar(
                                backgroundColor: Colors.black,
                                backgroundImage: NetworkImage(comment.profilePhoto),
                              ):
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 25,
                                child: Icon(
                                  Icons.account_circle_sharp,
                                  color: Colors.grey,
                                  size: 50,
                                ),
                              )
                              ,title: Row(
                                children: [
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
                                    style:  TextStyle(fontSize: 18,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Text(comment.comment ,
                                    style: const TextStyle(fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),)
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Text(tago.format(comment.datePublished.toDate()),
                                    style: const TextStyle(fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),),
                                ],
                              ),

                              //you can make report comment here

                            );
                          });
                    } ),
              ),
              const Divider(),
              ListTile(
                title: TextFormField(
                  controller: _commentController ,
                  style:  TextStyle(fontSize: 16, color: Colors.black, ),
                  decoration: InputDecoration(
                    labelText: 'comment',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.w700,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,),
                    ),
                  ),
                  //for multi line
                  minLines: 1,
                  maxLines: 5,
                  // allow user to enter 10 line in textfield
                  keyboardType: TextInputType.multiline,
                ),
                trailing: TextButton(
                  onPressed: () {
                    commentController.postComment(_commentController.text);
                    _commentController.clear();
                  },
                  child: Text('send', style: TextStyle(fontSize: 16, color: Colors.blue),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
