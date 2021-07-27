import 'package:brain_store/services/db_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../musicpage.dart';

class Favourite extends StatelessWidget {
  DbServices db = DbServices();
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: Text("Favourites"),
      ),
      body: FutureBuilder(
        future: db.getSnapshot('favourite/${user.uid}/favourite'),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            List results = snapshot.data;
            print(results);
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      dense: false,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MusicPage(results[index]))),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(results[index]
                                ['thumbnail'] ??
                            'https://i.picsum.photos/id/605/50/50.jpg?blur=5&hmac=ECBIpAv8BZAqhFEisCS-fxNojk0Xegm3vRx_-4ctkfQ'),
                      ),
                      title: Text(
                        results[index]['name'],
                        style: TextStyle(
                          fontFamily: "Raleway",
                        ),
                      ),
                      trailing: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    );
                  }),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Something goes wrong!',
                style: TextStyle(fontFamily: "Raleway"),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
