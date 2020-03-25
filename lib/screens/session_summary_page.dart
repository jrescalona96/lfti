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
    int sum = 0;
    for (Routine r in _session.getWorkout().routines) {
      if (r.exercise.name != "Rest") sum += r.sets;
    }
    return sum;
  }

  int getTotalNumberOfExercises() {
    int sum = 0;
    for (Routine r in _session.getWorkout().routines) {
      if (r.exercise.name != "Rest") sum++;
    }
    return sum;
  }

  // update session obj and database
  void _updateLastSession() {
    try {
      _currentUser.setLastSession({
        "name": _session.getWorkout().name,
        "description": "Date: " +
            _session.date +
            " Time: " +
            _session.getElapseTime() +
            " sec",
        "date": _session.date
      });
      print("Success: Updated Session Object!");
    } catch (e) {
      print("Error: Unable to update user session object! " + e.toString());
    }

    try {
      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(_currentUser.getFirestoreReference(),
            {"lastSession": _currentUser.getLastSession()});
      });
      print("Success: Updated lastSession in database!");
    } catch (e) {
      print("Error: Unable to update user session object! " + e.toString());
    }
  }

  void _formatElapseTime() {
    RegExp exp = new RegExp(r"(\d\d)");
    Iterable<RegExpMatch> matches = exp.allMatches(_session.getElapseTime());
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
              data: _session.getWorkout().name,
              style: kMediumBoldTextStyle,
            ),
            SummaryCard(
              label: "DESCRIPTION",
              data: _session.getWorkout().description,
              style: kMediumBoldTextStyle,
            ),
            SummaryCard(label: "TIME", data: _session.getElapseTime()),
            // TODO: Compute for performed and skipped exercises
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SummaryCard(
                      label: "PERFORMED",
                      data: _session.getPerformedRoutines().length.toString(),
                      sub: "EXERCISES",
                    ),
                    SizedBox(height: kSizedBoxHeight * 3),
                    SummaryCard(
                      label: "SKIPPED",
                      data: _session.getSkippedRoutines().length.toString(),
                      sub: "EXERCISES",
                    ),
                  ],
                ),
                SizedBox(width: kSizedBoxHeight * 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SummaryCard(
                        label: "",
                        data: _session.getPerformedSets().toString(),
                        sub: "SETS"),
                    SizedBox(height: kSizedBoxHeight * 3),
                    SummaryCard(
                        label: "",
                        data: _session.getSkippedSets().toString(),
                        sub: "SETS"),
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
