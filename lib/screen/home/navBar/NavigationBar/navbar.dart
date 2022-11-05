import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp1_7_2022/config/palette.dart';

/*pages*/
import 'tap_navigator.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  /*attribute*/
  String _currentPage = "Home";
  List<String> pageKeys = ["Home", "Search", "Add", "List", "Profile"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Home": GlobalKey<NavigatorState>(),
    "Search": GlobalKey<NavigatorState>(),
    "Add": GlobalKey<NavigatorState>(),
    "Profile": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _selectTab(String tabItem, int index) {
    if(tabItem == _currentPage ){
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        final isFirstRouteInCurrentTab =
        !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "Home") {
            _selectTab("Home", 1);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            _buildOffstageNavigator("Home"),
            _buildOffstageNavigator("Search"),
            _buildOffstageNavigator("Add"),
            _buildOffstageNavigator("List"),
            _buildOffstageNavigator("Profile"),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Palette.darkButtonColor,
          backgroundColor: Palette.textColor,
          unselectedItemColor:  Palette.lightgrey,
          onTap: (int index) { _selectTab(pageKeys[index], index); }, // new
          currentIndex: _selectedIndex, // new
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              label: ""
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.search),
                label: ""
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.add),
                label: ""
            ),
            BottomNavigationBarItem(
                icon: new Icon(Icons.explore_outlined),
                label: ""
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.person),
                label: ""
            ),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]??GlobalKey<NavigatorState>(),
        tabItem: tabItem,
      ),
    );
  }
}
