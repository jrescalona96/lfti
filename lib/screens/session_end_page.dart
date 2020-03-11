import 'package:flutter/material.dart';
import 'package:lfti_app/components/custom_card.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'package:lfti_app/classes/Session.dart';
import 'package:lfti_app/classes/Routine.dart';

class SessionEndPage extends StatelessWidget {
  final String username = "Mond";
  final Session session;
  SessionEndPage({@required this.session});

  int getTotalNumberOfSets() {
    int sumOfSets = 0;
    for (Routine r in session.workout.routines) {
      if (r.exercise.name != 'Rest') sumOfSets += r.sets;
    }
    return sumOfSets;
  }

  int getTotalNumberOfExercices() {
    int sumOfSets = 0;
    for (Routine r in session.workout.routines) {
      if (r.exercise.name != 'Rest') sumOfSets++;
    }
    return sumOfSets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // TODO: implement navbar drawer
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(
          "Hello $username!",
          style: kMediumBoldTextStyle,
        ),
      ),
      body: CustomCard(
        cardChild: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 100.0),
            Expanded(
              flex: 1,
              child: Text(
                'All done!',
                style: kLargeBoldTextStyle1_5x,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    'TIME',
                    style: kMediumBoldTextStyle,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        session.totalElapsetime,
                        style: kLargeBoldTextStyle2x,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'min : sec',
                        style: kMediumLabelTextStyle,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Session Name
                  Text(
                    session.name,
                    style: kMediumBoldTextStyle,
                  ),
                  // Workout Name
                  Text(
                    session.workout.name,
                    style: kMediumBoldTextStyle,
                  ),
                  // Total number of Excercises
                  Text(
                    getTotalNumberOfExercices().toString() + ' Exercices',
                    style: kMediumBoldTextStyle,
                  ),
                  // Total number of Sets
                  Text(
                    (getTotalNumberOfSets()).toString() + ' Sets',
                    style: kMediumBoldTextStyle,
                  )
                ],
              ),
            ),
          ],
        ),
      ),

      // Done Button
      bottomNavigationBar: GestureDetector(
          child: Container(
            color: kStartButtonColor,
            height: kStartButtonHeight,
            alignment: Alignment.center,
            child: Text(
              'Done',
              style: kMediumBoldTextStyle,
            ),
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              '/dashboard',
            );
          }),
    );
  }
}
