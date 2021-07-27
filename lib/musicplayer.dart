import 'package:audio_service/audio_service.dart';
import 'package:brain_store/BottomNavigationbar/Botton_nav_widget/postcast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';


class MusicPlayerScreen extends StatefulWidget {
  dynamic podcast;
  MusicPlayerScreen(this.podcast);
  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  bool _isPlaying = false;
  bool _isBtnDisable = true;
  AudioPlayer player;
  Duration duration;

  @override
  void initState() {
    player = AudioPlayer();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    player.setUrl(widget.podcast['podcast']).then((value){
      duration = value;
      setState(() {
        _isBtnDisable = false;
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<AudioPlaybackState>(
        stream: player.playbackStateStream,
        builder: (context, playbackState) {
          print(playbackState.data);
          if(playbackState.data == AudioPlaybackState.completed){
            player.stop();
          }
          playbackState.data == AudioPlaybackState.connecting ? _isBtnDisable = true : _isBtnDisable = false;
          return Container(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(FontAwesomeIcons.chevronDown),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x46000000),
                          offset: Offset(0, 20),
                          spreadRadius: 0,
                          blurRadius: 30,
                        ),
                        BoxShadow(
                          color: Color(0x11000000),
                          offset: Offset(0, 10),
                          spreadRadius: 0,
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        image: NetworkImage(
                            widget.podcast['thumbnail']),
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.width * 0.7,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    widget.podcast['name'],
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(widget.podcast['description']
                      // "Owner of the podcast name"
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  StreamBuilder<Duration>(
                    stream: player.getPositionStream(),
                    builder: (context, snapshot) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Flexible( child: Text(_printDuration(snapshot?.data) ?? '00:00')),
                            Flexible(
                              flex:5,
                              child: Slider(
                                onChanged: (v) async {
                                  print(v);
                                  await player.seek(Duration(seconds: v.toInt() ));
                                },
                                value: snapshot?.data?.inSeconds?.toDouble()??0,
                                max: widget.podcast['duration'].toDouble(),
                                min: 0,
                                activeColor: Colors.black,
                              ),
                            ),
                            Flexible(flex:1, child: Text(_printDuration(Duration(seconds: widget.podcast['duration'].toInt())))),
                          ],
                        ),
                      );
                    }
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      StreamBuilder<double>(
                        stream: speedStream(Duration(milliseconds: 100), player),
                        builder: (context, snapshot) => IconButton(
                          icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: () {
                            _showSliderDialog(
                              context: context,
                              title: "Adjust speed",
                              divisions: 10,
                              min: 0.5,
                              max: 1.5,
                              stream: speedStream(Duration(seconds: 1), player),
                              onChanged: player.setSpeed,
                            );
                          },
                        ),
                      ),

                      IconButton(
                        iconSize: 50,
                        disabledColor: Colors.grey,
                        onPressed: _isBtnDisable ? null : () async {

                          playbackState.data == AudioPlaybackState.paused ||
                              playbackState.data == AudioPlaybackState.stopped ? await player.play() : player.pause();
                          },
                        icon: Icon(
                          playbackState.data == AudioPlaybackState.paused ||
                              playbackState.data == AudioPlaybackState.stopped
                              ? FontAwesomeIcons.play
                              : FontAwesomeIcons.pause,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        iconSize: 25,
                        disabledColor: Colors.grey,
                        onPressed: () async {

                          await player.stop();
                          setState(() {
                            _isPlaying = !_isPlaying;
                          });
                        },
                        icon: Icon(
                          FontAwesomeIcons.stop,
                          color: Colors.black,
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration?.inMinutes?.remainder(60));
    String twoDigitSeconds = twoDigits(duration?.inSeconds?.remainder(60));
    return "${twoDigits(duration?.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  Stream<double> speedStream(Duration interval, AudioPlayer player) async* {
    while (true) {
      await Future.delayed(interval);
      yield player.speed;
    }
  }

  void _showSliderDialog({
    BuildContext context,
    String title,
    int divisions,
    double min,
    double max,
    String valueSuffix = '',
    Stream<double> stream,
    ValueChanged<double> onChanged,
  }) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, textAlign: TextAlign.center),
        content: StreamBuilder<double>(
          stream: stream,
          builder: (context, snapshot) => Container(
            height: 100.0,
            child: Column(
              children: [
                Text('${snapshot.data?.toStringAsFixed(1)??0}$valueSuffix',
                    style: TextStyle(
                        fontFamily: 'Fixed',
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0)),
                Slider(
                  divisions: divisions,
                  min: min,
                  max: max,
                  value: snapshot.data ?? 1.0,
                  onChanged: onChanged,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
