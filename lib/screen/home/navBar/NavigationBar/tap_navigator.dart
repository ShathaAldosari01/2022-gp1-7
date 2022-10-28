import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../TimeLine/home_page.dart';
import '../../UserProfile/Profile_Page.dart';
import '../../addPost/AddPostPage.dart';
import '../../navBar/search_page.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {

    Widget child ;
    if(tabItem == "Home")
      child = HomePage();
    else if(tabItem == "Search")
      child = SearchPage();
    else if(tabItem == "Add")
      child = AddPostPage();
    else if(tabItem == "Profile")
      child = Profile_page(uid: FirebaseAuth.instance.currentUser!.uid, );

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) {
              if(tabItem == "Home")
                return HomePage();
              else if(tabItem == "Search")
                return SearchPage();
              else if(tabItem == "Add"){
                return AddPostPage();
              }
              else if(tabItem == "Profile")
                return Profile_page(uid: FirebaseAuth.instance.currentUser!.uid, );
              return HomePage();
            }

        );
      },
    );
  }
}