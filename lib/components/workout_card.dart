import 'package:flutter/material.dart';
// class imports
import 'package:lfti_app/classes/Workout.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'package:lfti_app/classes/User.dart';

// component imports
import 'package:lfti_app/components/custom_card.dart';

class WorkoutCard extends StatelessWidget {
  //working data TODO: update to pull for DB
  final int _index;
  final User _currentUser;
  Workout _workout;

  WorkoutCard(this._currentUser, this._index) {
    this._workout = this._currentUser.getWorkoutAt(_index);
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
      onTap: () {
        Navigator.of(context).pushNamed('/viewWorkout',
            arguments: {"user": this._currentUser, "workout": this._workout});
      },
      onLongPress: () {
        Navigator.of(context).pushNamed('/updateWorkout',
            arguments: {"user": this._currentUser, "index": this._index});
      },
      child: CustomCard(
        cardChild: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              this._workout.name,
              style: kMediumBoldTextStyle,
            ),
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
