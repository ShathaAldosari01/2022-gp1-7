import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String name;
  final String uid;
  final String photoPath;
  final String username;
  final String bio;
  final DateTime birthday;

  final int married;
  final int children;
  final int gender;

  final int middle;
  final int asian;
  final int european;
  final int american;
  final int african;

  final int restaurants;
  final int museums;
  final int shopping;
  final int parks;
  final int sports;

  final List followers;
  final List following;

  final List tags;


  const User(
      {required this.username,
        required this.uid,
        required this.name,
        required this.photoPath,
        required this.email,
        required this.bio,
        required this.birthday,

        required this.married,
        required this.children,
        required this.gender,

        required this.middle,
        required this.asian,
        required this.european,
        required this.american,
        required this.african,

        required this.restaurants,
        required this.museums,
        required this.shopping,
        required this.parks,
        required this.sports,

        required this.followers,
        required this.following,

        required this.tags,
      });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      uid: snapshot["uid"],
      name: snapshot["name"],
      email: snapshot["email"],
      photoPath: snapshot["photoPath"],
      bio: snapshot["bio"],
      birthday: snapshot["birthday"],

      married: snapshot["questions.married"],
      children: snapshot["questions.children"],
      gender: snapshot["questions.gender"],

      middle:snapshot["questions.countries.Middle eastern"],
      asian:snapshot["questions.countries.Asian"],
      european:snapshot["questions.countries.European"],
      american:snapshot["questions.countries.American"],
      african:snapshot["questions.countries.African"],

      restaurants:snapshot["questions.places.Restaurants and cafes"],
      museums:snapshot["questions.places.Museums"],
      shopping:snapshot["questions.places.Shopping malls"],
      parks:snapshot["questions.places.Parks"],
      sports:snapshot["questions.places.Sports attractions"],

      followers: snapshot["followers"],
      following: snapshot["following"],
      tags: snapshot["tags"],
    );
  }

  Map<String, dynamic> toJson() => {
    "username": username,
    "uid": uid,
    "name": name,
    "email": email,
    "photoPath": photoPath,
    "bio": bio,
    "followers": followers,
    "following": following,
    "tags": tags,
    "birthday": birthday,

    'questions': {
      'married': married,
      'children': children,
      'gender': gender, // 0:F, 1:M, 2:Other, -1: unknown
      'countries': {
        "Middle eastern": middle,
        "Asian": asian,
        "European": european,
        "American": american,
        "African": african,
      },
      'places': {
        "Restaurants and cafes": restaurants,
        "Museums": museums,
        "Shopping malls": shopping,
        "Parks": parks,
        "Sports attractions": sports,
      },
    },
  };
}