import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/User.dart";
import "package:lfti_app/classes/Workout.dart";

// component imports
import "package:lfti_app/components/custom_card.dart";
import "package:lfti_app/components/workout_card.dart";
import "package:lfti_app/components/menu.dart";

// firestore import
import "package:cloud_firestore/cloud_firestore.dart";

class EditWorkoutPage extends StatefulWidget {
  final User _currentUser;
  EditWorkoutPage(this._currentUser);

  @override
  _EditWorkoutPageState createState() => _EditWorkoutPageState(_currentUser);
}

class _EditWorkoutPageState extends State<EditWorkoutPage> {
  final User _currentUser;
  List<Workout> _workoutList;

  _EditWorkoutPageState(this._currentUser) {
    this._workoutList = _currentUser.getWorkoutList();
  }

  void _addNewWorkout() {
    // Navigator.pushNamed(context, "/viewWorkouts", arguments: _currentUser);
    print("Add a new workout");
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
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(
          "Workouts",
          style: kMediumTextStyle,
        ),
      ),
      drawer: Menu(_currentUser),
      body: SafeArea(
        child: _workoutList != null
            ? CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      Widget item;
                      if (index < _currentUser.getWorkoutList().length) {
                        item = WorkoutCard(_currentUser, index);
                      } else if (index ==
                          _currentUser.getWorkoutList().length) {
                        item = CustomCard(
                          cardChild: Icon(
                            FontAwesomeIcons.plus,
                            size: 24.0,
                          ),
                          cardAction: _addNewWorkout,
                        );
                      }
                      return item;
                    }),
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Nothing here yet!",
                      style: kMediumBoldTextStyle,
                    ),
                    Text(
                      "Create workout routines first.",
                      style: kMediumLabelTextStyle,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
