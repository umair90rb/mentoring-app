import 'package:flutter/material.dart';

class Emotional extends StatefulWidget {
  Emotional({Key key}) : super(key: key);

  @override
  _EmotionalState createState() => _EmotionalState();
}

class _EmotionalState extends State<Emotional> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Emotional page"),
      ),
    );
  }
}