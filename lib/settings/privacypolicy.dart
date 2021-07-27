import 'package:brain_store/BottomNavigationbar/Botton_nav_widget/Home_Screen.dart';
import 'package:brain_store/BottomNavigationbar/Botton_nav_widget/Profile_sub_screens/profile_setting.dart';
import 'package:brain_store/BottomNavigationbar/Botton_nav_widget/profile.dart';
import 'package:brain_store/localization/language_constants.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var randomtext = getTranslated(context, 'privacyPolicyBody');
    return Scaffold(
      appBar: AppBar(
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
          getTranslated(context, 'privacyPolicy'),
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Raleway",
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(),
                child: Container(
                  height: 5,
                  color: Color(0xFF1A3A77),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    child: Text(
                      randomtext,
                      style: TextStyle(
                        fontFamily: "Raleway",
                      ),
                    ),
                  )),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
