import 'package:flutter/material.dart';
class Beauty extends StatefulWidget {
  Beauty({Key key}) : super(key: key);

  @override
  _BeautyState createState() => _BeautyState();
}

class _BeautyState extends State<Beauty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Beauty page"),
      ),
    );
  }
}