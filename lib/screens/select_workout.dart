import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Workout.dart';
import 'package:lfti_app/components/workout_card.dart';
import 'package:lfti_app/classes/WorkoutsGenerator.dart';

class SelectWorkout extends StatefulWidget {
  @override
  _SelectWorkoutState createState() => _SelectWorkoutState();
}

class _SelectWorkoutState extends State<SelectWorkout> {
  List<Workout> workoutList = WorkoutsGenerator().fetchAllWorkouts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Choose Workout",
          style: Theme.of(context).textTheme.subhead,
          textAlign: TextAlign.left,
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                Widget item;
                if (index < workoutList.length) {
                  item = WorkoutCard(workoutList[index]);
                }
                return item;
              },
            ),
          ),
        ]),
      ),
    );
  }
}
