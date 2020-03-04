import 'package:flutter/material.dart';
import 'classes/RouteController.dart';
import 'package:lfti_app/classes/Constants.dart';

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
        scaffoldBackgroundColor: kMainBackgroundColor,
        buttonTheme: ButtonThemeData(
          minWidth: double.infinity,
          shape: StadiumBorder(),
          padding: kButtonPadding,
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: RouteController.generateRoute,
    );
  }
}
