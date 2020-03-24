import "package:flutter/material.dart";
import "dart:core";

// component imports
import "package:lfti_app/components/bottom_navigation_button.dart";
import "package:lfti_app/components/summary_card.dart";

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/Session.dart";
import "package:lfti_app/classes/Routine.dart";
import "package:lfti_app/classes/User.dart";

// firestore imports
import "package:cloud_firestore/cloud_firestore.dart";

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

  int getTotalNumberOfExercises() {
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
        "name": _session.workout.name,
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

  void _formatElapseTime() {
    RegExp exp = new RegExp(r"(\d\d)");
    Iterable<RegExpMatch> matches = exp.allMatches(_session.totalElapsetime);
    print(matches.elementAt(0).group(0));
  }

  @override
  Widget build(BuildContext context) {
    void _navigate() {
      _updateLastSession();
      Navigator.pushNamed(
        context,
        "/dashboard",
        arguments: _currentUser,
      );
    }

    _formatElapseTime();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Session Summary",
          style: kMediumBoldTextStyle,
        ),
      ),
      body: Padding(
        padding: kContentPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SummaryCard(
              label: "NAME",
              data: _session.workout.name,
              style: kMediumBoldTextStyle,
            ),
            SummaryCard(
              label: "DESCRIPTION",
              data: _session.workout.description,
              style: kMediumBoldTextStyle,
            ),
            SummaryCard(label: "TIME", data: _session.totalElapsetime),
            // TODO: Compute for performed and skipped exercises
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SummaryCard(
                      label: "PERFORMED",
                      data: getTotalNumberOfExercises().toString(),
                      sub: "EXERCISES",
                    ),
                    SizedBox(height: kSizedBoxHeight * 3),
                    SummaryCard(
                        label: "SKIPPED",
                        data: getTotalNumberOfSets().toString(),
                        sub: "SETS"),
                  ],
                ),
                SizedBox(width: kSizedBoxHeight * 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SummaryCard(
                        label: "PERFORMED",
                        data: getTotalNumberOfSets().toString(),
                        sub: "SETS"),
                    SizedBox(height: kSizedBoxHeight * 3),
                    SummaryCard(
                      label: "SKIPPED",
                      data: "20",
                      sub: "EXERCISES",
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationButton(
          label: "DONE", action: _navigate, color: kBlueButtonColor),
    );
  }
}
