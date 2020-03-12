import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import "package:lfti_app/components/checklist.dart";
import "package:lfti_app/components/dashboard_card_tile.dart";
import 'package:lfti_app/classes/Constants.dart';
import 'package:lfti_app/components/custom_card.dart';

class DashboardPage extends StatefulWidget {
  final DataSnapshot _ds;
  DashboardPage(this._ds);

  @override
  _DashboardPageState createState() {
    return _DashboardPageState(_ds);
  }
}

class _DashboardPageState extends State<DashboardPage> {
  DataSnapshot _userDataSnapshot;
  _DashboardPageState(this._userDataSnapshot);

  int _lastWorkoutIndex;
  int _nextWorkoutIndex;

  void _init() {
    setState(() {
      _lastWorkoutIndex = _userDataSnapshot.value['lastSession']['index'];
      _nextWorkoutIndex = _userDataSnapshot.value['nextSession']['index'];
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
          "Hello " + _userDataSnapshot.value['firstName'] + '!',
          style: kMediumBoldTextStyle,
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              child: DashboardCardTile(
                  heading: 'LAST SESSION',
                  mainInfo: _userDataSnapshot.value['workouts']
                      [_lastWorkoutIndex]['name'],
                  details: _userDataSnapshot.value['workouts']
                      [_lastWorkoutIndex]['description']),
            ),
            Container(
              child: DashboardCardTile(
                heading: 'NEXT SESSION',
                mainInfo: _userDataSnapshot.value['workouts'][_nextWorkoutIndex]
                    ['name'],
                details: _userDataSnapshot.value['workouts'][_nextWorkoutIndex]
                    ['description'],
              ),
            ),
            // TODO: implement google maps
            Container(
              child: DashboardCardTile(
                  heading: 'NEAREST GYM LOCATION',
                  mainInfo: "LA Fitness (2.0 miles)",
                  details: "La Verne, CA 91768"),
            ),
            // checklist section
            CustomCard(
              cardChild: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('CHECKLIST', style: kLabelTextStyle),
                    Checklist(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/selectWorkout'),
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
