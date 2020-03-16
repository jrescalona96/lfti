import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:lfti_app/components/checklist.dart";
import "package:lfti_app/components/dashboard_card_tile.dart";
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/components/custom_card.dart";
import "package:lfti_app/screens/loading_screen.dart";

class DashboardPage extends StatefulWidget {
  final DocumentReference _ref;
  DashboardPage(this._ref);

  @override
  _DashboardPageState createState() {
    return _DashboardPageState(_ref);
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
      _lastWorkoutIndex = _userDocumentSnapshot.data["lastSessionIndex"];
      _nextWorkoutIndex = _userDocumentSnapshot.data["nextSessionIndex"];
    });
  }

  bool _isNotEmpty(String key) {
    return _userDocumentSnapshot.data[key].length > 0;
  }

  bool _isValidIndex(int index) {
    return index >= 0;
  }

  @override
  Widget build(BuildContext context) {
    _init();
    return _userDocumentSnapshot == null
        ? LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      // TODO: implement navbar drawer
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                },
              ),
              title: Text(
                _userDocumentSnapshot.data["firstName"],
                style: kMediumBoldTextStyle,
              ),
            ),
            body: Container(
              child: ListView(
                children: <Widget>[
                  Container(
                    child: DashboardCardTile(
                        heading: "LAST SESSION",
                        mainInfo: _isValidIndex(_lastWorkoutIndex)
                            ? _userDocumentSnapshot.data["workouts"]
                                [_lastWorkoutIndex]["name"]
                            : "Nothing here yet!",
                        details: _isValidIndex(_lastWorkoutIndex)
                            ? _userDocumentSnapshot.data["workouts"]
                                [_lastWorkoutIndex]["description"]
                            : "You have not done anyting yet."),
                  ),
                  Container(
                    child: DashboardCardTile(
                      heading: "NEXT SESSION",
                      mainInfo: _isValidIndex(_nextWorkoutIndex)
                          ? _userDocumentSnapshot.data["workouts"]
                              [_nextWorkoutIndex]["name"]
                          : "Nothing here yet!",
                      details: _isValidIndex(_nextWorkoutIndex)
                          ? _userDocumentSnapshot.data["workouts"]
                              [_nextWorkoutIndex]["name"]
                          : "Add new workout routines.",
                    ),
                  ),
                  CustomCard(
                    cardChild: _isNotEmpty("checklist")
                        ? _buildChecklist()
                        : DashboardCardTile(
                            heading: "CHECKLIST",
                            mainInfo: "Nothing here yet.",
                            details: "Create your checklist!",
                          ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: GestureDetector(
              onTap: () => Navigator.pushNamed(context, "/selectWorkout",
                  arguments: _userDocumentRef),
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

  Widget _buildChecklist() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(child: Text("CHECKLIST", style: kLabelTextStyle)),
          Checklist(_userDocumentSnapshot.data["checklist"])
        ],
      ),
    );
  }
}
