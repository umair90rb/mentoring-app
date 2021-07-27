import 'package:brain_store/chat/full_photo.dart';
import 'package:brain_store/services/auth.dart';
import 'package:brain_store/services/db_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'dart:io' as io;

class Mentorprofile extends StatefulWidget {
  DocumentSnapshot podcaster;
  Mentorprofile(this.podcaster);
  @override
  _MentorprofileState createState() => _MentorprofileState();
}

class _MentorprofileState extends State<Mentorprofile> {
  DbServices _db = DbServices();
  AuthServices _auth = AuthServices();
  PlatformFile avatar;

  final _formKey = GlobalKey<FormState>();

  TextEditingController qualification ;
  TextEditingController experience ;
  TextEditingController description ;
  TextEditingController bio ;

  var user;
  String name = '';
  String email = '';
  String exper = '';
  String picture = 'https://i.picsum.photos/id/948/150/150.jpg?blur=5&hmac=OFdolGyj8x4WR5818sabc8NYY3d8K8DDWa6PW9_S1g8';
  List certifications = [];
  List license = [];

  getProfile(){
    name = widget.podcaster.data().containsKey('name') ? widget.podcaster['name'] : '';
    email = widget.podcaster.data().containsKey('email') ? widget.podcaster['email'] : '';
    exper = widget.podcaster.data().containsKey('experties') ? widget.podcaster['experties'] : '';
    certifications = widget.podcaster.data().containsKey('certification') ? widget.podcaster['certification'] : [];
    license = widget.podcaster.data().containsKey('licence') ? widget.podcaster['licence'] : [];
    picture = widget.podcaster.data().containsKey('photoURL') ? widget.podcaster['photoURL'] : 'https://i.picsum.photos/id/948/150/150.jpg?blur=5&hmac=OFdolGyj8x4WR5818sabc8NYY3d8K8DDWa6PW9_S1g8';
    qualification = TextEditingController(text: !widget.podcaster.data().containsKey('qualification') ? null : widget.podcaster['qualification']);
    experience = TextEditingController(text: !widget.podcaster.data().containsKey('experience') ? null : widget.podcaster['experience']);
    description = TextEditingController(text: !widget.podcaster.data().containsKey('description') ? null : widget.podcaster['description']);
    bio = TextEditingController(text: !widget.podcaster.data().containsKey('bio') ? null : widget.podcaster['bio']);
  }


  @override
  void initState() {
    print(widget.podcaster.data());
    getProfile();
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => getProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            SafeArea(
              child: Container(
                child: Center(
                  child: Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                      ),
                      child: Text(
                        name,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                      ),
                      child: Text(
                        "$exper Mentor",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30, left: 40, right: 40),
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage:
                            NetworkImage(picture),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                      ),
                      child: Text(
                        email,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),SizedBox(
                      height: 14,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      padding: EdgeInsets.only(bottom: 10),
                      child: TextField(
                        enabled: false,
                        onChanged: (value){},
                        controller: qualification,
                        cursorColor: Colors.orange,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: "Qualification",
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      padding: EdgeInsets.only(bottom: 10),
                      child: TextField(
                        enabled: false,
                        onChanged: (value){},
                        controller: experience,
                        cursorColor: Colors.orange,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: "Experience in field",
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      // hack textfield height
                      padding: EdgeInsets.only(bottom: 10),
                      child: TextField(
                        enabled: false,
                        controller: description,
                        onChanged: (value){},
                        cursorColor: Colors.orange,
                        maxLines: 10,
                        decoration: InputDecoration(
                          hintText: "Detailed Description",
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      // hack textfield height
                      padding: EdgeInsets.only(bottom: 10),
                      child: TextField(
                        enabled: false,
                        controller: bio,
                        onChanged: (value){},
                        cursorColor: Colors.orange,
                        maxLines: 10,
                        decoration: InputDecoration(
                          hintText: "Mentor Bio",
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                      ),
                    ),
                    Text('Certifications'),
                    images(certifications),
                    Text('Licences'),
                    images(license)
                  ]),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  images(List images){
    return Padding(
      padding: EdgeInsets.all(10),
      child: SizedBox(
        height: images == null || images.length == 0 ? 0 : 125,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: images.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => FullPhoto(url: images[index],)));
              },
              child: Card(
                margin: EdgeInsets.all(5),
                child: Image.network(
                  images[index],
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
                clipBehavior: Clip.hardEdge,
              ),
            );
          },
        ),
      ),
    );
  }
}
