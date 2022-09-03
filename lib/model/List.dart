import 'package:cloud_firestore/cloud_firestore.dart';
//NOTE: i didnt add post ID in code because this will be done after the list is created and when add post to list is done

class Lists {
  /*user info*/
  final String uid;

  /*List info*/
  final String Cover;
  final String Description;
  final String ListID;
  final String Title;
  final bool Access;
  final List<String> Tags;
  final List<String> postIds;
  final List <String> users;


  const Lists(
      {
        /*user info*/
        required this.uid,

        /*List info*/
        required this.Cover,
        required this.Description,
        required this.ListID,
        required this.Title,
        required this.Access,
        required this.Tags,
        required this.postIds,
        required this.users,


      });

  static Lists fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Lists(
      /*user info*/
      uid: snapshot["uid"],


      /*List info*/
      Cover: snapshot["Cover"],
      Description: snapshot["Description"],
      ListID: snapshot["ListID"],
      Title: snapshot["Title"],
      Access: snapshot["Access"],
      Tags: snapshot["Tags"],
      postIds: snapshot["postIds"],
      users: snapshot["users"],




    );
  }

  Map<String, dynamic> toJson() => {
    /*user info*/
    "uid": uid,


    /*List info*/
    "Cover": Cover,
    "Description": Description,
    "ListID": ListID,
    "Title": Title,
    "Access": Access,
    "Tags": Tags,
    "postIds": postIds,
    "users": users,


  };
}