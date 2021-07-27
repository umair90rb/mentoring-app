import 'package:flutter/material.dart';

class SettingProfile extends StatefulWidget {
  SettingProfile({Key key}) : super(key: key);

  @override
  _SettingProfileState createState() => _SettingProfileState();
}

class _SettingProfileState extends State<SettingProfile> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Profile Setting",
          style: TextStyle(
            fontFamily: "Raleway",
            color: Colors.blue,
            fontSize: 28.0,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                child: Image.asset(
                  "assets/images/silverappbarr.png",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 12, right: 12),
                      child: Card(
                        elevation: 1.5,
                        child: ListTile(
                            selectedTileColor: Colors.white,
                            tileColor: Colors.white,
                            leading: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                            title: Text(
                              'Update Profile Image',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              // textScaleFactor: 1.5,
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blue,
                            ),
                            onTap: () {}),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12, right: 12),
                      child: Card(
                        elevation: 1.5,
                        child: ListTile(
                          selectedTileColor: Colors.white,
                          tileColor: Colors.white,
                          leading: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.person_add_alt_1,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          title: Text(
                            'Update Profile',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            // textScaleFactor: 1.5,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blue,
                          ),
                          onTap: () {
                            //   Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => PaymentScreen()),
                            // );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
