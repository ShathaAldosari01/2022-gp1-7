import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gp1_7_2022/model/List.dart';
import '../../model/post.dart';
import '../../model/reportComment.dart';
import '../../model/reportList.dart';
import '../../model/reportPost.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(
      /*user info*/
      String uid,

      /*place type*/
      String country,
      String city,
      List<String> categories,
      String type,
      String locationId,

      /*place info*/
      String postId,
      String name,
      String address,
      double rating,

      /*visibility*/
      String visibility,

      /*date*/
      DateTime dateVisit,

      /*content*/
      String title,
      List<String> bodies,
      List<String> imgsPath,
      List<bool> isCoverPage,
      int counter,
      ) async {
    String res = "some error occurred";
    try {
      Post post = Post(
        /*user info*/
        uid: uid,

        /*place type*/
        country: country,
        city: city,
        categories: categories,
        type: type,
        locationId: locationId,

        /*place info*/
        postId: postId,
        name: name,
        address: address,
        rating: rating,

        /*visibility*/
        visibility: visibility,

        /*date*/
        datePublished: DateTime.now(),
        dateVisit: dateVisit,

        /*content*/
        title: title,
        bodies: bodies,
        imgsPath: imgsPath,
        isCoverPage: isCoverPage,
        counter: counter,

        /*likes and list*/
        likes: [],
        listIds: [],

        /*comment length*/
        numOfComments: 0,
      );

      _firestore.collection("posts").doc(postId).set(
        post.toJson(),
      );
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Delete Post
  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      //todo: delete post form lists
      await _firestore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //delete comment
  Future<String> deleteComment(String commentId, String postId) async {
    String res = "Some error occurred";
    int numOfComments = 0;
    try {
      // delete comment
      var userSnap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .get();
      var postData = userSnap.data()!;
      numOfComments = postData['numOfComments'];

      await _firestore.collection('posts').doc(postId).update({
        'numOfComments': numOfComments-1
      });
      await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }







  // Delete List
  Future<String> deleteList(String ListID) async {
    String res = "Some error occurred";
    try {
      //todo: delete list form posts and users
      await _firestore.collection('Lists').doc(ListID).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
      await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //upload List
  Future<String> uploadList(
      /*user info*/
      String uid,

      /*List info*/
      final String Cover,
      final String Description,
      final String ListID,
      final String Title,
      final bool Access,
      final List<String> Tags,
      final List<String> postIds,
      final List<String> users,
      ) async {
    String res = "some error occurred";
    try {
      Lists List = Lists(
        /*user info*/
        uid: uid,

        /*List info*/
        Cover: Cover,
        Description: Description,
        ListID: ListID,
        Title: Title,
        Access: Access,
        Tags: Tags,
        postIds: postIds,
        users: users,
      );

      _firestore.collection("Lists").doc(ListID).set(
        List.toJson(),
      );
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //upload post report
  Future<String> createReportPost(
      /*report info*/
      String uid,
      String postId,
      String reportId,
      String reason,

      ) async {
    String res = "some error occurred";
    try {
      ReportPost postReport = ReportPost(
        /*user info*/
        uid: uid,
        postId: postId,
        reportId: reportId,
        reason: reason,
      );

      _firestore.collection("reportPost").doc(reportId).set(
        postReport.toJson(),
      );
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //upload list report
  Future<String> createReportList(
      /*report info*/
      String uid,
      String listId,
      String reportId,
      String reason,

      ) async {
    String res = "some error occurred";
    try {
      ReportList listReport = ReportList(
        /*user info*/
        uid: uid,
        listId: listId,
        reportId: reportId,
        reason: reason,
      );

      _firestore.collection("reportList").doc(reportId).set(
        listReport.toJson(),
      );
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //upload comment report
  Future<String> createReportComment(
      /*report info*/
      String uid,
      String postId,
      String commentId,
      String reportId,
      String reason,

      ) async {
    String res = "some error occurred";
    try {
      ReportComment commentReport = ReportComment(
        /*user info*/
        uid: uid,
        postId: postId,
        commentId: commentId,
        reportId: reportId,
        reason: reason,
      );

      _firestore.collection("reportComment").doc(reportId).set(
        commentReport.toJson(),
      );
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Accept Report Post
  Future<String> AcceptPostReport(String postId, String reportId) async {
    String res = "Some error occurred";
    try {
      //todo: delete post form lists
      await _firestore.collection('posts').doc(postId).delete();
      await _firestore.collection('reportPost').doc(reportId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Accept Report list
  Future<String> AcceptListReport(String listId, String reportId) async {
    String res = "Some error occurred";
    try {
      //todo: delete list form post and users
      await _firestore.collection('Lists').doc(listId).delete();
      await _firestore.collection('reportList').doc(reportId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Accept Report comment
  Future<String> AcceptCommentReport(String postId, String reportId) async {
    String res = "Some error occurred";
    try {
      //todo: delete comment
      await _firestore.collection('reportComment').doc(reportId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // decline Report Post
  Future<String> DeclinePostReport(String reportId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('reportPost').doc(reportId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // decline Report list
  Future<String> DeclineListReport(String reportId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('reportList').doc(reportId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // decline Report comment
  Future<String> DeclineCommentReport( String reportId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('reportComment').doc(reportId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }



}
