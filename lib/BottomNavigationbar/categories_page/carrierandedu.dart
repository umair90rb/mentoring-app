import 'package:flutter/material.dart';

class CareerAndEducation extends StatefulWidget {
  CareerAndEducation({Key key}) : super(key: key);

  @override
  _CareerAndEducationState createState() => _CareerAndEducationState();
}

class _CareerAndEducationState extends State<CareerAndEducation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Career & Education page"),
      ),
    );
  }
}