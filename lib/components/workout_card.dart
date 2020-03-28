import 'package:flutter/material.dart';

// class imports
import 'package:lfti_app/classes/Workout.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'package:lfti_app/classes/User.dart';

// component imports
import 'package:lfti_app/components/custom_card.dart';

class WorkoutCard extends StatelessWidget {
  final int index;
  final User user;
  Workout _workout;
  final Function onTap;
  bool dottedBorder;
  WorkoutCard({this.user, this.index, this.onTap, this.dottedBorder = false}) {
    this._workout = this.user.getWorkoutAt(index);
  }

  @override
  Widget build(BuildContext context) {
    String _getNumberOfRoutines() {
      int sum = 0;
      for (var item in _workout.routines) {
        if (item.exercise.name != "Rest") sum++;
      }
      return sum.toString();
    }

    return GestureDetector(
      onTap: this.onTap,
      child: CustomCard(
        dottedBorder: this.dottedBorder,
        cardChild: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              this._workout.name,
              style: kMediumBoldTextStyle,
            ),
            SizedBox(height: kSmallSizedBoxHeight),
            Text(
              this._workout.description,
              style: kLabelTextStyle,
            ),
            SizedBox(height: kSizedBoxHeight),
            Text(
              this._workout == null
                  ? "No Exercises"
                  : _getNumberOfRoutines() + ' Routines',
              style: kSmallTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
