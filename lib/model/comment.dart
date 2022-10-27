import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String username;
  String comment;
  final datePublished;
  String profilePhoto;
  String uid;
  String cid;
  List<dynamic> reports;

  Comment({
    required this.username,
    required this.comment,
    required this.datePublished,
    required this.profilePhoto,
    required this.uid,
    required this.cid,
    required this.reports
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'comment': comment,
    'datePublished': datePublished,
    'profilePhoto': profilePhoto,
    'uid': uid,
    'cid': cid,
    'reports': reports,
  };

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    print(snapshot['username']);
    print(snap['username']);
    print('in here ghalo');
    print(snapshot['comment']);
    print(snap['comment']);
    return Comment(
      username: snapshot['username'],
      comment: snapshot['comment'],
      datePublished: snapshot['datePublished'],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
      cid: snapshot['cid'],
      reports: snapshot['reports'],
    );

  }
}

