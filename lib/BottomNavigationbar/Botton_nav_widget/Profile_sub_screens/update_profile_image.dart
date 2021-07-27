import 'package:flutter/material.dart';

class UpdateProfileImage extends StatefulWidget {
  UpdateProfileImage({Key key}) : super(key: key);

  @override
  _UpdateProfileImageState createState() => _UpdateProfileImageState();
}

class _UpdateProfileImageState extends State<UpdateProfileImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Update Image",
          style: TextStyle(
            fontFamily: "Raleway",
            color: Colors.blue,
            fontSize: 28.0,
          ),
        ),
      ),
      body: Center(
        child: Text(
          "Image Upload",
          style: TextStyle(
            fontFamily: "Raleway",
          ),
        ),
      ),
    );
  }
}
