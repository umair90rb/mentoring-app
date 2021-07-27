import 'package:brain_store/BottomNavigationbar/Botton_nav_widget/Home_Screen.dart';
import 'package:brain_store/BottomNavigationbar/Botton_nav_widget/postcast.dart';
import 'package:brain_store/localization/language_constants.dart';
import 'package:flutter/material.dart';

import 'Botton_nav_widget/profile.dart';

class BottomNavigationPage extends StatefulWidget {
  BottomNavigationPage({Key key}) : super(key: key);

  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    Podcast(),
    Home(),
    BottomProfile(),
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        // selectedItemColor: Colors.orange,
        // fixedColor: Color.fromRGBO(50, 219, 208, 1),
        // backgroundColor: Colors.black38,
        iconSize: 25,
        fixedColor: Colors.white,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.music_note,
              color: Color(0xFF1A3A77),
            ),
            title: new Text(
              getTranslated(context, 'podcasts'),
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Raleway",
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.home,
              color: Color(0xFF1A3A77),
              size: 30,
            ),
            title: new Text(
              getTranslated(context, 'home'),
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Raleway",
              ),
            ),
          ),
          // BottomNavigationBarItem(
          //   icon: new Icon(
          //     Icons.favorite,
          //     color: Color(0xFF1A3A77),
          //   ),
          //   // ignore: deprecated_member_use
          //   title: new Text(
          //     'Favourites',
          //     style: TextStyle(color: Colors.black, fontFamily: "Raleway"),
          //   ),
          // ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.person,
              color: Color(0xFF1A3A77),
            ),
            // ignore: deprecated_member_use
            title: new Text(
              getTranslated(context, 'profile'),
              style: TextStyle(fontFamily: "Raleway", color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
