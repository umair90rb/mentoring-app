import 'package:brain_store/BottomNavigationbar/Botton_nav_widget/profile.dart';
import 'package:brain_store/localization/language_constants.dart';
import 'package:flutter/material.dart';

class Paymenthistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          getTranslated(context, 'paymentHistory'),
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Raleway",
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(),
            child: Container(
              height: 5,
              color: Color(0xFF1A3A77),
            ),
          ),
          SizedBox(
            height: 300,
          ),
          Text(
            getTranslated(context, 'noPayment'),
            style: TextStyle(
              fontFamily: "Raleway",
            ),
          ),
        ],
      ),
    );
  }
}
