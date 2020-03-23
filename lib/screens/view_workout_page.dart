// flutter & dart imports
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// component imports
import 'package:lfti_app/components/routine_card.dart';
import "package:lfti_app/components/bottom_navigation_button.dart";

// class imports
import 'package:lfti_app/classes/Workout.dart';
import "package:lfti_app/classes/User.dart";
import 'package:lfti_app/classes/Session.dart';
import 'package:lfti_app/classes/Constants.dart';

class ViewWorkoutPage extends StatelessWidget {
  User _currentUser;
  Workout _workout;

  ViewWorkoutPage(Map args) {
    this._currentUser = args["user"];
    this._workout = args["workout"];
  }

  Session _createSession() {
    String id = "S" + DateFormat('yyyyMMdd-kk:mm:ss:ms').format(DateTime.now());
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return new Session(
        id: id, date: formattedDate, name: _workout.name, workout: _workout);
  }

  @override
  Widget build(BuildContext context) {
    void _navigate() {
      Navigator.pushNamed(
        context,
        '/startSession',
        arguments: {"user": _currentUser, "session": _createSession()},
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(_workout.name, style: kMediumBoldTextStyle),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  Widget item;
                  if (index < _workout.routines.length) {
                    item = RoutineCard(_workout.routines[index]);
                  }
                  return item;
                }),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationButton(
          label: "START SESSION!",
          action: _navigate,
          color: kGreenButtonColor,
        ));
  }
}
