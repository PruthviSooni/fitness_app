import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/screens/ExerciseHub.dart';
import 'package:fitness_app/screens/exercisegif.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ExerciseDetail extends StatefulWidget {
  final Exercises exercises;

  ExerciseDetail({this.exercises});

  @override
  _ExerciseDetailState createState() => _ExerciseDetailState(exercises);
}

class _ExerciseDetailState extends State<ExerciseDetail> {
  final Exercises exercises;

  _ExerciseDetailState(this.exercises);

  int secs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(top: false, child: buildStack(context)),
    );
  }

  Stack buildStack(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.center,
            ),
          ),
          //Animation while image loading
          child: Hero(
            tag: widget.exercises.id,
            child: Stack(
              children: <Widget>[
                //Actual image form Home.dart
                CachedNetworkImage(
                  imageUrl: widget.exercises.thumbnail,
                  placeholder: (context, url) => Image(
                    image: AssetImage('assets/placeholder.jpg'),
                    fit: BoxFit.cover,
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
                //Gradient on Image
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter),
                  ),
                ),
                //Slider for Setting Time
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 40),
                    height: 200,
                    width: 200,
                    child: SleekCircularSlider(
                      appearance: CircularSliderAppearance(
                        customColors: CustomSliderColors(
                          progressBarColor: Colors.blue[900],
                        ),
                      ),
                      onChange: (double value) => secs = value.toInt(),
                      initialValue: 30,
                      max: 60,
                      innerWidget: (v) => Container(
                        alignment: Alignment.center,
                        child: Text(
                          '${v.toInt()} S',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'Orbitron',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        ///Raised Button
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(bottom: 20),
          child: RaisedButton(
            splashColor: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ExerciseGif(
                    exercises: widget.exercises,
                    seconds: secs,
                  ),
                ),
              );
            },
            color: Colors.blue[900],
            child: Text(
              'Start Exercise! ',
              style: TextStyle(
                fontFamily: 'Orbitron',
                letterSpacing: 2.0,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
