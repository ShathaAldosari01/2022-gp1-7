import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gp1_7_2022/config/palette.dart';

import '../UserProfile/Profile_Page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController(text: "");
  bool isShowUsers = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        title: Form(
          child: TextFormField(
            controller: searchController,
            decoration:
            const InputDecoration(labelText: 'Search for a user...'),
            onFieldSubmitted: (String _) {
              setState(() {
                isShowUsers = true;
              });
              print(_);
            },
          ),
        ),
      ),
      body: isShowUsers
          ? FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .where(
          'username',
          isGreaterThanOrEqualTo: searchController.text,
        )
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return (snapshot.data! as dynamic).docs ==null ?
          const Center(
            child: CircularProgressIndicator(),
          ):
          ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Profile_page(
                      uid: (snapshot.data! as dynamic).docs[index]['uid'], userData: null,
                    ),
                  ),
                ),
                child: (snapshot.data! as dynamic).docs[index]['username'].toString().isNotEmpty?
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      (snapshot.data! as dynamic).docs[index]['photoPath'],
                    ),
                    radius: 16,
                  ),
                  title: Text(
                    (snapshot.data! as dynamic).docs[index]['username'],
                  ),
                ):SizedBox(),
              );
            },
          );
        },
      )
          : FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('datePublished')
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Text("hi");

          // return StaggeredGridView.countBuilder(
          //   crossAxisCount: 3,
          //   itemCount: (snapshot.data! as dynamic).docs.length,
          //   itemBuilder: (context, index) => Image.network(
          //     (snapshot.data! as dynamic).docs[index]['postUrl'],
          //     fit: BoxFit.cover,
          //   ),
          //   staggeredTileBuilder: (index) => MediaQuery.of(context)
          //       .size
          //       .width >
          //       webScreenSize
          //       ? StaggeredTile.count(
          //       (index % 7 == 0) ? 1 : 1, (index % 7 == 0) ? 1 : 1)
          //       : StaggeredTile.count(
          //       (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
          //   mainAxisSpacing: 8.0,
          //   crossAxisSpacing: 8.0,
          // );
        },
      ),
    );
  }
}