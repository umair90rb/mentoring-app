import 'package:brain_store/BottomNavigationbar/Botton_nav_widget/postcast.dart';
import 'package:brain_store/musicpage.dart';
import 'package:brain_store/services/db_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController query = TextEditingController();
  DbServices db = DbServices();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List results = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.search,
        ),
        onPressed: () {
          if (query.text.isEmpty) {
            return ScaffoldState().showSnackBar(SnackBar(
                content: Text(
              'Please enter a query',
              style: TextStyle(
                fontFamily: "Raleway",
              ),
            )));
          }
          firestore
              .collection('podcasts')
              .orderBy('name')
              .startAt([query.text])
              .endAt([query.text + '\uf8ff'])
              .get()
              .then((result) {
                results.clear();
                this.setState(() {
                  results.addAll(result.docs);
                });
              });
        },
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Search Podcast",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Raleway",
          ),
        ),
        backgroundColor: Colors.white,
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
        child: Container(
            padding: EdgeInsets.only(),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: query,
                    cursorColor: Color(0xFF1C3B77),
                    cursorWidth: 1.5,
                    decoration: InputDecoration(
                      labelText: "Type something and press search button",
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: "Raleway",
                      ),
                      fillColor: Colors.transparent,
                      focusColor: Colors.orange,
                      hoverColor: Colors.orange,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      contentPadding: EdgeInsets.all(18),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 16,
                        color: Colors.black),
                  ),
                ),
                results.isEmpty
                    ? Text(
                        'No Podcasts to show.',
                        style: TextStyle(
                          fontFamily: "Raleway",
                        ),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: ListView.builder(
                            itemCount: results.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                dense: false,
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MusicPage(results[index]))),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(results[index]
                                          ['thumbnail'] ??
                                      'https://i.picsum.photos/id/605/50/50.jpg?blur=5&hmac=ECBIpAv8BZAqhFEisCS-fxNojk0Xegm3vRx_-4ctkfQ'),
                                ),
                                title: Text(
                                  results[index]['name'],
                                  style: TextStyle(fontFamily: "Raleway"),
                                ),
                                trailing: Icon(Icons.arrow_forward),
                              );
                            }),
                      )
              ],
            )),
      ),
    );
  }
}
