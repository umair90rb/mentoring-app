import 'package:flutter/material.dart';


class Legal extends StatefulWidget {
  Legal({Key key}) : super(key: key);

  @override
  _LegalState createState() => _LegalState();
}

class _LegalState extends State<Legal> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text("Legal page"),
      ),
    );
  }
}