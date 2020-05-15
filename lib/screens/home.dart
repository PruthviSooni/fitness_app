import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/screens/exerciseStart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'ExerciseHub.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url =
      "https://raw.githubusercontent.com/PruthviSooni/fitness-app/master/exercises.json";
  ExerciseHub _exerciseHub;

  @override
  void initState() {
    setState(() {
      getExercise();
    });

    super.initState();
  }

  void getExercise() async {
    var res = await http.get(url);
    var body = res.body;
    var decodeJson = jsonDecode(body);
    _exerciseHub = ExerciseHub.fromJson(decodeJson);
    setState(() {});
//    print(body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fitness App",
          style: TextStyle(
              fontFamily: 'Orbitron', wordSpacing: 2.0, letterSpacing: 2.0),
        ),
        centerTitle: true,
      ),
      body: widgets(context),
    );
  }

  Container widgets(BuildContext context) {
    return Container(
      child: _exerciseHub != null
          ? ListView(
              children: _exerciseHub.exercises.map((e) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExerciseDetail(
                          exercises: e,
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: e.id,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              imageUrl: e.thumbnail,
                              placeholder: (context, url) =>
                                  Image.asset('assets/placeholder.jpg'),
                              fit: BoxFit.cover,
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              padding: EdgeInsets.only(bottom: 10, left: 10),
                              width: MediaQuery.of(context).size.width,
                              height: 250,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.black, Colors.transparent],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.center,
                                ),
                              ),
                              child: Text(
                                e.title,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Orbitron',
                                    letterSpacing: 2.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            )
          : LinearProgressIndicator(),
    );
  }
}
