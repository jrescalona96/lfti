import 'package:flutter/material.dart';
import 'package:lfti_app/components/routine_card.dart';
import 'package:lfti_app/classes/Workout.dart';
import 'package:lfti_app/classes/Session.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewWorkoutPage extends StatelessWidget {
  final Workout _workout;
  ViewWorkoutPage(this._workout);

  Session createSession() {
    DateTime now = DateTime.now();
    String formattedDate = now.toString().substring(0, 10);
    return new Session(
      id: 1,
      name: formattedDate,
      workout: _workout,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_workout.name, style: kMediumBoldTextStyle),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                Widget item;
                if (index < _workout.routines.length) {
                  item = RoutineCard(_workout.routines[index]);
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
