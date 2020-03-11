import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import "package:lfti_app/components/checklist.dart";
import "package:lfti_app/components/dashboard_card_tile.dart";
import 'package:lfti_app/classes/Constants.dart';
import 'package:lfti_app/components/custom_card.dart';

class DashboardPage extends StatefulWidget {
  final FirebaseUser _user;
  DashboardPage(this._user);

  @override
  _DashboardPageState createState() {
    return _DashboardPageState(_user);
  }
}

class _DashboardPageState extends State<DashboardPage> {
  FirebaseUser _user;
  _DashboardPageState(this._user);

  String _username;
  String _lastWorkoutName;
  String _lastWorkoutDescription;

  DatabaseReference _db = FirebaseDatabase.instance.reference();

  void getUserData() {
    _db.child('/users/' + _user.uid).once().then((ds) {
      setState(() {
        _username = ds.value['firstName'];
        _lastWorkoutName = ds.value['lastSession']['workout']['name'];
        _lastWorkoutDescription =
            ds.value['lastSession']['workout']['description'];
      });
    }).catchError((e) {
      print('error getting user data => ' + e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    getUserData();
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
          "Hello $_username!",
          style: kMediumBoldTextStyle,
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              child: DashboardCardTile(
                heading: 'LAST SESSION',
                mainInfo: _lastWorkoutName,
                details: _lastWorkoutDescription,
              ),
            ),
            Container(
              child: DashboardCardTile(
                heading: 'NEXT SESSION',
                mainInfo: 'Tuesday Arm Day',
                details: 'Legs',
              ),
            ),
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
