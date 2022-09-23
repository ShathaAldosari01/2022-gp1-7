import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'comment_controller.dart';
// import 'package:timeago/timeago.dart' as timeago;
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
    commentController.updatePostId(widget.postId);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                  child: StreamBuilder<Object>(
                    stream: null,
                    builder: (context, snapshot) {
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
                                  Text(comment.username,
                                    style: const TextStyle(fontSize: 20,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w700),),
                                  Text(comment.comment ,
                                    style: const TextStyle(fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),)
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Text('date',
                                    style: const TextStyle(fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),),
                                  const SizedBox(width: 10,),
                                  Text('likes',
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
                ),
                trailing: TextButton(
                  onPressed: () => commentController.postComment(_commentController.text),
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
