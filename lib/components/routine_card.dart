import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'package:lfti_app/classes/Routine.dart';
import 'package:lfti_app/components/custom_card.dart';

class RoutineCard extends StatelessWidget {
  //working data TODO: update to pull for DB
  final Routine routine;
  final Function cardAction;
  RoutineCard({@required this.routine, this.cardAction});

  String _generateTargetString() {
    String target = '';
    String reps = routine.reps.toString();

    // TODO: refactor to have Rest as its own class to say if(_routine.exercise is Rest)
    if (routine.exercise.name != 'Rest')
      for (int i = 0; i < routine.sets; i++) {
        if (i < (routine.sets - 1)) {
          target += '$reps / ';
        } else {
          target += reps;
        }
      }
    else {
      target = routine.timeToPerformInSeconds.toString() + ' sec';
    }
    return target;
  }

  @override
  Widget build(BuildContext context) {
    final exerciseName = routine.exercise.name;
    final exerciseFocus = routine.exercise.focus;
    final exerciseTarget = "Target: " + _generateTargetString();

    return GestureDetector(
      onLongPress: cardAction,
      child: CustomCard(
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
                  exerciseFocus,
                  style: kLabelTextStyle,
                ),
              ],
            ),
            SizedBox(height: kSizedBoxHeight),
            Text(exerciseTarget, style: kMediumLabelTextStyle)
          ],
        ),
      ),
    );
  }
}
