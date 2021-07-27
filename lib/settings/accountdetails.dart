import 'package:brain_store/localization/language_constants.dart';
import 'package:brain_store/services/auth.dart';
import 'package:brain_store/services/db_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:provider/provider.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Accountdetails extends StatefulWidget {
  @override
  _AccountdetailsState createState() => _AccountdetailsState();
}

class _AccountdetailsState extends State<Accountdetails> {
  String firstName = '';
  String lastName = '';

  DbServices _db = DbServices();
  AuthServices _auth = AuthServices();

  var user;

  getProfile(String uid) {
    _db.getDoc('profile', uid).then((profile) {
      firstName = profile['firstName'];
      lastName = profile['lastName'];
      mounted ? setState(() {}) : null;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => getProfile(user.uid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);

    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => BottomProfile()));
        //   },
        //   icon: Icon(
        //     Icons.arrow_back_ios,
        //     color: Colors.black,
        //   ),
        // ),
        title: Text(
          getTranslated(context, 'accountDetails'),
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Raleway",
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(),
              child: Container(
                height: 5,
                color: Color(0xFF1A3A77),
              ),
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              getTranslated(context, 'firstName'),
                              style: TextStyle(
                                color: Color(0xFF1A3A77),
                                fontSize: 13,
                                fontFamily: "Raleway",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(),
                    child: Card(
                      elevation: 0,
                      child: ListTile(
                        selectedTileColor: Colors.white,
                        tileColor: Colors.white,
                        title: Text(
                          firstName,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        trailing: InkWell(
                          onTap: () async {
                            String result = await prompt(context);
                            setState(() {
                              firstName = result;
                            });
                          },
                          child: Text(
                            getTranslated(context, 'edit'),
                            style: TextStyle(
                                color: Color(0xFF1A3A77),
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => SettingProfile()),
                          // );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              getTranslated(context, 'lastName'),
                              style: TextStyle(
                                  fontFamily: "Raleway",
                                  color: Color(0xFF1A3A77),
                                  fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(),
                    child: Card(
                      elevation: 0,
                      child: ListTile(
                        selectedTileColor: Colors.white,
                        tileColor: Colors.white,
                        title: Text(
                          lastName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            fontFamily: "Raleway",
                          ),
                          // textScaleFactor: 1.5,
                        ),
                        trailing: InkWell(
                          onTap: () async {
                            String result = await prompt(context);
                            setState(() {
                              lastName = result;
                            });
                          },
                          child: Text(
                            getTranslated(context, 'edit'),
                            style: TextStyle(
                                color: Color(0xFF1A3A77),
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => SettingProfile()),
                          // );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              getTranslated(context, 'email'),
                              style: TextStyle(
                                  fontFamily: "Raleway",
                                  color: Color(0xFF1A3A77),
                                  fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(),
                    child: Card(
                      elevation: 0,
                      child: ListTile(
                        selectedTileColor: Colors.white,
                        tileColor: Colors.white,
                        title: Text(
                          user.email,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            fontFamily: "Raleway",
                          ),
                          // textScaleFactor: 1.5,
                        ),
                        // trailing: Text(
                        //   "EDIT",
                        //   style: TextStyle(
                        //       color: Colors.orange,
                        //       fontWeight: FontWeight.bold,
                        //       fontSize: 16),
                        // ),
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => SettingProfile()),
                          // );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              getTranslated(context, 'password'),
                              style: TextStyle(
                                  fontFamily: "Raleway",
                                  color: Color(0xFF1A3A77),
                                  fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(),
                    child: Card(
                      elevation: 0,
                      child: ListTile(
                        selectedTileColor: Colors.white,
                        tileColor: Colors.white,
                        title: Text(
                          '********',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            fontFamily: "Raleway",
                          ),
                          // textScaleFactor: 1.5,
                        ),
                        trailing: Text(
                          getTranslated(context, 'edit'),
                          style: TextStyle(
                              color: Color(0xFF1A3A77),
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        onTap: () async {
                          ProgressDialog dialog = ProgressDialog(context);
                          dialog.style(
                            message: "Please wait...",
                          );
                          await dialog.show();
                          _auth.forgotPassword(user.email).then((value) async {
                            await dialog.hide();
                            value
                                ? Fluttertoast.showToast(
                                    msg: 'Reset link send to email!')
                                : Fluttertoast.showToast(
                                    msg: 'Something goes wrong!');
                          });
                        },
                      ),
                    ),
                  ),
                  // SizedBox(height: 20),
                  // Container(
                  //   child: Padding(
                  //     padding: EdgeInsets.only(left: 10),
                  //     child: Row(
                  //       children: <Widget>[
                  //         Expanded(
                  //           child: Text(
                  //             'My buddy link',
                  //             style: TextStyle(
                  //                 color: Colors.blueGrey, fontSize: 13),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(),
                  //   child: Card(
                  //     elevation: 0,
                  //     child: ListTile(
                  //       selectedTileColor: Colors.white,
                  //       tileColor: Colors.white,
                  //       title: Text(
                  //         'My buddy link',
                  //         style: TextStyle(
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.black54,
                  //         ),
                  //         // textScaleFactor: 1.5,
                  //       ),
                  //       trailing: Text(
                  //         "CHANGE",
                  //         style: TextStyle(
                  //             color: Colors.orange,
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 16),
                  //       ),
                  //       onTap: () {
                  //         // Navigator.push(
                  //         //   context,
                  //         //   MaterialPageRoute(
                  //         //       builder: (context) => SettingProfile()),
                  //         // );
                  //       },
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 5,
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
                        onPressed: () async {
                          ProgressDialog dialog = ProgressDialog(context);
                          dialog.style(
                              message: "Please wait...",
                              progressTextStyle:
                                  TextStyle(fontFamily: "Raleway"));
                          await dialog.show();
                          _db.updateDoc('profile', user.uid, {
                            'firstName': firstName,
                            'lastName': lastName
                          }).then((value) async {
                            await dialog.hide();
                            Fluttertoast.showToast(msg: 'Profile updated');
                          });
                        },
                        child: Text(
                          "Update",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Raleway",
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
