import 'package:brain_store/localization/language_constants.dart';
import 'package:brain_store/services/db_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Stats extends StatefulWidget {
  Stats({Key key}) : super(key: key);

  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  DbServices db = DbServices();
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
          future: db.getDoc('profile', user.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data.data();
              Duration talkTime = Duration(minutes: data['talkTime']);
              Timestamp purchaseAt = data['packageBoughtAt'];
              String purchased = purchaseAt == null ? null : purchaseAt.toDate().toString();
              String expiry = purchaseAt == null ? null :
                  purchaseAt.toDate().add(Duration(days: 30)).toString();
              return Card(
                shadowColor: Colors.blue,
                elevation: 5,
                margin: EdgeInsets.all(15),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                          // 'Your Package: ${data['package'].toUpperCase()}',
                          'Your Package: ${data['package']??"Pay as you Go"}',
                          style:
                              TextStyle(fontFamily: "Raleway", fontSize: 20)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Remaining Talk Time: ${talkTime.toString().substring(0, talkTime.toString().length - 7)}',
                          style:
                              TextStyle(fontFamily: "Raleway", fontSize: 20)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Package Purchased on: ${expiry != null  ? expiry.substring(0, expiry.length - 15):"No Package Purchased"}',
                          style:
                              TextStyle(fontFamily: "Raleway", fontSize: 20)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Package Expires on: ${purchased != null ? purchased.toString().substring(0, purchased.toString().length - 15) : "No Package Purchased"}',
                          style:
                              TextStyle(fontFamily: "Raleway", fontSize: 20)),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
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
              child: Text(
                getTranslated(context, 'noStatsToShow'),
                style: TextStyle(
                  fontFamily: "Raleway",
                ),
              ),
            );
          }),
    );
  }
}
