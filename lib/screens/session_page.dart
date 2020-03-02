import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'package:lfti_app/classes/Session.dart';
import 'package:lfti_app/components/custom_card.dart';
import 'package:lfti_app/classes/Routine.dart';
import 'package:lfti_app/classes/Workout.dart';
import 'package:lfti_app/components/timer_card.dart';

class SessionPage extends StatefulWidget {
  final Session session;
  SessionPage({Key key, @required this.session}) : super(key: key);
  @override
  _SessionPageState createState() => _SessionPageState(session: session);
}

class _SessionPageState extends State<SessionPage> {
  final Session session;
  _SessionPageState({this.session});

  int _routineIndex = 0;
  int _setsCounter = 0;
  final _setsTimer = TimerCard(); //create new set timer

  void _nextRoutine() {
    setState(() {
      _routineIndex++;
      //TODO: reset timer
    });
  }

  void _previousRoutine() {
    setState(() {
      _routineIndex--;
    });
  }

  void _nextSet() {
    setState(() {
      _setsCounter++;
    });
  }

  void _previousSet() {
    setState(() {
      _setsCounter--;
    });
  }

  void _resetSetCounter() {
    setState(() {
      _setsCounter = 0;
    });
  }

  void _resetRoutineIndex() {
    setState(() {
      _routineIndex = 0;
    });
  }

  void _resetAll() {
    _resetSetCounter();
    _resetRoutineIndex();
    // _resetTimer;
  }

  @override
  Widget build(BuildContext context) {
    Workout _workout = session.workout;
    Routine _currentRoutine = _workout.routines[_routineIndex];
    String _nextRoutineName = _routineIndex < _workout.routines.length - 1
        ? _workout.routines[_routineIndex + 1].exercise.name
        : 'Done';
    String _currentExerciseName = _currentRoutine.exercise.name;
    String _target = _currentExerciseName == 'Rest'
        ? _currentRoutine.timeToPerformInSeconds.toString()
        : _currentRoutine.reps.toString();
    //TODO: Consider making separate screen for Rest periods or have the target count down
    String _targetUnit = _currentExerciseName == 'Rest' ? ' sec' : ' reps';

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Excercise Section
            CustomCard(
              cardChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Exercise Name Section
                  Text(
                    'EXCERCISE',
                    style: kLabelTextStyle,
                  ),
                  Text(
                    _currentExerciseName,
                    style: kMediumBoldTextStyle,
                  ),
                  SizedBox(
                    height: kSizedBoxHeight,
                  ),

                  // Target Section
                  Text(
                    'TARGET',
                    style: kLabelTextStyle,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(_target, style: kLargeBoldTextStyle1x),
                      Text(
                        _targetUnit,
                        style: kUnitLabelTextStyle,
                      ),
                    ],
                  ),
                  SizedBox(height: kSizedBoxHeight),

                  // Sets Section
                  Text(
                    'SETS',
                    style: kLabelTextStyle,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        _setsCounter.toString(),
                        style: kLargeBoldTextStyle2x,
                      ),
                      Text(
                        '/' + _currentRoutine.sets.toString(),
                        style: kLargeBoldTextStyle2x,
                      ),
                      Text(
                        ' sets',
                        style: kUnitLabelTextStyle,
                      )
                    ],
                  ),
                ],
              ),
            ),

            // Routine Navigation Buttons Section
            Container(
              padding: kContentPadding,
              child: Row(
                children: <Widget>[
                  // Back Button
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                        child: Text(
                          'BACK',
                          style: kButtonTextFontStyle,
                        ),
                        color: Colors.deepOrange,
                        disabledColor: Colors.white30,
                        onPressed: () {
                          // TODO: Reset Timer
                          if (_routineIndex > 0) {
                            if (_setsCounter > 0) {
                              _previousSet();
                            } else {
                              _resetSetCounter();
                              _previousRoutine();
                            }
                          }
                        }),
                  ),

                  SizedBox(width: kSizedBoxHeight),
                  // Next Button
                  Expanded(
                    flex: 2,
                    child: RaisedButton(
                        child: Text(
                          'NEXT',
                          style: kButtonTextFontStyle,
                        ),
                        onPressed: () {
                          // TODO: Reset Timer

                          if (_workout.isCompleted(_routineIndex)) {
                            _resetAll(); // TODO: remove after implementing navigation
                            print('Navigate to Workout Completed Page');
                          } else {
                            if (_currentRoutine.isCompleted(_setsCounter)) {
                              _resetSetCounter();
                              _nextRoutine();
                            } else {
                              _nextSet();
                            }
                          }
                        }),
                  ),
                ],
              ),
            ),

            // Next Routine Section
            CustomCard(
              cardChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'NEXT',
                    style: kLabelTextStyle,
                  ),
                  Text(
                    _nextRoutineName,
                    style: kMediumBoldTextStyle,
                  ),
                ],
              ),
            ),

            // Timer Section
            CustomCard(
              cardChild: _setsTimer,
            ),
          ],
        ),
      ),
    );
  }
}
