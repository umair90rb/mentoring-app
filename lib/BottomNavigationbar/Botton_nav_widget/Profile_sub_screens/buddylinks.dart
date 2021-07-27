import 'package:flutter/material.dart';

class Buddylinks extends StatefulWidget {
  Buddylinks({Key key}) : super(key: key);

  @override
  _BuddylinksState createState() => _BuddylinksState();
}

class _BuddylinksState extends State<Buddylinks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "There are no buddy links",
          style: TextStyle(
            fontFamily: "Raleway",
          ),
        ),
      ),
    );
  }
}
