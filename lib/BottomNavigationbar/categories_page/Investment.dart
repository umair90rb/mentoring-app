import 'package:flutter/material.dart';

class Investment extends StatefulWidget {
  Investment({Key key}) : super(key: key);

  @override
  _InvestmentState createState() => _InvestmentState();
}

class _InvestmentState extends State<Investment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Investment page"),
      ),
    ); 
  }
}