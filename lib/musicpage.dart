import 'package:audio_service/audio_service.dart';
// import 'package:brain_store/BottomNavigationbar/Botton_nav_widget/postcast.dart';
// import 'package:brain_store/musicplayer.dart';
import 'package:brain_store/player.dart';
import 'package:brain_store/services/db_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

import 'audio_service/BGAudioPlayerScreen.dart';

class MusicPage extends StatefulWidget {
  dynamic podcast;
  MusicPage(this.podcast);

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  DbServices db = DbServices();
  User user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: FutureBuilder<DocumentSnapshot>(
              future: db.getDoc(
                  'favourite/${user.uid}/favourite', widget.podcast.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print("fav snapshot is hrer ${snapshot.data.data()}");
                  return Container(
                    child: Column(children: <Widget>[
                      Container(
                        width: 600,
                        height: 350,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(color: Colors.transparent, width: 0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: EdgeInsets.only(top: 30, left: 10, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  widget.podcast['thumbnail'],
                                ),
                              ),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: InkWell(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: ClipOval(
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: ListTile(
                          title: Text(
                            widget.podcast['name'],
                            style: TextStyle(
                              fontSize: 35,
                              fontFamily: "Raleway",
                              color: Colors.black,
                            ),
                          ),
                          trailing: FavoriteButton(
                            isFavorite: snapshot.data.data() == null ? false : true,
                            iconSize: 40,
                            iconColor: Colors.red,
                            valueChanged: (_isFavorite) async {
                              print('Is Favorite : $_isFavorite');
                              if (_isFavorite) {
                                await db.addDataWithId(
                                    'favourite/${user.uid}/favourite',
                                    widget.podcast.id,
                                    widget.podcast.data());
                                Fluttertoast.showToast(
                                    msg: 'Added to Favourite');
                              } else {
                                await db.firestore
                                    .collection(
                                        'favourite/${user.uid}/favourite')
                                    .doc(widget.podcast.id)
                                    .delete();
                                Fluttertoast.showToast(
                                    msg: 'Removed from Favourite');
                              }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(children: <Widget>[
                          Icon(
                            Icons.music_note,
                          ),
                          Text(
                            " • Develop Focus on Meditation Podcast • ${(widget.podcast['duration'] / 60).toStringAsFixed(2)} min",
                            style: TextStyle(
                              fontFamily: "Raleway",
                            ),
                          )
                        ]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(
                          children: <Widget>[
                            Text(
                              widget.podcast['description'],
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Raleway",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 80),
                      Container(
                        child: ButtonTheme(
                          minWidth: 300.0,
                          // height: 50.0,
                          child: RaisedButton(
                            color: Color(0xFF1A3A77),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            padding: EdgeInsets.all(6.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    "Play",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Raleway",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              MediaItem item = MediaItem(
                                id: widget.podcast['podcast'],
                                album: widget.podcast['name'],
                                title: widget.podcast['description'],
                                artist:
                                    widget.podcast.data().containsKey('email')
                                        ? widget.podcast['email']
                                        : 'example@mail.com',
                                duration: Duration(
                                    seconds:
                                        widget.podcast['duration'].toInt()),
                                artUri: widget.podcast['thumbnail'],
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BGAudioPlayerScreen(item)),
                              );
                            },
                          ),
                        ),
                      ),
                    ]),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Something goes wrong!',
                      style: TextStyle(
                        fontFamily: "Raleway",
                      ),
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }
}
