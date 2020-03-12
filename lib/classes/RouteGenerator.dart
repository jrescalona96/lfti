import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'package:lfti_app/classes/Workout.dart';
import 'package:lfti_app/screens/home_page.dart';
import 'package:lfti_app/screens/dashboard_page.dart';
import 'package:lfti_app/screens/login_page.dart';
import 'package:lfti_app/screens/select_workout_page.dart';
import 'package:lfti_app/screens/session_page.dart';
import 'package:lfti_app/screens/view_workout_page.dart';
import 'package:lfti_app/classes/Session.dart';
import 'package:lfti_app/screens/session_end_page.dart';
import 'package:lfti_app/screens/register_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args =
        settings.arguments; // Hold arguments passed from previous screen
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
        break;
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
        break;
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterPage());
        break;
      case '/dashboard':
        if (args is DataSnapshot) {
          return MaterialPageRoute(builder: (_) => DashboardPage(args));
        } else {
          return _errorRoute();
        }
        break;
      case '/selectWorkout':
        return MaterialPageRoute(builder: (_) => SelectWorkoutPage());
        break;
      case '/viewWorkout':
        if (args is Workout) {
          return MaterialPageRoute(
            builder: (_) => ViewWorkoutPage(workout: args),
          );
        } else {
          return _errorRoute();
        }
        break;
      case '/startSession':
        if (args is Session) {
          return MaterialPageRoute(
            builder: (_) => SessionPage(session: args),
          );
        } else {
          print(args);
          return _errorRoute();
        }
        break;
      case '/endSession':
        if (args is Session) {
          return MaterialPageRoute(
            builder: (_) => SessionEndPage(session: args),
          );
        } else {
          print(args);
          return _errorRoute();
        }
        break;
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: Text(
            "Error!",
          ),
        ),
        body: Center(
          child: Text(
            'Something went wrong!',
            style: kMediumBoldTextStyle,
          ),
        ),
      );
    });
  }
}
