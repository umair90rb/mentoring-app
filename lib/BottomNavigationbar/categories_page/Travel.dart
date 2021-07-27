import 'package:flutter/material.dart';


class Travel extends StatefulWidget {
  Travel({Key key}) : super(key: key);

  @override
  _TravelState createState() => _TravelState();
}

class _TravelState extends State<Travel> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text("Travel page"),
      ),
    );
  }
}