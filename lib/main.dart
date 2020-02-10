import 'package:flutter/material.dart';
import 'screens/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'lfti',
      theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 35.0, color: Colors.white),
          button: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        buttonTheme: ButtonThemeData(
          minWidth: 250.0,
          height: 60.0,
          buttonColor: Colors.indigo,
          shape: StadiumBorder(),
          padding: EdgeInsets.all(10.0),
          textTheme: ButtonTextTheme.normal,
        ),
      ),
      home: HomePage(),
    );
  }
}
