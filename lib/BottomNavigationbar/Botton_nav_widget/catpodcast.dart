import 'package:brain_store/services/db_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../musicpage.dart';

class CatPodcast extends StatelessWidget {
  String cat;
  CatPodcast(this.cat);

  DbServices _db = DbServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Podcasts"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: _db.getSnapshotWithQuery('podcasts', 'category', [cat]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> podcasts = snapshot.data;
              if (podcasts.isEmpty)
                return Center(
                  child: Text('No podcast in this category'),
                );
              return Column(
                children: podcasts.map((e) => podcastTile(e, context)).toList(),
              );
            }
            if (snapshot.hasError) {
              return Text('Something goes wrong while fetching podcasts!');
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CircularProgressIndicator(),
              ),
            );
          }),
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
