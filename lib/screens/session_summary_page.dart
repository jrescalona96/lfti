import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import "package:lfti_app/components/custom_card.dart";
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/Session.dart";
import "package:lfti_app/classes/Routine.dart";
import "package:lfti_app/classes/User.dart";

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

  void _updateUserData() {
    try {
      _currentUser.setLastSession({
        "name": _session.name,
        "description": _session.workout.name,
        "date": _session.date
      });
      print("Success: Updated user data!");
    } catch (e) {
      print("Error: Failed to updated user data! " + e.toString());
    }
  }

  void _updateDatabase() async {
    var ref = _currentUser.getFirestoreReference();
    var data = _currentUser.getLastSession();
    //TODO: update lastSessionData
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // TODO: implement navbar drawer
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(
          "Hello" + _currentUser.getFirstName() + "!",
          style: kMediumBoldTextStyle,
        ),
      ),
      body: CustomCard(
        cardChild: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 100.0),
            Expanded(
              flex: 1,
              child: Text(
                "All done!",
                style: kLargeBoldTextStyle1_5x,
                textAlign: TextAlign.center,
              ),
            ),
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
                        style: kLargeBoldTextStyle2x,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "min : sec",
                        style: kMediumLabelTextStyle,
                      )
                    ],
                  ),
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
              "Done",
              style: kMediumBoldTextStyle,
            ),
          ),
          onTap: () {
            _updateUserData();
            Navigator.pushNamed(
              context,
              "/dashboard",
              arguments: _currentUser,
            );
          }),
    );
  }
}
