import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'package:lfti_app/classes/Routine.dart';
import 'package:lfti_app/components/custom_card.dart';

class RoutineCard extends StatelessWidget {
  final routine;
  final Function onTap;
  final bool dottedBorder;
  RoutineCard({@required this.routine, this.onTap, this.dottedBorder = false});

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
    return GestureDetector(
      onTap: this.onTap,
      child: CustomCard(
        dottedBorder: this.dottedBorder,
        cardChild: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  routine.exercise.name,
                  style: kMediumBoldTextStyle,
                ),
                SizedBox(
                  height: kSmallSizedBoxHeight,
                ),
                Text(
                  routine.exercise.focus == null ? "" : routine.exercise.focus,
                  style: kLabelTextStyle,
                ),
              ],
            ),
            SizedBox(height: kSizedBoxHeight),
            Text("Target: " + _generateTargetString(),
                style: kMediumLabelTextStyle)
          ],
        ),
      ),
    );
  }
}
