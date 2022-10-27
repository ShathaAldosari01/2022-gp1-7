import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gp1_7_2022/config/palette.dart';
import 'package:gp1_7_2022/config/palette.dart';
import '../UserProfile/Profile_Page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController =
  TextEditingController(text: "");

  bool isShowUsers = true;

  /*icons color*/
  Color UsersColor = Color(0xff1bd3db);
  Color PostsColor = Palette.darkGray;
  Color ListsColor = Palette.darkGray;
  /*visibility*/
  bool SUsers = true;
  bool SPosts = false;
  bool SLists = false;

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
            decoration: const InputDecoration(labelText: 'Search for ...'),
            onFieldSubmitted: (String _) {
              setState(() {
                isShowUsers = true;
              });
              print(_);
            },
          ),
        ),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //for search users
              Container(
                padding: const EdgeInsets.all(0.0),
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        UsersColor = Color(0xff1bd3db);
                        PostsColor = Palette.darkGray;
                        ListsColor = Palette.darkGray;

                        SUsers = true;
                        SPosts = false;
                        SLists = false;

                        isShowUsers = true;
                      });
                    },
                    icon: Icon(
                      Icons.account_circle,
                      color: UsersColor,
                      size: 30,
                    )),
              ),

              Container(
                  height: 25,
                  child: VerticalDivider(
                    color: Palette.darkGray,
                  )),

              //for search posts
              Container(
                padding: const EdgeInsets.all(0.0),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      UsersColor = Palette.darkGray;
                      PostsColor = Color(0xff1bd3db);
                      ListsColor = Palette.darkGray;

                      SUsers = false;
                      SPosts = true;
                      SLists = false;

                      isShowUsers = false;
                    });
                  },
                  icon: Icon(
                    Icons.amp_stories_sharp,
                    color: PostsColor,
                    size: 30,
                  ),
                ),
              ),

              Container(
                  height: 25,
                  child: VerticalDivider(
                    color: Palette.darkGray,
                  )),

              //for search lists
              Container(
                padding: const EdgeInsets.all(0.0),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      UsersColor = Palette.darkGray;
                      PostsColor = Palette.darkGray;
                      ListsColor = Color(0xff1bd3db);

                      SUsers = false;
                      SPosts = false;
                      SLists = true;

                      isShowUsers = false;
                    });
                  },
                  icon: Icon(
                    Icons.list,
                    color: ListsColor,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            color: Palette.darkGray,
          ),
          //vis for search users
          Visibility(
            visible: SUsers,
            child: Column(
              children: [
                isShowUsers
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
                    return (snapshot.data! as dynamic).docs == null
                        ? const Center(
                      child: CircularProgressIndicator(),
                    )
                        : ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount:
                      (snapshot.data! as dynamic).docs.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Profile_page(
                                uid: (snapshot.data! as dynamic)
                                    .docs[index]['uid'],
                              ),
                            ),
                          ),
                          child: (snapshot.data! as dynamic)
                              .docs[index]['username']
                              .toString()
                              .isNotEmpty
                              ? ListTile(
                            leading: (snapshot.data!
                            as dynamic)
                                .docs[index]
                            ['photoPath'] !=
                                "no"
                                ? CircleAvatar(
                              backgroundImage:
                              NetworkImage(
                                (snapshot.data!
                                as dynamic)
                                    .docs[index]
                                ['photoPath'],
                              ),
                              radius: 16,
                            )
                                : CircleAvatar(
                              backgroundColor: Colors
                                  .white
                                  .withOpacity(0.8),
                              radius: 16,
                              child: Icon(
                                Icons
                                    .account_circle_sharp,
                                color: Colors.grey,
                                size: 35,
                              ),
                            ),
                            title: Text(
                              (snapshot.data! as dynamic)
                                  .docs[index]['username'],
                            ),
                          )
                              : SizedBox(),
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
                    }),
              ],
            ),
          ),

          //vis for search posts
          Visibility(
            visible: SPosts,
            child: Column(),
          ),

          //vis for search lists
          Visibility(
            visible: SLists,
            child: Column(),
          )
        ],
      ),
    );
  }
}

