import 'package:flutter/material.dart';

class Relationship extends StatefulWidget {
  Relationship({Key key}) : super(key: key);

  @override
  _RelationshipState createState() => _RelationshipState();
}

class _RelationshipState extends State<Relationship> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Relationship page"),
      ),
    );
  }
}
