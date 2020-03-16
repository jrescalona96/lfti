import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Exercise.dart';
import 'package:lfti_app/classes/Routine.dart';
import 'package:lfti_app/classes/Workout.dart';
import 'package:lfti_app/components/workout_card.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'package:lfti_app/screens/loading_screen.dart';

class SelectWorkoutPage extends StatefulWidget {
  final DocumentReference _ref;
  SelectWorkoutPage(this._ref);

  @override
  _SelectWorkoutPageState createState() => _SelectWorkoutPageState(_ref);
}

class _SelectWorkoutPageState extends State<SelectWorkoutPage> {
  DocumentReference _userDocumentRef;
  DocumentSnapshot _userDocumentSnapshot;

  _SelectWorkoutPageState(ref) {
    this._userDocumentRef = ref;
  }

  void _init() async {
    var ds = await _userDocumentRef.get();
    setState(() {
      _userDocumentSnapshot = ds;
    });
  }

  Widget _buildWorkoutsList() {
    _init();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SELECT WORKOUT",
          style: kMediumBoldTextStyle,
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                Widget item;
                if (index < _userDocumentSnapshot.data["workouts"].length) {
                  item = WorkoutCard(_buildWorkout(
                      _userDocumentSnapshot.data["workouts"][index]));
                }
                return item;
              }),
            ),
          ],
        ),
      ),
    );
  }

  Workout _buildWorkout(Map w) {
    return Workout(
        name: w["name"],
        description: w["description"],
        routines: _buildRoutine(w["routines"]));
  }

  List<Routine> _buildRoutine(List r) {
    int _defaultTime = 120;
    var routines = List<Routine>();
    //build routines
    for (var item in r) {
      routines.add(Routine(
        exercise: Exercise(
            name: item["exercise"]["name"], focus: item["exercise"]["name"]),
        reps: item["reps"],
        sets: item["sets"],
        timeToPerformInSeconds: item["timeToPerformInSeconds"] == null
            ? _defaultTime
            : item["timeToPerformInSeconds"],
      ));
    }
    return routines;
  }

  @override
  Widget build(BuildContext context) {
    _init();
    return _userDocumentSnapshot == null
        ? LoadingScreen()
        : _buildWorkoutsList();
  }
}
