import "package:flutter/material.dart";

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/User.dart";
import "package:lfti_app/classes/Workout.dart";
import "package:lfti_app/classes/Routine.dart";

// screen imports
import "package:lfti_app/screens/home_page.dart";
import "package:lfti_app/screens/dashboard_page.dart";
import "package:lfti_app/screens/login_page.dart";
import "package:lfti_app/screens/workouts_page.dart";
import "package:lfti_app/screens/session_page.dart";
import "package:lfti_app/screens/signup_page.dart";
import "package:lfti_app/screens/view_routines_page.dart";
import "package:lfti_app/screens/session_summary_page.dart";
import "package:lfti_app/screens/checklist_page.dart";
import "package:lfti_app/screens/update_routine_page.dart";
import "package:lfti_app/screens/view_workouts_page.dart";
import "package:lfti_app/screens/update_workout_page.dart";
import "package:lfti_app/screens/create_workout_page.dart";
import "package:lfti_app/screens/account_page.dart";

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args =
        settings.arguments; // Hold arguments passed from previous screen
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => HomePage());
        break;
      case "/login":
        if (args is Map<String, String>) {
          return MaterialPageRoute(builder: (_) => LoginPage(args));
        } else {
          return _errorRoute();
        }
        break;
      case "/account":
        if (args is User) {
          return MaterialPageRoute(builder: (_) => AccountPage(args));
        } else {
          return _errorRoute();
        }
        break;
      case "/signup":
        return MaterialPageRoute(builder: (_) => SignUpPage());
        break;
      case "/dashboard":
        if (args is User) {
          return MaterialPageRoute(builder: (_) => DashboardPage(args));
        } else {
          return _errorRoute();
        }
        break;
      case "/workouts":
        if (args is User) {
          return MaterialPageRoute(builder: (_) => WorkoutsPage(args));
        } else {
          return _errorRoute();
        }
        break;
      case "/viewWorkouts":
        if (args is User) {
          return MaterialPageRoute(builder: (_) => ViewWorkoutsPage(args));
        } else {
          return _errorRoute();
        }
        break;
      case "/updateWorkout":
        if (args is Workout) {
          return MaterialPageRoute(builder: (_) => UpdateWorkoutPage(args));
        } else {
          return _errorRoute();
        }
        break;
      case "/createWorkout":
        if (args is User) {
          return MaterialPageRoute(builder: (_) => CreateWorkoutPage(args));
        } else {
          return _errorRoute();
        }
        break;
      case "/viewRoutines":
        if (args is Map) {
          return MaterialPageRoute(builder: (_) => ViewRoutinesPage(args));
        } else {
          return _errorRoute();
        }
        break;
      case "/updateRoutine":
        if (args is Routine) {
          return MaterialPageRoute(builder: (_) => UpdateRoutinePage(args));
        } else {
          return _errorRoute();
        }
        break;
      case "/updateChecklist":
        if (args is User) {
          return MaterialPageRoute(builder: (_) => ChecklistPage(args));
        } else {
          return _errorRoute();
        }
        break;
      case "/startSession":
        if (args is User) {
          return MaterialPageRoute(
            builder: (_) => SessionPage(args),
          );
        } else {
          return _errorRoute();
        }
        break;
      case "/endSession":
        if (args is Map) {
          return MaterialPageRoute(
            builder: (_) => SessionSummaryPage(args),
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
          title: Text(
            "Error!",
          ),
        ),
        body: Center(
          child: Text(
            "Something went wrong!",
            style: kMediumBoldTextStyle,
          ),
        ),
      );
    });
  }
}
