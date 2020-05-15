import 'package:fitness_app/screens/onboarding.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.blue[900],
        primaryColor: Colors.blue[900],
        appBarTheme: AppBarTheme(
          color: Colors.blue[900],
        ),
      ),
      home: OnBoarding(),
    );
  }
}
