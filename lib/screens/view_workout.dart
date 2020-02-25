import 'package:flutter/material.dart';
import 'package:lfti_app/components/routine_card.dart';
import 'package:lfti_app/classes/Workout.dart';
import 'package:lfti_app/classes/Session.dart';

const startButtonHeight = 80.0;
const startButtonColor = Colors.blueAccent;

class ViewWorkout extends StatelessWidget {
  final Workout workout;
  ViewWorkout({Key key, @required this.workout}) : super(key: key);

  Session createSession() {
    return Session(
        id: 1,
        name: workout.name + " #1",
        workout: workout,
        totalTimeInSeconds: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          workout.name,
          style: Theme.of(context).textTheme.subhead,
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/startSession',
              arguments: createSession());
        },
        child: Container(
          color: startButtonColor,
          height: startButtonHeight,
          alignment: Alignment.center,
          child: Text(
            'Start',
            style: Theme.of(context).textTheme.subhead,
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  Widget item;
                  if (index < workout.routines.length) {
                    item = RoutineCard(workout.routines[index]);
                  }
                  return item;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
