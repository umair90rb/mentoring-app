import 'package:brain_store/services/payment_service.dart';
import 'package:flutter/material.dart';
import 'package:brain_store/custom_package.dart';
import 'package:brain_store/models/package.dart';
import 'package:brain_store/services/db_services.dart';
import 'package:brain_store/square/transaction_service.dart';
import 'package:brain_store/utils/call_utilites.dart';
import 'package:brain_store/utils/permissions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
// import 'package:square_in_app_payments/in_app_payments.dart';
// import 'package:square_in_app_payments/models.dart';

import 'chat/chat.dart';
import './callscreen.dart';

class PackageScreen extends StatefulWidget {
  List category;
  DocumentSnapshot podcaster;
  User user;
  String option;

  PackageScreen(
      {@required this.podcaster, @required this.user, @required this.option, this.category});

  @override
  _PackageScreenState createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  ProgressDialog dialog;
  DbServices db = DbServices();

  @override
  void initState() {
    super.initState();
    dialog = ProgressDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Packages",
          style: TextStyle(color: Colors.black, fontFamily: "Raleway"),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(),
                child: Container(
                  height: 5,
                  color: Color(0xFF1A3A77),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    "Select package of your choice to prevent your session from ending when you run out of minutes",
                    style: TextStyle(fontFamily: "Raleway", fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 100),
                      child: Text(
                        "Try the",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Pay as you go",
                      style: TextStyle(
                          color: Color(0xFF1A3A77),
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "plan",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Color(0xFF1A3A77),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(),
                    child: Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => buySubscription(
                              widget.user, widget.podcaster, 'custom'),
                          child: Container(
                            width: 150,
                            height: 100,
                            // color: Colors.yellow,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black12,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(08))),
                            child: Center(
                              child: Text(
                                "\$ 1",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => buySubscription(
                              widget.user, widget.podcaster, 'custom'),
                          child: Container(
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black12,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(08))),
                            child: Center(
                              child: Text(
                                "\n\n\nPer Minute",
                                style: TextStyle(
                                    color: Colors.black, fontFamily: "Raleway"),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => buySubscription(
                              widget.user, widget.podcaster, 'custom'),
                          child: Container(
                            width: 150,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                border: Border.all(color: Colors.black12),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0))),
                            child: Center(
                              child: Text(
                                "Buy",
                                style: TextStyle(
                                    color: Colors.black, fontFamily: "Raleway"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(),
                    child: Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => buySubscription(
                              widget.user, widget.podcaster, 'custom'),
                          child: Container(
                            width: 150,
                            height: 100,
                            // color: Colors.yellow,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFF1A3A77),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(08))),
                            child: Center(
                              child: Text(
                                "\$ 2",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => buySubscription(
                              widget.user, widget.podcaster, 'custom'),
                          child: Container(
                            width: 150,
                            height: 100,
                            // color: Colors.yellow,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xFF1A3A77), width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(08))),
                            child: Center(
                              child: Text(
                                "\n\n\nPer Minute",
                                style: TextStyle(
                                    color: Colors.black, fontFamily: "Raleway"),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => buySubscription(
                              widget.user, widget.podcaster, 'custom'),
                          child: Container(
                            width: 150,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Color(0xFF1A3A77),
                                border: Border.all(
                                  color: Color(0xFF1A3A77),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0))),
                            child: Center(
                              child: Text(
                                "Buy",
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "Raleway"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  "OR",
                  style: TextStyle(
                      color: Color(0xFF1A3A77),
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 75),
                      child: Text(
                        "Purchase our",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Monthly",
                      style: TextStyle(
                          color: Color(0xFF1A3A77),
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Package",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Color(0xFF1A3A77),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(),
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => buySubscription(
                          widget.user, widget.podcaster, 'monthly'),
                      child: Container(
                        width: 150,
                        height: 100,
                        // color: Colors.yellow,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF1A3A77),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(08))),
                        child: Center(
                          child: Text(
                            "\$ 699",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => buySubscription(
                          widget.user, widget.podcaster, 'monthly'),
                      child: Container(
                        width: 150,
                        height: 100,
                        // color: Colors.yellow,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xFF1A3A77), width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(08))),
                        child: Center(
                          child: Text(
                            "\n\n\n1000 Minutes",
                            style: TextStyle(
                                color: Colors.black, fontFamily: "Raleway"),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => buySubscription(
                          widget.user, widget.podcaster, 'monthly'),
                      child: Container(
                        width: 150,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Color(0xFF1A3A77),
                            border: Border.all(
                              color: Color(0xFF1A3A77),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(0))),
                        child: Center(
                          child: Text(
                            "Buy",
                            style: TextStyle(
                                color: Colors.white, fontFamily: "Raleway"),
                          ),
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

  Future buySubscription(
      User user, DocumentSnapshot podcaster, String package) async {
    if (package == 'monthly') {
      int talkTime = 1000;
      int amount = 69900;
      StripeService.init();
      ProgressDialog dialog = ProgressDialog(context);
      dialog.style(
          message: 'Please wait...',
          progressTextStyle: TextStyle(fontFamily: "Raleway"));

      dynamic result = await StripeService.payWithNewCard(
          amount: "69900", currency: 'usd', dialog: dialog);
      print(result.success);
      if (!result.success)
        return Fluttertoast.showToast(msg: 'Payment failed!');

      db.addData('transaction', {
        'amount': (amount / 100),
        'at': Timestamp.now(),
        'by': user.uid,
        'to': podcaster.id
      }).then((value) {
        db.updateDoc('profile', user.uid, {
          'talkTime': talkTime,
          'packageBoughtAt': Timestamp.now(),
          'package': package
        }).then((value) async {
          if (widget.option == 'call') {
            // Permissions.cameraAndMicrophonePermissionsGranted()
            //     .then((value) async {
            //   if (!value) {
            //     await dialog.hide();
            //     ScaffoldState()
            //         .hideCurrentSnackBar(reason: SnackBarClosedReason.hide);
            //     ScaffoldState().showSnackBar(SnackBar(
            //         content: Text(
            //       'Something goes wrong!',
            //       style: TextStyle(
            //         fontFamily: "Raleway",
            //       ),
            //     )));
            //   }
            //   await dialog.hide();
            //   return CallUtils.dial(
            //       currUserId: user.uid,
            //       currUserName:
            //           user.displayName == null ? '' : user.displayName,
            //       currUserAvatar: user.photoURL == null ? '' : user.photoURL,
            //       receiverId: podcaster.id,
            //       receiverAvatar: '',
            //       // podcaster.data().containsKey('photoURL')
            //       //     ? ''
            //       //     : podcaster['photoURL'],
            //       receiverName: podcaster.data().containsKey('name')
            //           ? ''
            //           : podcaster['email'],
            //       context: context);
            // });
          } else {
            await dialog.hide();
            return Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Chat(
                      id: user.uid, peerId: podcaster.id, talkTime: talkTime),
                ));
          }
        });
      });

      // return await InAppPayments.startCardEntryFlow(
      //     onCardNonceRequestSuccess: (card) =>
      //         _onCardEntryCardNonceRequestSuccess(
      //             card, (69900), user, podcaster, 1000, 'monthly'),
      //     onCardEntryCancel: _onCancelCardEntryFlow,
      //     collectPostalCode: false);
    } else if (package == 'custom') {
      // Package p = await Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => CustomPackage()),
      // );
      // print(p.amount);
      // print(p.talkTime);
      // int talkTime = p.talkTime;
      int talkTime = 20;
      int amount;
      switch(widget.category[0]){
        case "Relationship":
          amount = 20;
          break;
        case "Travel":
          amount = 20;
          break;
        case "Beauty":
          amount = 20;
          break;
        case "Emotional":
          amount = 20;
          break;
        default:
          amount = 40;
          break;
      }
      amount = amount*100;
      StripeService.init();
      ProgressDialog dialog = ProgressDialog(context);
      dialog.style(
          message: 'Please wait...',
          progressTextStyle: TextStyle(fontFamily: "Raleway"));

      dynamic result = await StripeService.payWithNewCard(
          amount: amount.toString(), currency: 'usd', dialog: dialog);
      print(result.success);
      if (!result.success)
        return Fluttertoast.showToast(msg: 'Payment failed!');
      db.addData('transaction', {
        'amount': (amount / 100),
        'at': Timestamp.now(),
        'by': user.uid,
        'to': podcaster.id
      }).then((value) {
        db.updateDoc('profile', user.uid, {
          'talkTime': talkTime,
          'packageBoughtAt': Timestamp.now(),
          'package': package
        }).then((value) async {
          if (widget.option == 'call') {
            Permissions.cameraAndMicrophonePermissionsGranted()
                .then((value) async {
              if (!value) {
                await dialog.hide();
                ScaffoldState()
                    .hideCurrentSnackBar(reason: SnackBarClosedReason.hide);
                ScaffoldState().showSnackBar(SnackBar(
                    content: Text(
                  'Permission denied!',
                  style: TextStyle(
                    fontFamily: "Raleway",
                  ),
                ),),);
              }
              await dialog.hide();
              return Navigator.push(context, MaterialPageRoute(builder: (_) => CallScreen(talkTime, user.uid, podcaster.id, user.email, podcaster['email'])));
            });
          } else {
            await dialog.hide();
            return Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Chat(
                      id: user.uid, peerId: podcaster.id, talkTime: talkTime),
                ));
          }
        });
      });
      // return await InAppPayments.startCardEntryFlow(
      //     onCardNonceRequestSuccess: (card) =>
      //         _onCardEntryCardNonceRequestSuccess(card, (package.amount), user,
      //             podcaster, package.talkTime, 'custom'),
      //     onCardEntryCancel: _onCancelCardEntryFlow,
      //     collectPostalCode: false);
    }
  }

  // void _onCardEntryCardNonceRequestSuccess(
  //     CardDetails result,
  //     amount,
  //     User user,
  //     DocumentSnapshot podcaster,
  //     int talkTime,
  //     String package) async {
  //   try {
  //     await chargeCard(result, amount);
  //     InAppPayments.completeCardEntry(
  //         onCardEntryComplete: () =>
  //             _onCardEntryComplete(user, podcaster, amount, talkTime, package));
  //   } on ChargeException catch (ex) {
  //     InAppPayments.showCardNonceProcessingError(ex.errorMessage);
  //   }
  // }

  // void _onCardEntryComplete(User user, DocumentSnapshot podcaster,
  //     dynamic amount, int talkTime, String package) async {
  //   dialog.style(
  //       message: 'Please wait...',
  //       progressTextStyle: TextStyle(fontFamily: "Raleway"));
  //   await dialog.show();
  //   db.addData('transaction', {
  //     'amount': (amount / 100),
  //     'at': Timestamp.now(),
  //     'by': user.uid,
  //     'to': podcaster.id
  //   }).then((value) {
  //     db.updateDoc('profile', user.uid, {
  //       'talkTime': talkTime,
  //       'packageBoughtAt': Timestamp.now(),
  //       'package': package
  //     }).then((value) async {
  //       if (widget.option == 'call') {
  //         Permissions.cameraAndMicrophonePermissionsGranted()
  //             .then((value) async {
  //           if (!value) {
  //             await dialog.hide();
  //             ScaffoldState()
  //                 .hideCurrentSnackBar(reason: SnackBarClosedReason.hide);
  //             ScaffoldState().showSnackBar(SnackBar(
  //                 content: Text(
  //               'Something goes wrong!',
  //               style: TextStyle(
  //                 fontFamily: "Raleway",
  //               ),
  //             )));
  //           }
  //           await dialog.hide();
  //           return CallUtils.dial(
  //               currUserId: user.uid,
  //               currUserName: user.displayName == null ? '' : user.displayName,
  //               currUserAvatar: user.photoURL == null ? '' : user.photoURL,
  //               receiverId: podcaster.id,
  //               receiverAvatar: podcaster.data().containsKey('photoURL')
  //                   ? ''
  //                   : podcaster['photoURL'],
  //               receiverName: podcaster.data().containsKey('name')
  //                   ? ''
  //                   : podcaster['email'],
  //               context: context);
  //         });
  //       } else {
  //         await dialog.hide();
  //         return Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => Chat(
  //                   id: user.uid, peerId: podcaster.id, talkTime: talkTime),
  //             ));
  //       }
  //     });
  //   });
  // }

  // void _onCancelCardEntryFlow() {
  //   print('something goes wrong!');
  // }
}
