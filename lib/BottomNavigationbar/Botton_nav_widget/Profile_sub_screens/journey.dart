import 'package:flutter/material.dart';

class Journey extends StatefulWidget {
  Journey({Key key}) : super(key: key);

  @override
  _JourneyState createState() => _JourneyState();
}

class _JourneyState extends State<Journey> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "You have no record",
          style: TextStyle(
            fontFamily: "Raleway",
          ),
        ),
      ),
    );
  }
}
