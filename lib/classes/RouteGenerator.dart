import 'package:flutter/material.dart';

// class & component imports
import 'package:lfti_app/classes/Constants.dart';
import 'package:lfti_app/classes/Workout.dart';
import 'package:lfti_app/screens/home_page.dart';
import 'package:lfti_app/screens/dashboard_page.dart';
import 'package:lfti_app/screens/login_page.dart';
import 'package:lfti_app/screens/select_workout_page.dart';
import 'package:lfti_app/screens/session_page.dart';
import 'package:lfti_app/screens/signup_page.dart';
import 'package:lfti_app/screens/view_workout_page.dart';
import 'package:lfti_app/classes/Session.dart';
import 'package:lfti_app/screens/session_end_page.dart';
import "package:lfti_app/screens/loading_screen.dart";

// firebase imports
import 'package:cloud_firestore/cloud_firestore.dart';

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
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUpPage());
        break;
      case "/loading":
        return MaterialPageRoute(builder: (_) => LoadingScreen());
        break;
      case '/dashboard':
        print("dashboard args: $args");
        if (args is DocumentReference) {
          return MaterialPageRoute(builder: (_) => DashboardPage(args));
        } else {
          return _errorRoute();
        }
        break;
      case '/selectWorkout':
        return MaterialPageRoute(builder: (_) => SelectWorkoutPage());
        break;
      case '/viewWorkout':
        print("viewWorkout args: $args");
        if (args is Workout) {
          return MaterialPageRoute(
            builder: (_) => ViewWorkoutPage(workout: args),
          );
        } else {
          return _errorRoute();
        }
        break;
      case '/startSession':
        print("startSession args: $args");
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
        print("endSession args: $args");
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
