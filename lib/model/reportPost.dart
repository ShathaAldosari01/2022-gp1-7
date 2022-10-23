import 'package:cloud_firestore/cloud_firestore.dart';

class ReportPost {
  /*report info*/
  final String uid;
  final String postId;
  final String reportId;
  final String reason;


  const ReportPost(
      {
        /*report info*/
        required this.uid,
        required this.postId,
        required this.reportId,
        required this.reason,
      });

  static ReportPost fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ReportPost(
      /*report info*/
      uid: snapshot["uid"],
      postId: snapshot["postId"],
      reportId: snapshot["reportId"],
      reason: snapshot["reason"],
    );
  }

  Map<String, dynamic> toJson() => {
    /*report info*/
    "uid": uid,
    "postId": postId,
    "reportId": reportId,
    "reason": reason,

  };
}