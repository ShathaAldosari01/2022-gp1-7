import 'package:cloud_firestore/cloud_firestore.dart';

class ReportComment {
  /*report info*/
  final String uid;
  final String postId;
  final String commentId;
  final String reportId;
  final String reason;
  final DateTime date;


  const ReportComment(
      {
        /*report info*/
        required this.uid,
        required this.postId,
        required this.commentId,
        required this.reportId,
        required this.reason,
        required this.date,
      });

  static ReportComment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ReportComment(
      /*report info*/
      uid: snapshot["uid"],
      postId: snapshot["postId"],
      commentId: snapshot["commentId"],
      reportId: snapshot["reportId"],
      reason: snapshot["reason"],
      date: snapshot["date"],
    );
  }

  Map<String, dynamic> toJson() => {
    /*report info*/
    "uid": uid,
    "postId": postId,
    "commentId": commentId,
    "reportId": reportId,
    "reason": reason,
    "date": date,
  };
}

