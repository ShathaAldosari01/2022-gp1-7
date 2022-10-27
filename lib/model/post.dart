import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  /*user info*/
  final String uid;


  /*place type*/
  final String country;
  final String city;
  final List<String> categories;
  final String type;
  final String locationId;

  /*place info*/
  final String postId;
  final String name;
  final String address;
  final double rating;

  /*visibility*/
  final String visibility;

  /*date*/
  final DateTime datePublished;
  final DateTime dateVisit;

  /*content*/
  final String title;
  final List<String> bodies;
  final List<String> imgsPath;
  final List<bool> isCoverPage;
  final int counter;

  /*likes*/
  final likes;
  final listIds;

  /*comment length*/
  final int numOfComments;

  final List<dynamic> reports;

  const Post(
      {
        /*user info*/
        required this.uid,


        /*place type*/
        required this.country,
        required this.city,
        required this.categories,
        required this.type,
        required this.locationId,

        /*place info*/
        required this.postId,
        required this.name,
        required this.address,
        required this.rating,

        /*visibility*/
        required this.visibility,

        /*date*/
        required this.datePublished,
        required this.dateVisit,

        /*content*/
        required this.title,
        required this.bodies,
        required this.imgsPath,
        required this.isCoverPage,
        required this.counter,

        /*likes*/
        required this.likes,
        required this.listIds,

        /*comment length*/
        required this.numOfComments,

        required this.reports,
      });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      /*user info*/
      uid: snapshot["uid"],


      /*place type*/
      country: snapshot["country"],
      city: snapshot["city"],
      categories: snapshot["categories"],
      type: snapshot["type"],
      locationId: snapshot["locationId"],

      /*place info*/
      postId: snapshot["postId"],
      name: snapshot["name"],
      address: snapshot["address"],
      rating: snapshot["rating"],

      /*visibility*/
      visibility: snapshot["visibility"],

      /*date*/
      datePublished: snapshot["datePublished"],
      dateVisit: snapshot["dateVisit"],

      /*content*/
      title: snapshot["title"],
      bodies: snapshot["bodies"],
      imgsPath: snapshot["imgsPath"],
      isCoverPage: snapshot["isCoverPage"],
      counter: snapshot['counter'],

      /*likes*/
      likes: snapshot["likes"],
      listIds: snapshot["listIds"],

      /*comment length*/
      numOfComments: snapshot['numOfComments'],

      reports:snapshot["reports"],

    );
  }

  Map<String, dynamic> toJson() => {
    /*user info*/
    "uid": uid,


    /*place type*/
    "country": country,
    "city": city,
    "categories": categories,
    "type": type,
    "locationId": locationId,

    /*place info*/
    "postId": postId,
    "name": name,
    "address": address,
    "rating": rating,

    /*visibility*/
    "visibility": visibility,

    /*date*/
    "datePublished": datePublished,
    "dateVisit": dateVisit,

    /*content*/
    "title": title,
    "bodies": bodies,
    "imgsPath": imgsPath,
    "isCoverPage": isCoverPage,
    "counter": counter,

    /*likes*/
    "likes": likes,
    "listIds": listIds,

    /*comment length*/
    "numOfComments": numOfComments,

    "reports":reports,
  };
}

