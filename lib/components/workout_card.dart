import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Workout.dart';

const textGap = 5.0;

class WorkoutCard extends StatelessWidget {
  //working data TODO: update to pull for DB
  final Workout _workout;
  WorkoutCard(this._workout);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/viewWorkout', arguments: _workout);
        },
        child: Container(
          padding: EdgeInsets.all(10),
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
                      _workout.name,
                      style: Theme.of(context).textTheme.body2,
                    ),
                    SizedBox(height: textGap),
                    Text(
                      _workout.description,
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ],
                ),
              ),
              Text(_workout.routines.length.toString() + ' Exercises',
                  style: Theme.of(context).textTheme.display2)
            ],
          ),
        ),
      ),
    );
  }
}
