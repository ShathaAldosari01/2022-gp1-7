import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../../model/comment.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'comment_screen.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;
  var  postId="";
  var firebaseStorage = FirebaseStorage.instance;
  var firestore = FirebaseFirestore.instance;
  var uid = FirebaseAuth.instance.currentUser!.uid;
  updatePostId(String id) {
    postId = id;
    getComment();
  }

  getComment() async {
    _comments.bindStream(
      firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .snapshots()
          .map(
            (QuerySnapshot query) {
          List<Comment> retValue = [];
          for (var element in query.docs) {
            retValue.add(Comment.fromSnap(element));

          }
          return retValue;
        },
      ),
    );
  }

  postComment(String commentText) async {
    //update counter
    int numOfComments = 0;
    var userSnap = await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .get();
    var postData = userSnap.data()!;
    numOfComments = postData['numOfComments'];

    await firestore.collection('posts').doc(postId).update({
      'numOfComments': numOfComments+1
    });
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await firestore
            .collection('users')
            .doc(uid)
            .get();
        var allDocs = await firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .get();

        var commentID = const Uuid().v1();

        Comment comment = Comment(
          username: (userDoc.data()! as dynamic)['username'],
          comment: commentText.trim(),
          datePublished: DateTime.now(),
          profilePhoto: (userDoc.data()! as dynamic)['photoPath'],
          uid: uid,
          cid: commentID,
        );
        await firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentID)
            .set(
          comment.toJson(),
        );
        DocumentSnapshot doc =
        await firestore.collection('posts').doc(postId).get();
        await firestore.collection('posts').doc(postId).update({
          'commentCount': (doc.data()! as dynamic)['commentCount'] + 1,
        }

        );
      }
    } catch (e) {
      Get.snackbar(
        'Error While Commenting',
        e.toString(),
      );
    }
  }


}



