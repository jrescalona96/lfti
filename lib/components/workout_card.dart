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
    _setWorkout();
  }

  void _setWorkout() {
    this._workout = _currentUser.getWorkoutAt(_index);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/viewWorkout',
            arguments: {"user": _currentUser, "workout": _workout});
      },
      child: Container(
        child: CustomCard(
          cardChild: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                _workout.name,
                style: kMediumBoldTextStyle,
              ),
              Text(
                _workout.description,
                style: kLabelTextStyle,
              ),
              SizedBox(height: kSizedBoxHeight),
              Text(
                _workout == null
                    ? "No Exercises"
                    : _workout.routines.length.toString() + ' Exercises',
                style: kMediumBoldTextStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
