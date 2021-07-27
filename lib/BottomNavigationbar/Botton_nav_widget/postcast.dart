import 'package:brain_store/BottomNavigationbar/Botton_nav_widget/Profile_sub_screens/subprofile.dart';
import 'package:brain_store/BottomNavigationbar/Botton_nav_widget/catpodcast.dart';
import 'package:brain_store/BottomNavigationbar/Botton_nav_widget/favourite.dart';
import 'package:brain_store/BottomNavigationbar/Botton_nav_widget/profile.dart';
import 'package:brain_store/localization/language_constants.dart';
import 'package:brain_store/musicpage.dart';
import 'package:brain_store/musicplayer.dart';
import 'package:brain_store/searchpage.dart';
import 'package:brain_store/services/db_services.dart';
import 'package:brain_store/tab_view_widget/tab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Podcast extends StatefulWidget {
  Podcast({Key key}) : super(key: key);

  @override
  _PodcastState createState() => _PodcastState();
}

class _PodcastState extends State<Podcast> with SingleTickerProviderStateMixin {
  DbServices _db = DbServices();
  Future featured;
  Future getFeatured() {
    return _db.getSnapshot('featured');
  }

  @override
  void initState() {
    featured = getFeatured();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Subprofile()));
            },
            icon: Icon(
              Icons.person_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchPage()));
              },
            ),
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Favourite()));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: featured,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<QueryDocumentSnapshot> docs = snapshot.data;
                      DocumentSnapshot featured = docs.first;
                      return Container(
                        width: size.width / 1,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              height: size.height / 3,
                              width: size.width / 1,
                              decoration: BoxDecoration(
                                color: const Color(0xff7c94b6),
                                image: DecorationImage(
                                  image: NetworkImage(featured['thumbnail']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              height: 20,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                getTranslated(context, 'featured'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  letterSpacing: 1.5,
                                  color: Colors.black,
                                  fontFamily: "Raleway",
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    "${featured['name']}",
                                    style: TextStyle(
                                      letterSpacing: 1,
                                      fontFamily: "Raleway",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.music_note_sharp,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    "• ${featured['description']} • ${featured['duration']} min",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Raleway",
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                print('featured podcast playing');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MusicPlayerScreen(featured)),
                                );
                              },
                              child: Container(
                                height: 45,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: Color(0xFF1A3A77),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.play_arrow_rounded,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      getTranslated(context, 'play'),
                                      style: TextStyle(
                                        fontFamily: "Raleway",
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return Text('Something goes wrong');
                    }
                    return CircularProgressIndicator();
                  }),

              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        getTranslated(context, 'explorePodcasts'),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Raleway",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CatPodcast("Relationship"))),
                child: Container(
                  height: 150,
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.blue,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 55,
                          child: Image.asset('assets/images/Relationship.jpeg'),
                        ),
                        Expanded(
                          flex: 66,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 30,
                                child: Center(
                                    child: Text(
                                  'Relationship',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Raleway"),
                                )),
                              ),
                              Expanded(
                                flex: 25,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 5, right: 2),
                                    child: Text(
                                      'Explore podcasts by relationship mentors',
                                      style: TextStyle(
                                          fontSize: 14, fontFamily: "Raleway"),
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CatPodcast("Nutrition"))),
                child: Container(
                  height: 150,
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.blue,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 55,
                          child: Image.asset(
                              'assets/images/Health & Nutrition.jpeg'),
                        ),
                        Expanded(
                          flex: 66,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 30,
                                child: Center(
                                    child: Text(
                                  'Nutrition',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Raleway"),
                                )),
                              ),
                              Expanded(
                                flex: 25,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 5, right: 2),
                                    child: Text(
                                      'Explore podcasts by nutrition mentors',
                                      style: TextStyle(
                                          fontSize: 14, fontFamily: "Raleway"),
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CatPodcast("Beauty"))),
                child: Container(
                  height: 150,
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.blue,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 55,
                          child: Image.asset('assets/images/Beauty.jpeg'),
                        ),
                        Expanded(
                          flex: 66,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 30,
                                child: Center(
                                    child: Text(
                                  'Beauty',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Raleway"),
                                )),
                              ),
                              Expanded(
                                flex: 25,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 5, right: 2),
                                    child: Text(
                                      'Explore podcasts by beauty mentors',
                                      style: TextStyle(
                                          fontSize: 14, fontFamily: "Raleway"),
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CatPodcast("Career & Education"))),
                child: Container(
                  height: 150,
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.blue,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 55,
                          child: Image.asset('assets/images/Career.jpeg'),
                        ),
                        Expanded(
                          flex: 66,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 30,
                                child: Center(
                                    child: Text(
                                  'Career & Education',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Raleway"),
                                )),
                              ),
                              Expanded(
                                flex: 25,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 5, right: 2),
                                    child: Text(
                                      'Explore podcasts by career & education mentors',
                                      style: TextStyle(
                                          fontSize: 14, fontFamily: "Raleway"),
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CatPodcast("Work & Profession"))),
                child: Container(
                  height: 150,
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.blue,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 55,
                          child: Image.asset(
                              'assets/images/Work and Profession.jpeg'),
                        ),
                        Expanded(
                          flex: 66,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 30,
                                child: Center(
                                    child: Text(
                                  'Work & Profession',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Raleway"),
                                )),
                              ),
                              Expanded(
                                flex: 25,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 5, right: 2),
                                    child: Text(
                                      'Explore podcasts by work & profession mentors',
                                      style: TextStyle(
                                          fontSize: 14, fontFamily: "Raleway"),
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CatPodcast("Entrepreneurship"))),
                child: Container(
                  height: 150,
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.blue,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 55,
                          child: Image.asset(
                              'assets/images/Entreprenuership.jpeg'),
                        ),
                        Expanded(
                          flex: 66,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 30,
                                child: Center(
                                    child: Text(
                                  'Entrepreneurship',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Raleway"),
                                )),
                              ),
                              Expanded(
                                flex: 25,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 5, right: 2),
                                    child: Text(
                                      'Explore podcasts by entrepreneurship mentors',
                                      style: TextStyle(
                                          fontSize: 14, fontFamily: "Raleway"),
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CatPodcast("Travel"))),
                child: Container(
                  height: 150,
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.blue,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 55,
                          child: Image.asset('assets/images/Travel.jpeg'),
                        ),
                        Expanded(
                          flex: 66,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 30,
                                child: Center(
                                    child: Text(
                                  'Travel',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Raleway"),
                                )),
                              ),
                              Expanded(
                                flex: 25,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 5, right: 2),
                                    child: Text(
                                      'Explore podcasts by travel mentors',
                                      style: TextStyle(
                                          fontSize: 14, fontFamily: "Raleway"),
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CatPodcast("Investment"))),
                child: Container(
                  height: 150,
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.blue,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 55,
                          child: Image.asset(
                              'assets/images/Finance & Investment.jpeg'),
                        ),
                        Expanded(
                          flex: 66,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 30,
                                child: Center(
                                    child: Text(
                                  'Investment',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Raleway"),
                                )),
                              ),
                              Expanded(
                                flex: 25,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 5, right: 2),
                                    child: Text(
                                      'Explore podcasts by investment mentors',
                                      style: TextStyle(
                                          fontSize: 14, fontFamily: "Raleway"),
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CatPodcast("Legal"))),
                child: Container(
                  height: 150,
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.blue,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 55,
                          child: Image.asset('assets/images/Legal.jpeg'),
                        ),
                        Expanded(
                          flex: 66,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 30,
                                child: Center(
                                    child: Text(
                                  'Legal',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Raleway"),
                                )),
                              ),
                              Expanded(
                                flex: 25,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 5, right: 2),
                                    child: Text(
                                      'Explore podcasts by legal mentors',
                                      style: TextStyle(
                                          fontSize: 14, fontFamily: "Raleway"),
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CatPodcast("Emotional"))),
                child: Container(
                  height: 150,
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.blue,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 55,
                          child: Image.asset('assets/images/Emotional.jpeg'),
                        ),
                        Expanded(
                          flex: 66,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 30,
                                child: Center(
                                    child: Text(
                                  'Emotional',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Raleway"),
                                )),
                              ),
                              Expanded(
                                flex: 25,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 5, right: 2),
                                    child: Text(
                                      'Explore podcasts by emotional mentors',
                                      style: TextStyle(
                                          fontSize: 14, fontFamily: "Raleway"),
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // FutureBuilder(
              //     future: _db.getSnapshot('podcasts'),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         List<DocumentSnapshot> podcasts = snapshot.data;
              //         return Column(
              //           children: podcasts
              //               .map((e) => podcastTile(e, context))
              //               .toList(),
              //         );
              //       }
              //       if (snapshot.hasError) {
              //         return Text(
              //             'Something goes wrong while fetching podcasts!');
              //       }
              //       return Center(
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(vertical: 20),
              //           child: CircularProgressIndicator(),
              //         ),
              //       );
              //     }),
            ],
          ),
        ),
      ),
    );
  }

  Widget podcastTile(dynamic podcast, context) {
    print(podcast);
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Card(
        color: Colors.white70,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => MusicPage(podcast))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.album, size: 50, color: Colors.black),
                title: Text(
                  podcast['name'],
                  style: TextStyle(
                    fontFamily: "Raleway",
                  ),
                ),
                subtitle: Text(
                  podcast['description'],
                  style: TextStyle(
                    fontFamily: "Raleway",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
