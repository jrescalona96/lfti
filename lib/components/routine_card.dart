import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Routine.dart';

const textGap = 5.0;

class RoutineCard extends StatelessWidget {
  //working data TODO: update to pull for DB
  final Routine _routine;
  RoutineCard(this._routine);

  String _generateTarget() {
    String target = '';
    String reps = _routine.reps.toString();
    // TODO: refactor to have Rest as its own class to say if(_routine.exercise is Rest)
    if (_routine.exercise.name != 'Rest')
      for (int i = 0; i < _routine.sets; i++) {
        if (i < (_routine.sets - 1)) {
          target += '$reps / ';
        } else {
          target += reps;
        }
      }
    else {
      target = _routine.timeToPerformInSeconds.toString() + ' sec';
    }
    return target;
  }

  @override
  Widget build(BuildContext context) {
    final exerciseName = _routine.exercise.name;
    final exerciseBodyPart = _routine.exercise.bodyPart;
    final exerciseTarget = "Target: " + _generateTarget();

    return Material(
      child: Container(
        // TODO: Show more information about the workout?
        padding: EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.white10),
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    exerciseName,
                    style: Theme.of(context).textTheme.body1,
                  ),
                  SizedBox(height: textGap),
                  Text(
                    exerciseBodyPart,
                    style: Theme.of(context).textTheme.display1,
                  ),
                ],
              ),
            ),
            Text(exerciseTarget, style: Theme.of(context).textTheme.display2)
          ],
        ),
      ),
    );
  }
}
