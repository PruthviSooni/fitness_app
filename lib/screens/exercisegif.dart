import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/screens/ExerciseHub.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseGif extends StatefulWidget {
  final Exercises exercises;
  final int seconds;

  ExerciseGif({this.exercises, this.seconds});

  @override
  _ExerciseGifState createState() => _ExerciseGifState();
}

class _ExerciseGifState extends State<ExerciseGif> {
  Exercises exercises;
  bool _isCompleted = false, _loading;
  int _escapedSecs = 0;
  Timer timer;
  @override
  void initState() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (t) {
        if (t.tick == widget.seconds) {
          t.cancel();
          setState(() {
            _isCompleted = true;
          });
          playAudio();
        }
        setState(() {
          _escapedSecs = t.tick;
        });
      },
    );
    super.initState();
  }

  void playAudio() {
    final player = AudioCache();
    player.play('ends.wav');
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          _isCompleted != true
              ? SafeArea(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.topCenter,
                    child: Text(
                      "$_escapedSecs/${widget.seconds}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: "Orbitron"),
                    ),
                  ),
                )
              : Container(),
          SizedBox(
            height: 5,
          ),
          Center(
            child: CachedNetworkImage(
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              imageUrl: widget.exercises.gif,
              placeholder: (context, url) => Image(
                image: AssetImage('assets/placeholder.jpg'),
                fit: BoxFit.cover,
                height: 250,
                width: MediaQuery.of(context).size.width,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }
}
