import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Workout.dart';
import 'package:lfti_app/components/workout_card.dart';
import 'package:lfti_app/classes/WorkoutsGenerator.dart';
import 'package:lfti_app/classes/Constants.dart';

class SelectWorkoutPage extends StatefulWidget {
  @override
  _SelectWorkoutPageState createState() => _SelectWorkoutPageState();
}

class _SelectWorkoutPageState extends State<SelectWorkoutPage> {
  List<Workout> workoutList = WorkoutsGenerator().fetchAllWorkouts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CHOOSE WORKOUT",
          style: kMediumBoldTextStyle,
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                Widget item;
                if (index < workoutList.length) {
                  item = Column(
                    children: <Widget>[
                      WorkoutCard(
                        workoutList[index],
                      ),
                    ],
                  );
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
