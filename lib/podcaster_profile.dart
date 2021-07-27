import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PodcasterProfile extends StatefulWidget {
  DocumentSnapshot podcaster;
  PodcasterProfile(this.podcaster);
  @override
  _PodcasterProfileState createState() => _PodcasterProfileState();
}

class _PodcasterProfileState extends State<PodcasterProfile> {
  TextStyle textStyle = TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    print(widget.podcaster.data());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Profile",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Raleway",
            ),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.only(left: 12, top: 30),
                  child: Text(
                    "Mentor Profile",
                    style: TextStyle(
                      color: Color.fromRGBO(22, 49, 78, 1),
                      fontSize: 35,
                      fontFamily: "Raleway",
                    ),
                  )),
              Stack(alignment: Alignment.center, children: <Widget>[
                Image.asset(
                  "assets/images/splashscreen.jpg",
                  height: 200,
                ),
                Positioned(
                  top: 30,
                  child: widget.podcaster.data().containsKey('photoURL') ?
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(widget.podcaster['photoURL']),
                      )
                      : Icon(
                    FontAwesomeIcons.userCircle,
                    size: 100,
                  ),
                ),
                Positioned(
                  top: 140,
                  child: Text(
                      widget.podcaster.data().containsKey('name')
                          ? widget.podcaster['name']
                          : widget.podcaster['email'],
                      style: TextStyle(fontFamily: "Raleway", fontSize: 20)),
                ),
              ]),
              Visibility(
                visible: widget.podcaster.data().containsKey('name'),
                child: Text(
                  'Email: ${widget.podcaster['email']} ',
                  style: textStyle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: widget.podcaster.data().containsKey('experties'),
                child: Text('Mentor of ${widget.podcaster['experties']}',
                    style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: widget.podcaster.data().containsKey('experties'),
                child: Text(
                  "Experience: ${widget.podcaster['experties']}",
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: widget.podcaster.data().containsKey('description'),
                child: Text(
                  "Description: ${widget.podcaster['description']}",
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: widget.podcaster.data().containsKey('qualification'),
                child: Text(
                  "Qualification: ${widget.podcaster['qualification']}",
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Reviews',
                style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.userCircle,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Mentor',
                                  style: TextStyle(
                                    fontFamily: "Raleway",
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'This mentor has no reviews',
                              style: TextStyle(
                                fontFamily: "Raleway",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
