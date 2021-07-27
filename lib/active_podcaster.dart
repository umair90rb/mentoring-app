import 'dart:async';

import 'package:brain_store/callscreen.dart';
import 'package:brain_store/chat/chat.dart';
import 'package:brain_store/package_screen.dart';
import 'package:brain_store/podcaster_profile.dart';
import 'package:brain_store/profile/pubprofile.dart';
import 'package:brain_store/services/db_services.dart';
import 'package:brain_store/services/online_service.dart';
import 'package:brain_store/utils/call_utilites.dart';
import 'package:brain_store/utils/permissions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:square_in_app_payments/models.dart';
// import 'package:square_in_app_payments/in_app_payments.dart';
import './square/transaction_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class ActivePodcaster extends StatefulWidget {
  List<dynamic> category;

  ActivePodcaster(this.category);

  @override
  _ActivePodcasterState createState() => _ActivePodcasterState();
}

class _ActivePodcasterState extends State<ActivePodcaster> {
  DbServices db = DbServices();
  OnlineService o = OnlineService();
  ProgressDialog dialog;
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    dialog = ProgressDialog(context);
    dialog.style(
        message: 'Please wait...',
        progressTextStyle: TextStyle(
          fontFamily: "Raleway",
        ));
    super.initState();
  }
  // FirebaseFirestore fire = FirebaseFirestore.instance;
  // CollectionReference r = fire.collection('profile');
  // Query query = col.where('uid', isEqualTo: stuff.uid);
  //

  StreamSubscription requestStream;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    print(widget.category);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          title: Text(
            "Mentors",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Raleway",
            ),
          ),
        ),
        key: _scaffoldState,
        body: FutureBuilder(
          future: o.getOnlinePodcaster(widget.category),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isEmpty) {
                return Center(
                  child: Text(
                    'There is no Mentor Online!',
                    style: TextStyle(
                      fontFamily: "Raleway",
                    ),
                  ),
                );
              }
              return Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        // if (!widget.category
                        //     .contains(snapshot.data[index]['experties'])) {
                        return podcasterTile(
                            snapshot.data[index], user, context);
                        // }
                      }),
                ],
              );
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text(
                '${snapshot.error.toString()}',
                style: TextStyle(
                  fontFamily: "Raleway",
                ),
              ));
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  // void _onCardEntryCardNonceRequestSuccess(
  //     CardDetails result, amount, User user, DocumentSnapshot podcaster) async {
  //   try {
  //     await chargeCard(result, amount);
  //     InAppPayments.completeCardEntry(
  //         onCardEntryComplete: () =>
  //             _onCardEntryComplete(user, podcaster, amount));
  //   } on ChargeException catch (ex) {
  //     InAppPayments.showCardNonceProcessingError(ex.errorMessage);
  //   }
  // }

  // void _onCardEntryComplete(
  //     User user, DocumentSnapshot podcaster, dynamic amount) async {
  //   print('amount charged');
  //   dialog.style(message: 'Connecting...');
  //   await dialog.show();
  //   db.addData('transaction', {
  //     'amount': (amount / 100),
  //     'at': Timestamp.now(),
  //     'by': user.uid,
  //     'to': podcaster.id
  //   }).then((value) {
  //     print('here');
  //     Permissions.cameraAndMicrophonePermissionsGranted().then((value) async {
  //       if (!value) {
  //         await dialog.hide();
  //         _scaffoldState.currentState
  //             .hideCurrentSnackBar(reason: SnackBarClosedReason.hide);
  //         _scaffoldState.currentState.showSnackBar(SnackBar(
  //             content: Text(
  //           'Something goes wrong!',
  //           style: TextStyle(
  //             fontFamily: "Raleway",
  //           ),
  //         )));
  //       }
  //       await dialog.hide();
  //       return CallUtils.dial(
  //           currUserId: user.uid,
  //           currUserName: user.displayName == null ? '' : user.displayName,
  //           currUserAvatar: user.photoURL == null ? '' : user.photoURL,
  //           receiverId: podcaster.id,
  //           receiverAvatar: podcaster.data().containsKey('photoURL')
  //               ? ''
  //               : podcaster['photoURL'],
  //           receiverName:
  //               podcaster.data().containsKey('name') ? '' : podcaster['email'],
  //           context: context);
  //     });
  //   });
  // }

  // void _onCancelCardEntryFlow() {
  //   print('something goes wrong!');
  // }

  Widget podcasterTile(DocumentSnapshot podcaster, User user, context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          color: Colors.white,
          child: ListTile(
            leading: Stack(children: [
              Icon(FontAwesomeIcons.userCircle, size: 50, color: Colors.black),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Icon(Icons.circle, size: 15, color: Colors.green))
            ]),
            title: Text(podcaster.data().containsKey('name')
                ? podcaster['name']
                : podcaster['email']),
            subtitle: Text(podcaster['experties']),
            trailing: Icon(
              Icons.arrow_back_ios,
              size: 30,
              color: Color(0xFF1C3B77),
            ),
          ),
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Calling Session',
            color: Color(0xFF1C3B77),
            icon: Icons.call,
            foregroundColor: Colors.white,
            onTap: () async {
              DocumentSnapshot doc = await db.getDoc('profile', user.uid);
              if (doc.data().containsKey('talkTime') && doc['talkTime'] > 0) {
                print(doc.data().containsKey('talkTime'));
                Permissions.cameraAndMicrophonePermissionsGranted()
                    .then((value) async {
                  if (!value) {
                    await dialog.hide();
                    _scaffoldState.currentState
                        .hideCurrentSnackBar(reason: SnackBarClosedReason.hide);
                    _scaffoldState.currentState.showSnackBar(SnackBar(
                        content: Text(
                      'Something goes wrong!',
                      style: TextStyle(
                        fontFamily: "Raleway",
                      ),
                    )));
                  }
                  await dialog.hide();
                  return Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CallScreen(doc['talkTime'], user.uid,
                              podcaster.id, user.email, podcaster['email'])));
                  // return CallUtils.dial(
                  //     currUserId: user.uid,
                  //     currUserName:
                  //         user.displayName == null ? '' : user.displayName,
                  //     currUserAvatar:
                  //         user.photoURL == null ? '' : user.photoURL,
                  //     receiverId: podcaster.id,
                  //     receiverAvatar: '',
                  //     // podcaster.data().containsKey('photoURL')
                  //     //     ? ''
                  //     //     : podcaster['photoURL'],
                  //     receiverName: podcaster.data().containsKey('name')
                  //         ? ''
                  //         : podcaster['email'],
                  //     context: context);
                });
              } else {
                return Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PackageScreen(
                        podcaster: podcaster,
                        user: user,
                        option: 'call',
                        category: widget.category),
                  ),
                );
              }
              // return InAppPayments.startCardEntryFlow(
              //         onCardNonceRequestSuccess: (card) =>
              //             _onCardEntryCardNonceRequestSuccess(
              //                 card,
              //                 (int.parse(podcaster['charges']) * 100),
              //                 user,
              //                 podcaster),
              //         onCardEntryCancel: _onCancelCardEntryFlow,
              //         collectPostalCode: false)
              //     .then((value) {});
            },
          ),
          IconSlideAction(
              caption: 'Chatting Session',
              color: Color(0xFF1C3B77),
              icon: Icons.message,
              foregroundColor: Colors.white,
              onTap: () async {
                ProgressDialog pr = ProgressDialog(context);
                pr.style(message: 'Please wait your request sent to mentor.');
                await pr.show();
                DocumentSnapshot doc = await db.getDoc('profile', user.uid);
                if (doc.data().containsKey('talkTime') && doc['talkTime'] > 0) {
                  return FirebaseFirestore.instance
                      .collection('msgRequest')
                      .add({
                    'to': podcaster.id,
                    'from': user.uid,
                    'status': 'pending',
                    'read': false,
                    'at': Timestamp.now(),
                    'email': user.email,
                  }).then((value) {
                    print("doc id ${value.id}, doc path ${value.path}");
                    requestStream = FirebaseFirestore.instance
                        .collection('msgRequest')
                        .doc(value.id)
                        .snapshots()
                        .listen((snapshot) async {
                      if (snapshot != null &&
                          snapshot.data()['status'] == 'accepted') {
                        await pr.hide();
                        requestStream.cancel();
                        return Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Chat(
                                id: user.uid,
                                peerId: podcaster.id,
                                talkTime: doc['talkTime']),
                          ),
                        );
                      } else if (snapshot != null &&
                          snapshot.data()['status'] == 'rejected') {
                        await pr.hide();
                        requestStream.cancel();
                        return Fluttertoast.showToast(
                            msg: 'Your request Rejected!');
                      }
                    }, cancelOnError: true);
                  });
                }
                await pr.hide();
                return Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PackageScreen(
                      podcaster: podcaster,
                      user: user,
                      option: 'chat',
                    ),
                  ),
                );
              }),
          IconSlideAction(
            caption: 'Review Profile',
            color: Color(0xFF1C3B77),
            icon: Icons.contact_page_rounded,
            foregroundColor: Colors.white,
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => Pubprofile(podcaster))),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    requestStream.cancel();
    super.dispose();
  }
}
