import 'package:brain_store/localization/language_constants.dart';
import 'package:brain_store/services/auth.dart';
import 'package:brain_store/settings/accountdetails.dart';
import 'package:brain_store/settings/invite.dart';
import 'package:brain_store/settings/language.dart';
import 'package:brain_store/settings/paymenthistory.dart';
import 'package:brain_store/settings/privacypolicy.dart';
import 'package:brain_store/settings/termsandconfitionspage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nice_button/NiceButton.dart';

import '../../logoutalert.dart';
import '../../reportbug.dart';

class BottomProfile extends StatefulWidget {
  BottomProfile({Key key}) : super(key: key);

  @override
  _BottomProfileState createState() => _BottomProfileState();
}

class _BottomProfileState extends State<BottomProfile> {
  AuthServices auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          getTranslated(context, 'setting'),
          style: TextStyle(
            color: Colors.black,
            fontSize: 28.0,
            fontFamily: "Raleway",
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Card(
                        elevation: 1,
                        child: ListTile(
                          selectedTileColor: Colors.white,
                          tileColor: Colors.white,
                          title: Text(
                            getTranslated(context, 'accountDetails'),
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                            // textScaleFactor: 1.5,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                             color: Color(0xFF1A3A77),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Accountdetails()),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Card(
                        elevation: 1,
                        child: ListTile(
                          selectedTileColor: Colors.white,
                          tileColor: Colors.white,
                          title: Text(
                            getTranslated(context, 'inviteFriends'),
                            style: TextStyle(
                              fontFamily: "Raleway",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                            // textScaleFactor: 1.5,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                              color: Color(0xFF1A3A77),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Invitefriends()),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Card(
                        elevation: 1,
                        child: ListTile(
                          selectedTileColor: Colors.white,
                          tileColor: Colors.white,
                          title: Text(
                            getTranslated(context, 'language'),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Raleway",
                              color: Colors.black54,
                            ),
                            // textScaleFactor: 1.5,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                              color: Color(0xFF1A3A77),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Languages()),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Card(
                        elevation: 1,
                        child: ListTile(
                          selectedTileColor: Colors.white,
                          tileColor: Colors.white,
                          title: Text(
                            getTranslated(context, 'paymentHistory'),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Raleway",
                              color: Colors.black54,
                            ),
                            // textScaleFactor: 1.5,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                             color: Color(0xFF1A3A77),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Paymenthistory()),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Card(
                        elevation: 1,
                        child: ListTile(
                          selectedTileColor: Colors.white,
                          tileColor: Colors.white,
                          title: Text(
                            getTranslated(context, 'support'),
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                            // textScaleFactor: 1.5,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                              color: Color(0xFF1A3A77),
                          ),
                          onTap: () async {
                            if (await canLaunch("https:google.com/")) {
                              await launch("https:google.com/");
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Card(
                        elevation: 1,
                        child: ListTile(
                          selectedTileColor: Colors.white,
                          tileColor: Colors.white,
                          title: Text(
                            getTranslated(context, 'termsAndConditions'),
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                            // textScaleFactor: 1.5,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFF1A3A77),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Termsandconditions()),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Card(
                        elevation: 1,
                        child: ListTile(
                          selectedTileColor: Colors.white,
                          tileColor: Colors.white,
                          title: Text(
                            getTranslated(context, 'privacyPolicy'),
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                            // textScaleFactor: 1.5,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                              color: Color(0xFF1A3A77),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PrivacyPolicy()),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Card(
                        elevation: 1,
                        child: ListTile(
                          selectedTileColor: Colors.white,
                          tileColor: Colors.white,
                          title: Text(
                            getTranslated(context, 'reportBug'),
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                            // textScaleFactor: 1.5,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                              color: Color(0xFF1A3A77),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReportBug()),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                  padding: EdgeInsets.only(),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Text(
                          getTranslated(context, 'loggedInAs'),
                          style: TextStyle(
                            fontFamily: "Raleway",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(user?.email ?? ''),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          getTranslated(context, 'version'),
                          style: TextStyle(
                            fontFamily: "Raleway",
                          ),
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: SizedBox(
                  width: 370.0,
                  height: 50.0,
                  child: RaisedButton(
                    splashColor: Colors.white,
                    elevation: 2,
                    color: Color(0xFF1A3A77),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onPressed: () {
                      Navigator.pop(showAlertDialog(context));
                      // auth.signOut().then((value) => Navigator.pop(showAlertDialog(context)));
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Raleway",
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
