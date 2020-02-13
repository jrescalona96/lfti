import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'lfti',
      theme: ThemeData.dark().copyWith(
        backgroundColor: Colors.black,
        dialogBackgroundColor: Colors.white,
        accentColor: Colors.white10,
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'SF-Pro-Compact-Rounded-Semibold',
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
        buttonTheme: ButtonThemeData(
          shape: StadiumBorder(),
          minWidth: 300,
          padding: EdgeInsets.all(15.0),
        ),
      ),
      home: Dashboard(),
    );
  }
}
