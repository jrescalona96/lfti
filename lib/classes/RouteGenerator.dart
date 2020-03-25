import "package:flutter/material.dart";

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/User.dart";

// screen imports
import "package:lfti_app/screens/home_page.dart";
import "package:lfti_app/screens/dashboard_page.dart";
import "package:lfti_app/screens/login_page.dart";
import "package:lfti_app/screens/select_workout_page.dart";
import "package:lfti_app/screens/session_page.dart";
import "package:lfti_app/screens/signup_page.dart";
import "package:lfti_app/screens/view_workout_page.dart";
import "package:lfti_app/screens/session_summary_page.dart";
import "package:lfti_app/screens/edit_workouts_page.dart";
import "package:lfti_app/screens/edit_checklist_page.dart";

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
      case "/signup":
        return MaterialPageRoute(builder: (_) => SignUpPage());
        break;
      case "/dashboard":
        print("dashboard args: $args");
        if (args is User) {
          return MaterialPageRoute(builder: (_) => DashboardPage(args));
        } else {
          return _errorRoute();
        }
        break;
      case "/selectWorkout":
        print("selectWorkout args: $args ");
        if (args is User) {
          return MaterialPageRoute(builder: (_) => SelectWorkoutPage(args));
        } else {
          return _errorRoute();
        }
        break;
      case "/editWorkouts":
        print("editWorkouts args: $args");
        if (args is User) {
          return MaterialPageRoute(builder: (_) => EditWorkoutPage(args));
        } else {
          return _errorRoute();
        }
        break;
      case "/editChecklist":
        print("editChecklist args: $args");
        if (args is User) {
          return MaterialPageRoute(builder: (_) => EditChecklistPage(args));
        } else {
          return _errorRoute();
        }
        break;
      case "/viewWorkout":
        print("viewWorkout args: $args");
        if (args is Map) {
          return MaterialPageRoute(
            builder: (_) => ViewWorkoutPage(args),
          );
        } else {
          return _errorRoute();
        }
        break;
      case "/startSession":
        print("startSession args: $args");
        if (args is User) {
          return MaterialPageRoute(
            builder: (_) => SessionPage(args),
          );
        } else {
          return _errorRoute();
        }
        break;
      case "/endSession":
        print("endSession args: $args");
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
