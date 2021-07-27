import 'package:brain_store/active_podcaster.dart';
import 'package:brain_store/localization/language_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selectable_container/selectable_container.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dynamic selected = [];
  bool relationship = false;
  bool nutrition = false;
  bool beauty = false;
  bool career = false;
  bool work = false;
  bool entrepreneurship = false;
  bool travel = false;
  bool investment = false;
  bool legal = false;
  bool emotional = false;
  bool limit = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Container(
          child: SingleChildScrollView(
            child: Column(children: [
              Column(
                children: [
                  Stack(children: <Widget>[
                    Image.asset(
                      "assets/images/splashscreen.jpg",
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 12, top: 80),
                        child: Text(
                          getTranslated(context, 'yourGoal'),
                          style: TextStyle(
                            color: Color.fromRGBO(22, 49, 78, 1),
                            fontSize: 35,
                            fontFamily: "Raleway",
                          ),
                        )),
                    Container(
                        padding: EdgeInsets.only(left: 12, top: 130),
                        child: Text(
                          getTranslated(context, 'easyToDevelop'),
                          style: TextStyle(
                            color: Color.fromRGBO(22, 49, 78, 1),
                            fontSize: 20,
                            fontFamily: "Raleway",
                          ),
                        )),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SelectableContainer(
                        onValueChanged: (value) {
                          if (limit && !relationship)
                            return Fluttertoast.showToast(
                                msg: "Only one category allowed!");
                          setState(() {
                            limit = !limit;
                            relationship = !relationship;
                          });
                        },
                        selectedBorderColor: Colors.orange,
                        selectedBackgroundColor: Colors.transparent,
                        unselectedBorderColor: Colors.transparent,
                        unselectedBackgroundColor: Colors.transparent,
                        iconAlignment: Alignment.topRight,
                        icon: Icons.check,
                        iconSize: 20,
                        unselectedOpacity: 0.9,
                        selected: relationship,
                        child: Container(
                          height: size.height * 0.30,
                          width: size.width * 0.38,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/Relationship.jpeg",
                                  // scale: 4,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  getTranslated(context, 'relationship'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: "Raleway",
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (limit && !relationship)
                            return Fluttertoast.showToast(
                                msg: "Only one category allowed!");
                          setState(() {
                            limit = !limit;
                            relationship = !relationship;
                          });
                        },
                      ),
                      SelectableContainer(
                        onValueChanged: (value) {
                          if (limit && !nutrition)
                            return Fluttertoast.showToast(
                                msg: "Only one category allowed!");
                          setState(() {
                            limit = !limit;
                            nutrition = !nutrition;
                          });
                        },
                        selectedBorderColor: Colors.orange,
                        selectedBackgroundColor: Colors.transparent,
                        unselectedBorderColor: Colors.transparent,
                        unselectedBackgroundColor: Colors.transparent,
                        iconAlignment: Alignment.topRight,
                        icon: Icons.check,
                        iconSize: 20,
                        unselectedOpacity: 0.9,
                        selected: nutrition,
                        child: Container(
                          height: size.height * 0.30,
                          width: size.width * 0.38,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/Health & Nutrition.jpeg",
                                  // scale: 20,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  getTranslated(context, 'nutrition'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: "Raleway",
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (limit && !nutrition)
                            return Fluttertoast.showToast(
                                msg: "Only one category allowed!");
                          setState(() {
                            limit = !limit;
                            nutrition = !nutrition;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SelectableContainer(
                        onValueChanged: (value) {
                          if (limit && !beauty)
                            return Fluttertoast.showToast(
                                msg: "Only one category allowed!");
                          setState(() {
                            limit = !limit;
                            beauty = !beauty;
                          });
                        },
                        selectedBorderColor: Colors.orange,
                        selectedBackgroundColor: Colors.transparent,
                        unselectedBorderColor: Colors.transparent,
                        unselectedBackgroundColor: Colors.transparent,
                        iconAlignment: Alignment.topRight,
                        icon: Icons.check,
                        iconSize: 20,
                        unselectedOpacity: 0.9,
                        selected: beauty,
                        child: Container(
                          height: size.height * 0.30,
                          width: size.width * 0.38,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/Beauty.jpeg",
                                  // scale: 20,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  getTranslated(context, 'beauty'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: "Raleway",
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (limit && !beauty)
                            return Fluttertoast.showToast(
                                msg: "Only one category allowed!");
                          setState(() {
                            limit = !limit;
                            beauty = !beauty;
                          });
                        },
                      ),
                      SelectableContainer(
                        onValueChanged: (vlaue) {
                          if (limit && !career)
                            return Fluttertoast.showToast(
                                msg: "Only one category allowed!");
                          setState(() {
                            limit = !limit;
                            career = !career;
                          });
                        },
                        selectedBorderColor: Colors.orange,
                        selectedBackgroundColor: Colors.transparent,
                        unselectedBorderColor: Colors.transparent,
                        unselectedBackgroundColor: Colors.transparent,
                        iconAlignment: Alignment.topRight,
                        icon: Icons.check,
                        iconSize: 20,
                        unselectedOpacity: 0.9,
                        selected: career,
                        child: Container(
                          height: size.height * 0.30,
                          width: size.width * 0.38,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/Career.jpeg",
                                  // scale: 20,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  getTranslated(context, 'career'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: "Raleway",
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (limit && !career)
                            return Fluttertoast.showToast(
                                msg: "Only one category allowed!");
                          setState(() {
                            limit = !limit;
                            career = !career;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SelectableContainer(
                        onValueChanged: (value) {
                          if (limit && !work)
                            return Fluttertoast.showToast(
                                msg: "Only one category allowed!");
                          setState(() {
                            limit = !limit;
                            work = !work;
                          });
                        },
                        selectedBorderColor: Colors.orange,
                        selectedBackgroundColor: Colors.transparent,
                        unselectedBorderColor: Colors.transparent,
                        unselectedBackgroundColor: Colors.transparent,
                        iconAlignment: Alignment.topRight,
                        icon: Icons.check,
                        iconSize: 20,
                        unselectedOpacity: 0.9,
                        selected: work,
                        child: Container(
                          height: size.height * 0.30,
                          width: size.width * 0.38,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/Work and Profession.jpeg",
                                  // scale: 20,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  getTranslated(context, 'work'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Raleway",
                                    fontSize: 16,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (limit && !work)
                            return Fluttertoast.showToast(
                                msg: "Only one category allowed!");
                          setState(() {
                            limit = !limit;
                            work = !work;
                          });
                        },
                      ),
                      SelectableContainer(
                        onValueChanged: (value) {
                          if (limit && !entrepreneurship)
                            return Fluttertoast.showToast(
                                msg: "Only one category allowed!");
                          setState(() {
                            limit = !limit;
                            entrepreneurship = !entrepreneurship;
                          });
                        },
                        selectedBorderColor: Colors.orange,
                        selectedBackgroundColor: Colors.transparent,
                        unselectedBorderColor: Colors.transparent,
                        unselectedBackgroundColor: Colors.transparent,
                        iconAlignment: Alignment.topRight,
                        icon: Icons.check,
                        iconSize: 20,
                        unselectedOpacity: 0.9,
                        selected: entrepreneurship,
                        child: Container(
                          height: size.height * 0.31,
                          width: size.width * 0.38,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/Entreprenuership.jpeg",
                                  scale: 10,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  getTranslated(context, 'entrepreneurship'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: "Raleway",
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (limit && !entrepreneurship)
                            return Fluttertoast.showToast(
                                msg: "Only one category allowed!");
                          setState(() {
                            limit = !limit;
                            entrepreneurship = !entrepreneurship;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SelectableContainer(
                        onValueChanged: (value) {
                          if (limit && !travel)
                            return Fluttertoast.showToast(
                                msg: "Only one category allowed!");
                          setState(() {
                            limit = !limit;
                            travel = !travel;
                          });
                        },
                        selectedBorderColor: Colors.orange,
                        selectedBackgroundColor: Colors.transparent,
                        unselectedBorderColor: Colors.transparent,
                        unselectedBackgroundColor: Colors.transparent,
                        iconAlignment: Alignment.topRight,
                        icon: Icons.check,
                        iconSize: 20,
                        unselectedOpacity: 0.9,
                        selected: travel,
                        child: Container(
                          height: size.height * 0.30,
                          width: size.width * 0.38,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/Travel.jpeg",
                                  // scale: 20,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  getTranslated(context, 'travel'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: "Raleway",
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (limit && !travel)
                            return Fluttertoast.showToast(
                                msg: "Only one category allowed!");
                          setState(() {
                            limit = !limit;
                            travel = !travel;
                          });
                        },
                      ),
                      SelectableContainer(
                        onValueChanged: (value) {
                          if (limit && !investment)
                            return Fluttertoast.showToast(
                                msg: "Only one category allowed!");
                          setState(() {
                            limit = !limit;
                            investment = !investment;
                          });
                        },
                        selectedBorderColor: Colors.orange,
                        selectedBackgroundColor: Colors.transparent,
                        unselectedBorderColor: Colors.transparent,
                        unselectedBackgroundColor: Colors.transparent,
                        iconAlignment: Alignment.topRight,
                        icon: Icons.check,
                        iconSize: 20,
                        unselectedOpacity: 0.9,
                        selected: investment,
                        child: Container(
                          height: size.height * 0.30,
                          width: size.width * 0.38,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/Finance & Investment.jpeg",
                                  // scale: 20,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  getTranslated(context, 'investment'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Raleway",
                                    color: Colors.black,
                                    fontSize: 16,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (limit && !investment)
                            return Fluttertoast.showToast(
                                msg: "Only one category allowed!");
                          setState(() {
                            limit = !limit;
                            investment = !investment;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SelectableContainer(
                        onValueChanged: (value) {
                          if (limit && !legal)
                            return Fluttertoast.showToast(
                                msg: "Only one category allowed!");
                          setState(() {
                            limit = !limit;
                            legal = !legal;
                          });
                        },
                        selectedBorderColor: Colors.orange,
                        selectedBackgroundColor: Colors.transparent,
                        unselectedBorderColor: Colors.transparent,
                        unselectedBackgroundColor: Colors.transparent,
                        iconAlignment: Alignment.topRight,
                        icon: Icons.check,
                        iconSize: 20,
                        unselectedOpacity: 0.9,
                        selected: legal,
                        child: Container(
                          height: size.height * 0.30,
                          width: size.width * 0.38,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/Legal.jpeg",
                                  // scale: 20,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  getTranslated(context, 'legal'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Raleway",
                                    fontSize: 16,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (limit && !legal)
                            return Fluttertoast.showToast(
                                msg: "Only one category allowed!");
                          setState(() {
                            limit = !limit;
                            legal = !legal;
                          });
                        },
                      ),
                      SelectableContainer(
                        onValueChanged: (value) {
                          if (limit && !emotional)
                            return Fluttertoast.showToast(
                                msg: "Only one category allowed!");
                          setState(() {
                            limit = !limit;
                            emotional = !emotional;
                          });
                        },
                        selectedBorderColor: Colors.orange,
                        selectedBackgroundColor: Colors.transparent,
                        unselectedBorderColor: Colors.transparent,
                        unselectedBackgroundColor: Colors.transparent,
                        iconAlignment: Alignment.topRight,
                        icon: Icons.check,
                        iconSize: 20,
                        unselectedOpacity: 0.9,
                        selected: emotional,
                        child: Container(
                          height: size.height * 0.30,
                          width: size.width * 0.38,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/Emotional.jpeg",
                                  // scale: 20,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  getTranslated(context, 'emotional'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    letterSpacing: 1,
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(getTranslated(context, 'ventOut')),
                              ],
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (limit && !emotional)
                            return Fluttertoast.showToast(
                                msg: "Only one category allowed!");
                          setState(() {
                            limit = !limit;
                            emotional = !emotional;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      selected.clear();
                      relationship ? selected.add("Relationship") : null;
                      nutrition ? selected.add("Nutrition") : null;
                      beauty ? selected.add("Beauty") : null;
                      career ? selected.add("Career & Education") : null;
                      work ? selected.add("Work") : null;
                      entrepreneurship
                          ? selected.add("Entrepreneurship")
                          : null;
                      travel ? selected.add("Travel") : null;
                      investment ? selected.add("Investment") : null;
                      legal ? selected.add("Legal") : null;
                      emotional ? selected.add("Emotional") : null;
                      if (selected.isEmpty)
                        return Fluttertoast.showToast(
                            msg: 'No category selected!');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ActivePodcaster(selected)));
                    },
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Color(0xFF1A3A77),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
