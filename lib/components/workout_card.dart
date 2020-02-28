import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Workout.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'package:lfti_app/components/card_template.dart';

class WorkoutCard extends StatelessWidget {
  //working data TODO: update to pull for DB
  final Workout _workout;
  WorkoutCard(this._workout);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/viewWorkout', arguments: _workout);
      },
      child: Container(
        child: CardTemplate(
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
                _workout.routines.length.toString() + ' Exercises',
                style: kMediumBoldTextStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
