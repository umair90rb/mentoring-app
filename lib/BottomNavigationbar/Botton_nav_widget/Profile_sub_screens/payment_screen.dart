import 'package:flutter/material.dart';

import 'History_screen.dart';
import 'card_detials.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({Key key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Payment Page",
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
                                Icons.card_giftcard,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          title: Text(
                            'Card Detials',
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CradDetials()),
                            );
                          },
                        ),
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
                                Icons.history,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          title: Text(
                            'History',
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HistoryScreen()),
                            );
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
