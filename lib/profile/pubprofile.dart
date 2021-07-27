import 'package:brain_store/Tabbarscreens/mentorprofile.dart';
import 'package:brain_store/Tabbarscreens/mentorreviews.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Pubprofile extends StatelessWidget {
  DocumentSnapshot podcaster;
  Pubprofile(this.podcaster);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          bottom: TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            labelStyle: TextStyle(fontFamily: "Raleway"),
            onTap: (index) {},
            tabs: [
              Tab(
                text: "Mentor Profile",
              ),
              Tab(text: "Reviews")
            ],
            indicatorColor: Colors.white,
          ),
          title: Text(
            'Mentor Profile',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: TabBarView(
          children: [
            Mentorprofile(podcaster),
            Mentorreviews(podcaster),
          ],
        ),
      ),
    );
  }
}
