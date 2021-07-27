// import 'package:brain_store/custom_package.dart';
// import 'package:brain_store/models/package.dart';
// import 'package:brain_store/services/db_services.dart';
// import 'package:brain_store/square/transaction_service.dart';
// import 'package:brain_store/utils/call_utilites.dart';
// import 'package:brain_store/utils/permissions.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:progress_dialog/progress_dialog.dart';
// import 'package:square_in_app_payments/in_app_payments.dart';
// import 'package:square_in_app_payments/models.dart';

// import 'chat/chat.dart';

// class PackageScreen1 extends StatefulWidget {
//   DocumentSnapshot podcaster;
//   User user;
//   String option;

//   PackageScreen1(
//       {@required this.podcaster, @required this.user, @required this.option});

//   @override
//   _PackageScreen1State createState() => _PackageScreen1State();
// }

// class _PackageScreen1State extends State<PackageScreen1> {
//   ProgressDialog dialog;
//   DbServices db = DbServices();

//   @override
//   void initState() {
//     super.initState();
//     dialog = ProgressDialog(context);
//   }

//   Widget _packageCard(String title, String description, Function onPressed) {
//     return Material(
//       elevation: 5,
//       child: Container(
//         decoration: BoxDecoration(
//             // border: Border.all(),
//             borderRadius: BorderRadius.circular(10)),
//         margin: EdgeInsets.all(10),
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             children: [
//               Text(title,
//                   style: TextStyle(fontFamily: "Raleway", fontSize: 22)),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 description,
//                 style: TextStyle(fontFamily: "Raleway", fontSize: 16),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor:
//                         MaterialStateProperty.all(Color(0xFF1A385C)),
//                   ),
//                   onPressed: onPressed,
//                   child: Text(
//                     'Purchase',
//                     style: TextStyle(
//                       fontFamily: "Raleway",
//                     ),
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text(
//           'Packages',
//           style: TextStyle(fontFamily: "Raleway", color: Colors.black),
//         ),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           icon: Icon(Icons.arrow_back_ios, color: Colors.black),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             _packageCard(
//                 'Pay As You Go',
//                 """
// \$2 per minute for
// •	Legal
// •	Education and Profession
// •	Entrepreneurship
// •	Investment
// •	Health & Nutrition

// Note: Minimum call duration is 20 minutes.

// \$1 per minute for
// •	Relationships
// •	Vent out
// •	Travel
// •	Beauty

// Note: Minimum call duration is 20 minutes
//             """,
//                 () => buySubscription(widget.user, widget.podcaster, 'custom')),
//             _packageCard(
//                 'Monthly package',
//                 """
// One payment of \$699 will get the user 1000 minutes of talktime can be used across all categories. (must be used within a month no carry forward).
//             """,
//                 () =>
//                     buySubscription(widget.user, widget.podcaster, 'monthly')),
//           ],
//         ),
//       ),
//     );
//   }

//   Future buySubscription(
//       User user, DocumentSnapshot podcaster, String package) async {
//     if (package == 'monthly') {
//       return await InAppPayments.startCardEntryFlow(
//           onCardNonceRequestSuccess: (card) =>
//               _onCardEntryCardNonceRequestSuccess(
//                   card, (69900), user, podcaster, 1000, 'monthly'),
//           onCardEntryCancel: _onCancelCardEntryFlow,
//           collectPostalCode: false);
//     } else if (package == 'custom') {
//       Package package = await Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => CustomPackage()),
//       );
//       return await InAppPayments.startCardEntryFlow(
//           onCardNonceRequestSuccess: (card) =>
//               _onCardEntryCardNonceRequestSuccess(card, (package.amount), user,
//                   podcaster, package.talkTime, 'custom'),
//           onCardEntryCancel: _onCancelCardEntryFlow,
//           collectPostalCode: false);
//     }
//   }

//   void _onCardEntryCardNonceRequestSuccess(
//       CardDetails result,
//       amount,
//       User user,
//       DocumentSnapshot podcaster,
//       int talkTime,
//       String package) async {
//     try {
//       await chargeCard(result, amount);
//       InAppPayments.completeCardEntry(
//           onCardEntryComplete: () =>
//               _onCardEntryComplete(user, podcaster, amount, talkTime, package));
//     } on ChargeException catch (ex) {
//       InAppPayments.showCardNonceProcessingError(ex.errorMessage);
//     }
//   }

//   void _onCardEntryComplete(User user, DocumentSnapshot podcaster,
//       dynamic amount, int talkTime, String package) async {
//     dialog.style(
//         message: 'Please wait...',
//         progressTextStyle: TextStyle(fontFamily: "Raleway"));
//     await dialog.show();
//     db.addData('transaction', {
//       'amount': (amount / 100),
//       'at': Timestamp.now(),
//       'by': user.uid,
//       'to': podcaster.id
//     }).then((value) {
//       db.updateDoc('profile', user.uid, {
//         'talkTime': talkTime,
//         'packageBoughtAt': Timestamp.now(),
//         'package': package
//       }).then((value) async {
//         if (widget.option == 'call') {
//           Permissions.cameraAndMicrophonePermissionsGranted()
//               .then((value) async {
//             if (!value) {
//               await dialog.hide();
//               ScaffoldState()
//                   .hideCurrentSnackBar(reason: SnackBarClosedReason.hide);
//               ScaffoldState().showSnackBar(SnackBar(
//                   content: Text(
//                 'Something goes wrong!',
//                 style: TextStyle(
//                   fontFamily: "Raleway",
//                 ),
//               )));
//             }
//             await dialog.hide();
//             return CallUtils.dial(
//                 currUserId: user.uid,
//                 currUserName: user.displayName == null ? '' : user.displayName,
//                 currUserAvatar: user.photoURL == null ? '' : user.photoURL,
//                 receiverId: podcaster.id,
//                 receiverAvatar: podcaster.data().containsKey('photoURL')
//                     ? ''
//                     : podcaster['photoURL'],
//                 receiverName: podcaster.data().containsKey('name')
//                     ? ''
//                     : podcaster['email'],
//                 context: context);
//           });
//         } else {
//           await dialog.hide();
//           return Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => Chat(
//                     id: user.uid, peerId: podcaster.id, talkTime: talkTime),
//               ));
//         }
//       });
//     });
//   }

//   void _onCancelCardEntryFlow() {
//     print('something goes wrong!');
//   }
// }
