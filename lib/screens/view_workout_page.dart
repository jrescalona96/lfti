import 'package:flutter/material.dart';
import 'package:lfti_app/components/routine_card.dart';
import 'package:lfti_app/classes/Workout.dart';
import 'package:lfti_app/classes/Session.dart';
import 'package:lfti_app/classes/Constants.dart';

class ViewWorkoutPage extends StatelessWidget {
  final Workout workout;
  ViewWorkoutPage({Key key, @required this.workout}) : super(key: key);

  Session createSession() {
    DateTime now = DateTime.now();
    String formattedDate = now.toString().substring(0, 10);
    return new Session(
      id: 1,
      name: formattedDate,
      workout: workout,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workout.name, style: kMediumBoldTextStyle),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                Widget item;
                if (index < workout.routines.length) {
                  item = RoutineCard(workout.routines[index]);
                }
                return item;
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        child: Container(
          color: kStartButtonColor,
          height: kStartButtonHeight,
          alignment: Alignment.center,
          child: Text(
            'Start',
            style: kMediumBoldTextStyle,
          ),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/startSession',
            arguments: createSession(),
          );
        },
      ),
    );
  }
}
