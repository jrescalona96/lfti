import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'package:lfti_app/classes/Session.dart';
import 'package:lfti_app/components/card_template.dart';

class SessionPage extends StatefulWidget {
  final Session session;
  SessionPage({Key key, @required this.session}) : super(key: key);
  @override
  _SessionPageState createState() => _SessionPageState(session: session);
}

class _SessionPageState extends State<SessionPage> {
  final Session session;
  _SessionPageState({this.session});

  int _currentRoutine = 0;
  int _setCounter = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CardTemplate(
          cardChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Exercise
              Text(
                'EXCERCISE',
                style: kLabelTextStyle,
              ),
              Text(
                // exercise name
                session.workout.routines[_currentRoutine].exercise.name,
                style: Theme.of(context).textTheme.subhead,
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: kSizedBoxHeight,
              ),
              // Target
              Text(
                'TARGET',
                style: kLabelTextStyle,
              ),
              Text(
                session.workout.routines[_currentRoutine].reps.toString() +
                    ' reps',
                style: kLargeBoldTextStyle1x,
              ),
              SizedBox(height: kSizedBoxHeight),
              Text(
                'SETS',
                style: kLabelTextStyle,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  Text(
                    _setCounter.toString(),
                    style: kLargeBoldTextStyle2x,
                  ),
                  Text(
                    '/' +
                        session.workout.routines[_currentRoutine].sets
                            .toString(),
                    style: kLargeBoldTextStyle2x,
                  ),
                  Text(' sets', style: kLargeBoldTextStyle1x)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
