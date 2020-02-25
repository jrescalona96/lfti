import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Workout.dart';
import 'package:lfti_app/screens/home.dart';
import 'package:lfti_app/screens/dashboard.dart';
import 'package:lfti_app/screens/select_workout.dart';
import 'package:lfti_app/screens/session.dart';
import 'package:lfti_app/screens/view_workout.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args =
        settings.arguments; // Hold arguments passed from previous screen
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
        break;
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => Dashboard());
        break;
      case '/selectWorkout':
        return MaterialPageRoute(builder: (_) => SelectWorkout());
        break;
      case '/viewWorkout':
        if (args is Workout) {
          return MaterialPageRoute(
            builder: (_) => ViewWorkout(workout: args),
          );
        } else {
          // TODO: throw exceptions here.
          return _errorRoute();
        }
        break;
      case '/startSession':
        if (args is Session) {
          return MaterialPageRoute(
            builder: (_) => Session(session: args),
          );
        } else {
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
          ),
        ),
      );
    });
  }
}
