import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../../../../config/palette.dart';
import '../../Lists/listCountent.dart';

class lists extends StatefulWidget {
  @override
  State<lists> createState() => _listsState();
}

class _listsState extends State<lists> {
  //@
  /*list of list*/
  List<dynamic> listOfList =[""];

  /*userInfo*/
  var uid=FirebaseAuth.instance.currentUser!.uid;
  int age= 0;
  String socialState="";
  String haveChildren="";
  String gender="";
  String countries="";
  String places="";
  String tags="";

  //methodes
  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    print("hi 2");
    var uid=FirebaseAuth.instance.currentUser!.uid;
    try {
      if (uid != null) {
        print(uid);
        var userSnap = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get();

        var userData = userSnap.data()!;

        String country = "";
        if (userData["questions"]["countries"]["Middle eastern"]==1){
          //Middle-eastern, Asian, European, American, Afr...
          country+="Middle-eastern";
        }
        if (userData["questions"]["countries"]["Asian"]==1){
          //Middle-eastern, Asian, European, American, Afr...
          if(country=="")
            country+="Asian";
          else{
            country+=", Asian";
          }
        }
        print(userData["questions"]["countries"]["European"].toString());
        print("here");
        if (userData["questions"]["countries"]["European"]==1){
          //Middle-eastern, Asian, European, American, Afr...
          if(country=="")
            country+="European";
          else{
            country+=", European";
          }
        }


        if (userData["questions"]["countries"]["American"]==1){
          //Middle-eastern, Asian, European, American, Afr...
          if(country=="")
            country+="American";
          else{
            country+=", American";
          }
        }
        if (userData["questions"]["countries"]["African"]==1){
          //Middle-eastern, Asian, European, American, Afr...
          if(country=="")
            country+="African";
          else{
            country+=", African";
          }
        }

        //places
        String place ="";
        if (userData["questions"]["places"]["Restaurants and cafes"]==1){
          //Restaurants, malls, Parks, Sports
          place+="Restaurants";
        }

        if (userData["questions"]["places"]["Shopping malls"]==1){
          //Restaurants, malls, Parks, Sports
          if(place=="")
            place+="malls";
          else{
            place+=", malls";
          }
        }

        if (userData["questions"]["places"]["Parks"]==1){
          //Restaurants, malls, Parks, Sports
          if(place=="")
            place+="Parks";
          else{
            place+=", Parks";
          }
        }

        if (userData["questions"]["places"]["Museums"]==1){
          //Restaurants, malls, Parks, Sports
          if(place=="")
            place+="Museums";
          else{
            place+=", Museums";
          }
        }

        if (userData["questions"]["places"]["Sports attractions"]==1){
          //Restaurants, malls, Parks, Sports
          if(place=="")
            place+="Sports";
          else{
            place+=", Sports";
          }
        }

        print("hi 3");

        //calculate age
        DateTime birthday = DateTime.now();
        int now = birthday.year;
        int birth = userData["birthday"].toDate().year;
        int ageyear = now - birth;

        int nowMonth = birthday.month;
        int birthMonth = userData["birthday"].toDate().month;
        int ageMonth = nowMonth - birthMonth;

        int nowDay = birthday.day;
        int birthDay = userData["birthday"].toDate().day;
        int ageDay = nowDay - birthDay;

        if(ageDay <0)
          ageMonth--;

        if(ageMonth <0)
          ageyear--;

        String listOfTags = "";
        userData["tags"].forEach((tag){
          listOfTags+=tag+", ";
        });

        print("hi 4");

        setState(() {
          userData = userSnap.data()!;
          age = ageyear;
          socialState = userData["questions"]["married"]==1?"Married":"Single";
          haveChildren = userData["questions"]["children"]==1?"Children":"noKids";
          gender = userData["questions"]["gender"]==0?"Female":"Male";
          countries = country;
          places = place;
          tags = listOfTags;
        });

        print("hi 5");

        String title="";
        print("hi 6");
        // final url ='http://127.0.0.1:5000';
        final response = await http.post(Uri.parse('http://192.168.100.9:5000/title'),body: json.encode(
            {'userID': FirebaseAuth.instance.currentUser!.uid,"title":title,"places":places,"countries":countries,"gender":gender,"haveChildren":haveChildren,"socialState":socialState,"age":age,"tags":tags}));
        print("hi 7");
        var listOfLists = json.decode(response.body);
        print("hii");
        print(places);
        print(countries);
        print(gender);
        print(haveChildren);
        print(response.body);
        setState(() {
          listOfList = listOfLists;
        });
      }
    } catch (e) {
      print("woooooooooooooooooooooooooooooow");
      print(e.toString());
    }
  }

  Future<void> beforSearch() async {
    String title="";
    // final url ='http://127.0.0.1:5000';
    final response = await http.post(Uri.parse('http://192.168.100.9:5000/title'),body: json.encode(
        {'userID': FirebaseAuth.instance.currentUser!.uid,"title":title,"places":places,"countries":countries,"gender":gender,"haveChildren":haveChildren,"socialState":socialState,"age":age,"tags":tags}));
    var listOfLists = json.decode(response.body);
    print("hii");
    print(places);
    print(countries);
    print(gender);
    print(haveChildren);
    print(response.body);
    setState(() {
      listOfList = listOfLists;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Palette.backgroundColor,
        appBar: AppBar(
          backgroundColor: Palette.backgroundColor,
          foregroundColor: Palette.textColor,
          elevation: 0, //no shadow
          automaticallyImplyLeading: false, //no arrow
        ),
        body: ListView(
          children: [
            Column(
              children: [
                for ( var i = 0,j =listOfList.length-1; i < listOfList.length; i++,j--)
                  uid!= "JdU83XQh0OWe3UWqMNvnOP4mown1"?
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('Lists')
                            .where('ListID', isEqualTo: listOfList[i])
                            .where('Access', isEqualTo:true)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState== ConnectionState.waiting && i ==0) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Palette.link,
                              ),
                            );
                          }if (snapshot.connectionState== ConnectionState.waiting && i!=0) {
                            return const Center(
                              child: CircularProgressIndicator(
                                backgroundColor:Palette.lightgrey,
                                color: Palette.lightgrey,
                              ),
                            );
                          }
                          return GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: (snapshot.data! as dynamic).docs.length,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 0.5,
                              mainAxisSpacing: 12,
                              childAspectRatio: 2,
                            ),
                            itemBuilder: (context, index) {
                              DocumentSnapshot snap =
                              (snapshot.data! as dynamic).docs[index];

                              return Stack(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                            gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: [
                                                  Palette.buttonColor,
                                                  Palette.nameColor
                                                ])),

                                        height: size.height / 4.45,
                                        width: size.width - 20,
                                        child: snap['Cover'] != ""
                                            ? Container(
                                          child: ClipRRect(
                                            borderRadius:BorderRadius.circular(20) ,
                                            child: ColorFiltered(
                                              colorFilter:
                                              ColorFilter.mode(Colors.black.withOpacity(0.3),
                                                  BlendMode.darken),
                                              child: Image(
                                                image: NetworkImage(
                                                    snap['Cover']),
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                          ),
                                        )
                                            : Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                bottomRight: Radius.circular(20),
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                              ),
                                              gradient: LinearGradient(
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                  colors: [
                                                    Palette.buttonColor,
                                                    Palette.nameColor
                                                  ])),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 4),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 6,
                                                    vertical: 7),
                                                child: Text(
                                                  snap['Title'],
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Palette
                                                        .backgroundColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ListCountent(
                                              listId: snap["ListID"],
                                            )),
                                      );
                                    },
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ListCountent(
                                                      listId: snap["ListID"],
                                                    )),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 7),
                                          child: snap['Cover'] != ""
                                              ? Text(
                                            snap['Title'],
                                            style: TextStyle(
                                                color: Palette
                                                    .backgroundColor,
                                                fontWeight:
                                                FontWeight.bold),
                                          )
                                              : SizedBox(),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          );
                        }),
                  )
                      :Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('Lists')
                            .where('ListID', isEqualTo: listOfList[j])
                            .where('Access', isEqualTo:true)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState== ConnectionState.waiting && j ==0) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Palette.link,
                              ),
                            );
                          }if (snapshot.connectionState== ConnectionState.waiting && j!=0) {
                            return const Center(
                              child: CircularProgressIndicator(
                                backgroundColor:Palette.lightgrey,
                                color: Palette.lightgrey,
                              ),
                            );
                          }
                          return GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: (snapshot.data! as dynamic).docs.length,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 0.5,
                              mainAxisSpacing: 12,
                              childAspectRatio: 2,
                            ),
                            itemBuilder: (context, index) {
                              DocumentSnapshot snap =
                              (snapshot.data! as dynamic).docs[index];

                              return Stack(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                            gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: [
                                                  Palette.buttonColor,
                                                  Palette.nameColor
                                                ])),

                                        height: size.height / 4.45,
                                        width: size.width - 20,
                                        child: snap['Cover'] != ""
                                            ? Container(
                                          child: ClipRRect(
                                            borderRadius:BorderRadius.circular(20) ,
                                            child: ColorFiltered(
                                              colorFilter:
                                              ColorFilter.mode(Colors.black.withOpacity(0.3),
                                                  BlendMode.darken),
                                              child: Image(
                                                image: NetworkImage(
                                                    snap['Cover']),
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                          ),
                                        )
                                            : Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                bottomRight: Radius.circular(20),
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                              ),
                                              gradient: LinearGradient(
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                  colors: [
                                                    Palette.buttonColor,
                                                    Palette.nameColor
                                                  ])),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 4),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 6,
                                                    vertical: 7),
                                                child: Text(
                                                  snap['Title'],
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Palette
                                                        .backgroundColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ListCountent(
                                              listId: snap["ListID"],
                                            )),
                                      );
                                    },
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ListCountent(
                                                      listId: snap["ListID"],
                                                    )),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 7),
                                          child: snap['Cover'] != ""
                                              ? Text(
                                            snap['Title'],
                                            style: TextStyle(
                                                color: Palette
                                                    .backgroundColor,
                                                fontWeight:
                                                FontWeight.bold),
                                          )
                                              : SizedBox(),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          );
                        }),
                  )
              ],
            )
          ],
        )
    );
  }
}