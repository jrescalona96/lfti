import 'package:flutter/material.dart';
import 'package:lfti_app/components/routine_card.dart';
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
    DateTime now = DateTime.now();
    return new Session(
        id: 1,
        date: now.toString(),
        name: now.toString().substring(0, 10) + _workout.name,
        workout: _workout);
  }

  @override
  Widget build(BuildContext context) {
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
      bottomNavigationBar: GestureDetector(
        child: Container(
          color: kStartButtonColor,
          height: kStartButtonHeight,
          alignment: Alignment.center,
          child: Text(
            'Start',
            style: kMediumBoldTextStyle,
          ),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/startSession',
            arguments: {"user": _currentUser, "session": _createSession()},
          );
        },
      ),
    );
  }
}
