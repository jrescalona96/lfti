import 'package:flutter/material.dart';
import 'classes/RouteGenerator.dart';
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
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          padding: kButtonPadding,
          buttonColor: kBlueButtonColor,
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
