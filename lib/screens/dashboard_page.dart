import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:lfti_app/components/checklist.dart";
import "package:lfti_app/components/dashboard_card_tile.dart";
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/components/custom_card.dart";

class DashboardPage extends StatefulWidget {
  final DocumentReference _dr;
  DashboardPage(this._dr);

  @override
  _DashboardPageState createState() {
    return _DashboardPageState(_dr);
  }
}

class _DashboardPageState extends State<DashboardPage> {
  DocumentReference _userDocumentRef;
  DocumentSnapshot _userDocumentSnapshot;
  var _lastWorkoutIndex;
  var _nextWorkoutIndex;

  _DashboardPageState(this._userDocumentRef);

  void _init() async {
    var ds = await _userDocumentRef.get();
    setState(() {
      _userDocumentSnapshot = ds;
      _lastWorkoutIndex = _userDocumentSnapshot.data["lastSession"]["index"];
      _nextWorkoutIndex = _userDocumentSnapshot.data["nextSession"]["index"];
    });
  }

  @override
  Widget build(BuildContext context) {
    _init();
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
          "Hello " + _userDocumentSnapshot.data["firstName"] + "!",
          style: kMediumBoldTextStyle,
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              child: DashboardCardTile(
                  heading: "LAST SESSION",
                  mainInfo: _userDocumentSnapshot.data["workouts"]
                      [_lastWorkoutIndex]["name"],
                  details: _userDocumentSnapshot.data["workouts"]
                      [_lastWorkoutIndex]["description"]),
            ),
            Container(
              child: DashboardCardTile(
                heading: "NEXT SESSION",
                mainInfo: _userDocumentSnapshot.data["workouts"]
                    [_nextWorkoutIndex]["name"],
                details: _userDocumentSnapshot.data["workouts"]
                    [_nextWorkoutIndex]["description"],
              ),
            ),
            // TODO: implement google maps
            // Container(
            //   child: DashboardCardTile(
            //       heading: "NEAREST GYM LOCATION",
            //       mainInfo: "LA Fitness (2.0 miles)",
            //       details: "La Verne, CA 91768"),
            // ),
            // checklist section
            CustomCard(
              cardChild: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("CHECKLIST", style: kLabelTextStyle),
                    Checklist(_userDocumentSnapshot.data["checklist"]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () => Navigator.pushNamed(context, "/selectWorkout"),
        child: Container(
          color: kStartButtonColor,
          height: kStartButtonHeight,
          alignment: Alignment.center,
          child: Text(
            "LET'S GO!",
            style: kButtonBoldTextFontStyle,
          ),
        ),
      ),
    );
  }
}
