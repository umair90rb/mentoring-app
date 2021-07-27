import 'dart:async';

import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';
import '../models/call.dart';
import '../configs/configs.dart';
import '../models/log.dart';
import '../rating.dart';
import '../resources/call_methods.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallScreen extends StatefulWidget {
  final Call call;

  CallScreen({
    @required this.call,
  });

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final CallMethods callMethods = CallMethods();

  SharedPreferences preferences;
  StreamSubscription callStreamSubscription;

  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool hasUserJoined = false;
  int talkTime;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // addPostFrameCallback();
    initializeAgora();
    FirebaseFirestore.instance
        .collection('profile')
        .doc(widget.call.callerId)
        .get()
        .then((value) {
      if (value != null && value.data().containsKey('talkTime')) {
        setState(() {
          talkTime = value['talkTime'];
        });
      }
    });
  }

  Future<void> initializeAgora() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await AgoraRtcEngine.enableWebSdkInteroperability(true);
    await AgoraRtcEngine.setParameters(
        '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''');
    await AgoraRtcEngine.joinChannel(null, widget.call.channelId, null, 0);
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    await AgoraRtcEngine.create(APP_ID);
    await AgoraRtcEngine.disableVideo();
  }

  // Add agora event handlers
  void _addAgoraEventHandlers() {
    AgoraRtcEngine.onError = (dynamic code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onJoinChannelSuccess = (
      String channel,
      int uid,
      int elapsed,
    ) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      setState(() {
        hasUserJoined = true;
        final info = 'onUserJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
    };

    AgoraRtcEngine.onUpdatedUserInfo = (AgoraUserInfo userInfo, int i) {
      setState(() {
        final info = 'onUpdatedUserInfo: ${userInfo.toString()}';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onRejoinChannelSuccess = (String string, int a, int b) {
      setState(() {
        final info = 'onRejoinChannelSuccess: $string';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onUserOffline = (int a, int b) {
      callMethods.endCall(call: widget.call);
      setState(() {
        final info = 'onUserOffline: a: ${a.toString()}, b: ${b.toString()}';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onRegisteredLocalUser = (String s, int i) {
      setState(() {
        final info = 'onRegisteredLocalUser: string: s, i: ${i.toString()}';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onLeaveChannel = () {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    };

    AgoraRtcEngine.onConnectionLost = () {
      setState(() {
        final info = 'onConnectionLost';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      // if call was picked

      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
    };

    AgoraRtcEngine.onFirstRemoteVideoFrame = (
      int uid,
      int width,
      int height,
      int elapsed,
    ) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
    };
  }

  addPostFrameCallback() async {
    preferences = await SharedPreferences.getInstance();
    callStreamSubscription = callMethods
        .callStream(uid: preferences.getString("uid"))
        .listen((DocumentSnapshot ds) {
          print("ds is ${ds.data}");
      switch (ds.data) {
        case null:
          // snapshot is null i.e. the call is hanged and document is deleted
          Navigator.pop(context);
          break;

        default:
          break;
      }
    });
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<AgoraRenderWidget> list = [
      AgoraRenderWidget(0, local: true, preview: true),
    ];
    _users.forEach((int uid) => list.add(AgoraRenderWidget(uid)));
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
            child: Column(
          children: <Widget>[_videoView(views[0])],
        ));
      case 2:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow([views[0]]),
            _expandedVideoRow([views[1]])
          ],
        ));
      case 3:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 3))
          ],
        ));
      case 4:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 4))
          ],
        ));
      default:
    }
    return Container();
  }

  /// Toolbar layout
  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic : Icons.mic_off,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () async {
              await callMethods.endCall(
                call: widget.call,
              );

              // if (!hasUserJoined) {
              //   Log log = Log(
              //       callerName: widget.call.callerName,
              //       callerPic: widget.call.callerPic,
              //       receiverName: widget.call.receiverName,
              //       receiverPic: widget.call.receiverPic,
              //       timestamp: DateTime.now().toString(),
              //       callStatus: CALL_STATUS_MISSED);
              //
              //   FirebaseFirestore.instance
              //       .collection("Users")
              //       .doc(widget.call.receiverId)
              //       .collection("callLogs")
              //       .doc(log.timestamp)
              //       .set({
              //     "callerName": log.callerName,
              //     "callerPic": log.callerPic,
              //     "receiverName": log.receiverName,
              //     "receiverPic": log.receiverPic,
              //     "timestamp": log.timestamp,
              //     "callStatus": log.callStatus
              //   });
              // }
              return Navigator.push(context, MaterialPageRoute(builder: (_)=>Rating(widget.call.receiverId)));
            },
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          // RawMaterialButton(
          //   onPressed: _onSwitchCamera,
          //   child: Icon(
          //     Icons.switch_camera,
          //     color: Colors.blueAccent,
          //     size: 20.0,
          //   ),
          //   shape: CircleBorder(),
          //   elevation: 2.0,
          //   fillColor: Colors.white,
          //   padding: const EdgeInsets.all(12.0),
          // )
        ],
      ),
    );
  }

  /// Info panel to show logs
  Widget _panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            itemCount: _infoStrings.length,
            itemBuilder: (BuildContext context, int index) {
              if (_infoStrings.isEmpty) {
                return null;
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _infoStrings[index],
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontFamily: "Raleway",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    AgoraRtcEngine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    AgoraRtcEngine.switchCamera();
  }

  int remaining;

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    callStreamSubscription.cancel();
    FirebaseFirestore.instance
        .collection('profile')
        .doc(widget.call.callerId)
        .update({
      'talkTime': this.remaining,
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Call'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: <Widget>[
            Center(
              child: Countdown(
                duration: Duration(minutes: talkTime),
                builder: (BuildContext ctx, Duration remaining) {
                  this.remaining = remaining.inMinutes;
                  return Center(
                      child: Text(
                    "${remaining.toString().substring(0, remaining.toString().length - 7)}",
                    style: Theme.of(context).textTheme.headline5,
                  )); // 01:00:00
                },
                onFinish: () async {
                  await callMethods.endCall(
                    call: widget.call,
                  );

                  if (!hasUserJoined) {
                    Log log = Log(
                        callerName: widget.call.callerName,
                        callerPic: widget.call.callerPic,
                        receiverName: widget.call.receiverName,
                        receiverPic: widget.call.receiverPic,
                        timestamp: DateTime.now().toString(),
                        callStatus: CALL_STATUS_MISSED);

                    FirebaseFirestore.instance
                        .collection("Users")
                        .doc(widget.call.receiverId)
                        .collection("callLogs")
                        .doc(log.timestamp)
                        .set({
                      "callerName": log.callerName,
                      "callerPic": log.callerPic,
                      "receiverName": log.receiverName,
                      "receiverPic": log.receiverPic,
                      "timestamp": log.timestamp,
                      "callStatus": log.callStatus
                    });
                  }
                  Navigator.pop(context);
                  return Fluttertoast.showToast(msg: 'Talk time over!');
                },
              ),
            ),
            // _viewRows(),
            // _panel(),
            _toolbar(),
          ],
        ),
      ),
    );
  }
}
