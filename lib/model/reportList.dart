import 'package:cloud_firestore/cloud_firestore.dart';

class ReportList {
  /*report info*/
  final String uid;
  final String listId;
  final String reportId;
  final String reason;
  final DateTime date;


  const ReportList(
      {
        /*report info*/
        required this.uid,
        required this.listId,
        required this.reportId,
        required this.reason,
        required this.date,
      });

  static ReportList fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ReportList(
      /*report info*/
        uid: snapshot["uid"],
        listId: snapshot["listId"],
        reportId: snapshot["reportId"],
        reason: snapshot["reason"],
        date: snapshot["date"]
    );
  }

  Map<String, dynamic> toJson() => {
    /*report info*/
    "uid": uid,
    "listId": listId,
    "reportId": reportId,
    "reason": reason,
    "date": date,
  };
}

