import 'package:flutter/material.dart';


class Nutrition extends StatefulWidget {
  Nutrition({Key key}) : super(key: key);

  @override
  _NutritionState createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Nutrition page"),
      ),
    );
  }
}