import 'dart:io';

import 'package:brain_store/BottomNavigationbar/Botton_nav_widget/Profile_sub_screens/journey.dart';
import 'package:brain_store/BottomNavigationbar/Botton_nav_widget/Profile_sub_screens/stats.dart';
import 'package:brain_store/BottomNavigationbar/Botton_nav_widget/postcast.dart';
import 'package:brain_store/localization/language_constants.dart';
import 'package:brain_store/services/auth.dart';
import 'package:brain_store/services/db_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

import '../profile.dart';
import 'buddylinks.dart';

class Subprofile extends StatefulWidget {
  @override
  _SubprofileState createState() => _SubprofileState();
}

class _SubprofileState extends State<Subprofile> {
  DbServices _db = DbServices();
  AuthServices _auth = AuthServices();
  PlatformFile avatar;

  // getProfile(String uid){
  //   _db.getDoc('profile', uid).then((profile) {
  //     name = profile['firstName'] + " " + profile['lastName'];
  //     mounted ? setState(() {}) : null ;
  //   });
  // }

  @override
  void initState() {
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => getProfile(user.uid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    print(user.photoURL);

    return DefaultTabController(
      length: 1,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.close_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
          // actions: [
          //   IconButton(
          //     icon: Icon(
          //       Icons.settings,
          //       color: Colors.black,
          //       size: 30,
          //     ),
          //     onPressed: () {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => BottomProfile()));
          //     },
          //   ),
          // ],
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      FilePickerResult result =
                          await FilePicker.platform.pickFiles();
                      ProgressDialog dialog = ProgressDialog(context);
                      dialog.style(
                          message: 'Please wait...',
                          progressTextStyle: TextStyle(fontFamily: "Raleway"));
                      if (result != null) {
                        await dialog.show();
                        avatar = result.files.first;
                        _db
                            .uploadFile('avatars', File(avatar.path))
                            .then((value) {
                          _auth.updateUser(value).then((value) async {
                            await dialog.hide();
                            setState(() {});
                            return Fluttertoast.showToast(
                                msg: 'Profile picture updated!');
                          });
                        });
                      } else {
                        return Fluttertoast.showToast(msg: 'No file selected!');
                      }
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: avatar == null
                          ? NetworkImage(user?.photoURL ??
                              "https://i.picsum.photos/id/766/150/150.jpg?blur=5&hmac=cRKS1b6jxUs1W-tduOnXbNti1WIJlTigCgwCeti_EqQ")
                          : FileImage(File(avatar.path)),
                      // backgroundImage: (user == null && avatar == null) ? null : (avatar == null ?  NetworkImage(user.photoURL == null ? 'https://i.picsum.photos/id/766/150/150.jpg?blur=5&hmac=cRKS1b6jxUs1W-tduOnXbNti1WIJlTigCgwCeti_EqQ' : user.photoURL) : FileImage(File(avatar.path))),
                      // child: user.photoURL == null ? Icon(
                      //   Icons.account_circle,
                      //   size: 80.0,
                      //   color: Colors.white,
                      // ) : null ,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FutureBuilder(
                      future: _db.getDoc('profile', user.uid),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            "${snapshot.data['firstName']} ${snapshot.data['lastName']}",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          return Text(
                            "Error!",
                            style: TextStyle(
                              fontFamily: "Raleway",
                            ),
                          );
                        }
                        return CircularProgressIndicator();
                      })
                  //
                ],
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.square(150.0),
            child: TabBar(
              labelColor: Colors.black,
              labelStyle: TextStyle(fontFamily: "Raleway", fontSize: 18),
              indicatorColor: Colors.black,
              tabs: [
                // Tab(
                //   text: "Buddies",
                // ),
                Tab(
                  text: getTranslated(context, 'stats'),
                ),
                // Tab(
                //   text: "Journey",
                // ),
              ],
            ),
          ),
        ),
        body: TabBarView(children: [
          // Buddylinks(),
          Stats(),
          // Journey(),
        ]),
      ),
    );
  }
}
