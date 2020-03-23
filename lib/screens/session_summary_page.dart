import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:lfti_app/components/custom_card.dart";
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/Session.dart";
import "package:lfti_app/classes/Routine.dart";
import "package:lfti_app/classes/User.dart";
import "package:lfti_app/components/custom_card.dart";
import "dart:core";

class SessionSummaryPage extends StatelessWidget {
  User _currentUser;
  Session _session;
  SessionSummaryPage(Map args) {
    this._currentUser = args["user"];
    this._session = args["session"];
  }

  int getTotalNumberOfSets() {
    int sumOfSets = 0;
    for (Routine r in _session.workout.routines) {
      if (r.exercise.name != "Rest") sumOfSets += r.sets;
    }
    return sumOfSets;
  }

  int getTotalNumberOfExercices() {
    int sumOfSets = 0;
    for (Routine r in _session.workout.routines) {
      if (r.exercise.name != "Rest") sumOfSets++;
    }
    return sumOfSets;
  }

  // update session obj and database
  void _updateLastSession() async {
    try {
      _currentUser.setLastSession({
        "name": _session.name,
        "description": "Session on " +
            _session.date +
            " for " +
            _session.totalElapsetime +
            " sec",
        "date": _session.date
      });
      print("Success: Updated Session Object!");
    } catch (e) {
      print("Error: Unable to update user session object! " + e.toString());
    }

    try {
      await Firestore.instance.runTransaction((transaction) {
        transaction.update(
          _currentUser.getFirestoreReference(),
          {"lastSession": _currentUser.getLastSession()},
        );
      });
      print("Success: Updated lastSession in database!");
    } catch (e) {
      print("Error: Unable to update user session object! " + e.toString());
    }
  }

  void _formatTime() {
    String str = _session.totalElapsetime;
    RegExp exp = new RegExp(r"(\d\d)");
    Iterable<RegExpMatch> matches = exp.allMatches(str);
    print(matches.elementAt(0).group(0));
  }

  @override
  Widget build(BuildContext context) {
    _formatTime();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Session Summary",
          style: kMediumBoldTextStyle,
        ),
      ),
      body: CustomCard(
        cardChild: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 100.0),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    "TIME",
                    style: kMediumBoldTextStyle,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        _session.totalElapsetime,
                        style: kLargeBoldTextStyle1_5x,
                        textAlign: TextAlign.center,
                      ),
                      Text("min : sec", style: kMediumLabelTextStyle)
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Session Name
                  Text(
                    _session.name,
                    style: kMediumBoldTextStyle,
                  ),
                  // Workout Name
                  Text(
                    _session.workout.name,
                    style: kMediumBoldTextStyle,
                  ),
                  // Total number of Excercises
                  Text(
                    getTotalNumberOfExercices().toString() + " Exercices",
                    style: kMediumBoldTextStyle,
                  ),
                  // Total number of Sets
                  Text(
                    (getTotalNumberOfSets()).toString() + " Sets",
                    style: kMediumBoldTextStyle,
                  )
                ],
              ),
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
              "DONE!",
              style: kButtonBoldTextFontStyle,
            ),
          ),
          onTap: () {
            _updateLastSession();
            Navigator.pushNamed(
              context,
              "/dashboard",
              arguments: _currentUser,
            );
          }),
    );
  }
}
