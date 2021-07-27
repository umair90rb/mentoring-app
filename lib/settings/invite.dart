import 'package:brain_store/BottomNavigationbar/Botton_nav_widget/profile.dart';
import 'package:brain_store/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Invitefriends extends StatelessWidget {
  String text = 'https://www.comrade.com/';
  String subject = 'Join Comrade';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => BottomProfile()));
        //   },
        //   icon: Icon(
        //     Icons.arrow_back_ios,
        //     color: Colors.black,
        //   ),
        // ),
        centerTitle: true,
        title: Text(
          "Invite Friends",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Raleway",
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(),
                child: Container(
                  height: 5,
                  color: Color(0xFF1A3A77),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Center(
                  child: Container(
                    child: Text(
                      getTranslated(context, 'shareHeading'),
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A3A77)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Center(
                  child: Container(
                    child: Text(
                      getTranslated(context, 'shareBody'),
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Raleway",
                          // fontWeight: FontWeight.bold,
                          color: Color(0xFF1A3A77)),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 5,
              // ),
              Container(
                height: 300,
                child: Center(
                  child: Image.asset(
                    "assets/images/logocomrade.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // SizedBox(
              //   height: 5,
              // ),
              Padding(
                padding: EdgeInsets.only(),
                child: Center(
                  child: Container(
                    child: Text(
                      getTranslated(context, 'sendInvite'),
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF1A3A77),
                        fontFamily: "Raleway",
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 5,
              // ),
              Padding(
                padding: EdgeInsets.only(),
                // child: Center(
                child: Container(
                  height: 100,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          elevation: 0.0,
                          color: Colors.white,
                          shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(50))),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.message,
                                  color: Color(0xFF1A3A77),
                                  size: 30.0,
                                ),
                                Text(
                                  getTranslated(context, 'text'),
                                  style: TextStyle(
                                    fontFamily: "Raleway",
                                    color: Color(0xFF1A3A77),
                                  ),
                                )
                              ],
                            ),
                          ),
                          onPressed: _launchURL,
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          elevation: 0.0,
                          color: Colors.white,
                          shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(50))),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.share,
                                  color: Color(0xFF1A3A77),
                                  size: 30.0,
                                ),
                                Text(
                                  getTranslated(context, 'share'),
                                  style: TextStyle(
                                    fontFamily: "Raleway",
                                    color: Color(0xFF1A3A77),
                                  ),
                                )
                              ],
                            ),
                          ),
                          onPressed: () {
                            final RenderBox box = context.findRenderObject();
                            Share.share(text,
                                subject: subject,
                                sharePositionOrigin:
                                    box.localToGlobal(Offset.zero) & box.size);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(),
                child: Center(
                  child: Text(
                    getTranslated(context, 'copyLink'),
                    style: TextStyle(
                      color: Color(0xFF1A3A77),
                      fontSize: 17,
                      fontFamily: "Raleway",
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(),
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    selectedTileColor: Colors.white,
                    tileColor: Colors.white,
                    title: Text(
                      'https://www.comrade.com/',
                      style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                      // textScaleFactor: 1.5,
                    ),
                    trailing: Text(
                      getTranslated(context, 'copy'),
                      style: TextStyle(
                          fontFamily: "Raleway",
                          color: Color(0xFF1A3A77),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    onTap: () {
                      Clipboard.setData(new ClipboardData(text: text));
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text(
                        "Link Copied to Clipboard",
                        style: TextStyle(
                          fontFamily: "Raleway",
                        ),
                      )));
                    },
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

_launchURL() async {
  const uri = 'sms:?body=Join Comrade';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    // iOS
    const uri = 'sms:?body=Join Comrade';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
