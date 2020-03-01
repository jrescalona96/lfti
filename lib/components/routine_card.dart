import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'package:lfti_app/classes/Routine.dart';
import 'package:lfti_app/components/custom_card.dart';

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

    return CustomCard(
      cardChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                exerciseName,
                style: kMediumBoldTextStyle,
              ),
              SizedBox(
                height: kSmallSizedBoxHeight,
              ),
              Text(
                exerciseBodyPart,
                style: kLabelTextStyle,
              ),
            ],
          ),
          SizedBox(height: kSizedBoxHeight),
          Text(exerciseTarget, style: kMediumLabelTextStyle)
        ],
      ),
    );
  }
}
