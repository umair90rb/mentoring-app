import 'dart:math';

import 'package:brain_store/services/db_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './rating.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CallScreen extends StatefulWidget {
  int talkTime;
  String uid;
  String pid;
  String userEmail;
  String podcasterEmail;
  CallScreen(
      this.talkTime, this.uid, this.pid, this.userEmail, this.podcasterEmail);

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  DbServices db = DbServices();

  /// Define App ID and Token
  // String APP_ID = "08d675d2350c42a49ae5bff08b2424e1";
  // String APP_ID = "6cb4c202c8a2486a88b07787704572f5";
  String APP_ID = "925300e606f2495ca1f48fa46b0bd88c";
  // String token = "0066cb4c202c8a2486a88b07787704572f5IACneRrEPIetQRmMyppsu/K6F4Itsiteb60z6kdyZncVddJjSIgAAAAAEAB33sfLnbClYAEAAQCcsKVg";
  String status = 'Ringing...';

  StreamSubscription callStreamReference;
  bool loudSpeaker = false;
  bool muted = false;
  bool mic = false;

  Timer durationTimer;
  Timer talkTimer;
  String callDocId;

  int _start = 0;
  Duration duration;
  Duration talkTime;
  int talkTimeInSeconds;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    durationTimer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          _start++;
          duration = Duration(seconds: _start);
        });
      },
    );
  }

  void startTalkTime() {
    const oneSec = const Duration(seconds: 1);
    talkTimer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (talkTimeInSeconds == 0) {
          updateTalkTime();
          Navigator.pop(context);
          Fluttertoast.showToast(msg: 'TalkTime over!');
        }
        setState(() {
          talkTimeInSeconds--;
          talkTime = Duration(seconds: talkTimeInSeconds);
        });
      },
    );
  }

  String formateDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void initState() {
    duration = Duration(seconds: 0);
    talkTime = Duration(minutes: widget.talkTime);
    talkTimeInSeconds = widget.talkTime * 60;
    initPlatformState();
  }

  // Initialize the app
  Future<void> initPlatformState() async {
    String channel = Random().nextInt(1000).toString();
    // String channel = '123';
    // Create RTC client instance
    await AgoraRtcEngine.create(APP_ID);
    await AgoraRtcEngine.disableVideo();
    // Define event handler
    eventHandler();
    await AgoraRtcEngine.setEnableSpeakerphone(false);
    await AgoraRtcEngine.enableWebSdkInteroperability(true);
    await AgoraRtcEngine.setParameters(
        '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''');
    await AgoraRtcEngine.joinChannel(null, channel, null, 0);
    FirebaseFirestore.instance.collection('call').add({
      'uid': widget.uid,
      'pid': widget.pid,
      'status': 'dialing',
      'channel': channel,
      'email': widget.userEmail,
      'at': Timestamp.now()
    }).then((value) {
      callStreamReference = FirebaseFirestore.instance
          .collection('call')
          .doc(value.id)
          .snapshots()
          .listen((event) {
        setState(() {
          callDocId = value.id;
        });
        if (event['status'] == 'attended') {
        } else if (event['status'] == 'declined') {
          callStreamReference.cancel();
          Navigator.pop(context);
          Fluttertoast.showToast(msg: 'Call rejected!');
        } else if (event['status'] == 'ended') {
          callStreamReference.cancel();
          Navigator.pop(context);
          Fluttertoast.showToast(msg: 'Call ended!');
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => Rating(widget.pid)));
        }
      });
    });
  }

  void eventHandler() {
    AgoraRtcEngine.onError = (dynamic code) {
      print("onError $code");
    };

    AgoraRtcEngine.onJoinChannelSuccess = (
      String channel,
      int uid,
      int elapsed,
    ) {
      print("onJoinChannelSuccess");
    };

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      print("onUserJoined");
      startTimer();
      startTalkTime();
      setState(() {
        status = 'Call Connected.';
      });
    };

    AgoraRtcEngine.onUpdatedUserInfo = (AgoraUserInfo userInfo, int i) {
      print("onUpdateUserInfo");
    };

    AgoraRtcEngine.onRejoinChannelSuccess = (String string, int a, int b) {
      print("onRejoinChannelSuccess");
    };

    AgoraRtcEngine.onUserOffline = (int a, int b) {
      print("onUserOffline");
      Navigator.pop(context);
    };

    AgoraRtcEngine.onRegisteredLocalUser = (String s, int i) {
      print("onRegisteredLocalUser");
    };

    AgoraRtcEngine.onLeaveChannel = () {
      print("onLeaveChannel");
    };

    AgoraRtcEngine.onConnectionLost = () {
      print("onConnectionLost");
    };

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      // if call was picked
      print("onUserOffline");
    };
  }

  // Create a simple chat UI
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 200,
          ),
          Center(
            child: Text(
              status,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "Mentor Email\n${widget.podcasterEmail}",
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
              child: Text(
            "${formateDuration(duration)}",
            style: TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          )),
          SizedBox(
            height: 30,
          ),
          Center(
              child: Text(
            "Your Talktime\n${formateDuration(talkTime)}",
            style: TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          )),
          Expanded(
            child: Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RawMaterialButton(
                onPressed: () async {
                  setState(() {
                    muted = !muted;
                  });
                  await AgoraRtcEngine.muteAllRemoteAudioStreams(muted);
                },
                child: Icon(
                  Icons.volume_mute,
                  size: 35.0,
                ),
                shape: CircleBorder(),
                elevation: 2.0,
                fillColor: muted ? Colors.green : Colors.white,
                padding: const EdgeInsets.all(15.0),
              ),
              SizedBox(
                height: 20,
              ),
              RawMaterialButton(
                onPressed: () async {
                  setState(() {
                    mic = !mic;
                  });
                  await AgoraRtcEngine.muteLocalAudioStream(mic);
                },
                child: Icon(
                  mic ? Icons.mic : Icons.mic_off,
                  size: 35.0,
                ),
                shape: CircleBorder(),
                elevation: 2.0,
                fillColor: Colors.white,
                padding: const EdgeInsets.all(15.0),
              ),
              SizedBox(
                height: 20,
              ),
              RawMaterialButton(
                onPressed: () async {
                  setState(() {
                    loudSpeaker = !loudSpeaker;
                  });
                  await AgoraRtcEngine.setEnableSpeakerphone(loudSpeaker);
                },
                child: Icon(
                  Icons.volume_up,
                  size: 35.0,
                ),
                shape: CircleBorder(),
                elevation: 2.0,
                fillColor: loudSpeaker ? Colors.green : Colors.white,
                padding: const EdgeInsets.all(15.0),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          RawMaterialButton(
            onPressed: () {
              db.updateDoc('call', callDocId, {'status': 'ended'}).then(
                  (value) {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => Rating(widget.pid)));
              });
            },
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: EdgeInsets.all(15.0),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  updateTalkTime() async {
    await db.updateDoc('profile', widget.uid, {'talkTime': talkTime.inMinutes});
  }

  @override
  void dispose() {
    callStreamReference.cancel();
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    durationTimer.cancel();
    talkTimer.cancel();
    updateTalkTime();
    super.dispose();
  }
}
