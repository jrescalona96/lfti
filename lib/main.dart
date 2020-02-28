import 'package:flutter/material.dart';
import 'classes/RouteGenerator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'lfti',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Color(0xFF0A0E21),
        accentColor: Colors.white12,
        scaffoldBackgroundColor: Color(0x0B0A0E21),

        textTheme: TextTheme(
          headline: TextStyle(fontSize: 64.0, fontWeight: FontWeight.bold),
          subhead: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 32.0, fontStyle: FontStyle.normal),
          body1: TextStyle(fontSize: 14.0),
          body2: TextStyle(fontSize: 24.0),
          display1: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
          display2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
          display3: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
          display4: TextStyle(fontSize: 24.0, fontWeight: FontWeight.normal),
        ),
        buttonTheme: ButtonThemeData(
          shape: StadiumBorder(),
          minWidth: 300,
          padding: EdgeInsets.all(15.0),
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
