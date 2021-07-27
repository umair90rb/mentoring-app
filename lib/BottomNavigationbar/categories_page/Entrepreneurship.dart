import 'package:flutter/material.dart';

class Entrepreneurship extends StatefulWidget {
  Entrepreneurship({Key key}) : super(key: key);

  @override
  _EntrepreneurshipState createState() => _EntrepreneurshipState();
}

class _EntrepreneurshipState extends State<Entrepreneurship> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Entrepreneurship page"),
      ),
    );
  }
}