import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'package:lfti_app/classes/Session.dart';
import 'package:lfti_app/components/custom_card.dart';
import 'package:lfti_app/classes/Routine.dart';
import 'package:lfti_app/classes/Workout.dart';
import 'package:lfti_app/components/timer_card.dart';
import "package:lfti_app/classes/User.dart";

class SessionPage extends StatefulWidget {
  SessionPage(Map args) {
    this._session = args["session"];
    this._user = args["user"];
  }

  Session _session;
  User _user;

  @override
  _SessionPageState createState() => _SessionPageState(_session, _user);
}

class _SessionPageState extends State<SessionPage> {
  final User _currentUser;
  final Session _session;
  _SessionPageState(this._session, this._currentUser);

  int _routineIndex = 0;
  int _setsCounter = 0;
  bool _sessionIsPaused = false;
  final _routineTimerController = TimerCard(cardLabel: 'ROUTINE TIME');
  final _sessionTimerController = TimerCard(cardLabel: 'SESSION TIME');

  void _nextRoutine() {
    setState(() {
      _routineIndex++;
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

  // reset functions
  void _resetSetCounterTo(int sets) {
    setState(() {
      _setsCounter = sets;
    });
  }

  void _resetRoutineIndex() {
    setState(() {
      _routineIndex = 0;
    });
  }

  void _resetAll() {
    _resetSetCounterTo(0);
    _resetRoutineIndex();
    _routineTimerController.restart();
  }

  void _navigateToDashboard() {
    Navigator.pushNamed(context, '/endSession',
        arguments: {"user": _currentUser, "session": _session});
  }

  @override
  Widget build(BuildContext context) {
    // Run Timer at navigate
    _routineTimerController.start();
    _sessionTimerController.start();
    // Timer Pause/Run
    _sessionIsPaused
        ? _routineTimerController.pause()
        : _routineTimerController.start();

    // Session Page Initialization
    Workout _workout = _session.workout;
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
            Expanded(
              child: CustomCard(
                cardChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Exercise Name Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'EXERCISE',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          _currentExerciseName,
                          style: kMediumBoldTextStyle,
                        ),
                      ],
                    ),
                    // Target Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                      ],
                    ),

                    // Sets Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                              style: kLargeBoldTextStyle1_5x,
                            ),
                            Text(
                              ' / ' + _currentRoutine.sets.toString(),
                              style: kLargeBoldTextStyle1_5x,
                            ),
                            Text(
                              ' sets',
                              style: kUnitLabelTextStyle,
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Routine Navigation Buttons Section
            Container(
              padding: kContentPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Back Button
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                        child: Text(
                          'BACK',
                          style: kButtonTextFontStyle,
                        ),
                        color: kRedButtonColor,
                        onPressed: _sessionIsPaused ||
                                _routineIndex == 0 && _setsCounter == 0
                            ? null
                            : () {
                                _routineTimerController.restart();
                                // TODO: Simplify logic here
                                if (_routineIndex >= 0) {
                                  if (_setsCounter > 0) {
                                    _previousSet();
                                  } else if (_routineIndex > 0) {
                                    // fist excercise but sets != 0
                                    _resetSetCounterTo(_currentRoutine.sets);
                                    _previousRoutine();
                                  } else {
                                    // sets and exercise at beginning
                                    _resetSetCounterTo(0);
                                  }
                                }
                              }),
                  ),

                  // TODO: rename constant to "spacer"
                  SizedBox(width: kSizedBoxHeight),

                  // Next Button
                  Expanded(
                    flex: 2,
                    child: RaisedButton(
                        color: kGreenButtonColor,
                        child: Text(
                          'NEXT',
                          style: kButtonTextFontStyle,
                        ),
                        onPressed: _sessionIsPaused ||
                                _routineIndex >= _workout.routines.length - 1
                            ? null
                            : () {
                                _routineTimerController.restart();
                                if (_workout.isCompleted(_routineIndex)) {
                                  _resetAll(); // TODO: remove after implementing navigation

                                } else {
                                  if (_currentRoutine
                                      .isCompleted(_setsCounter)) {
                                    _resetSetCounterTo(0);
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

            // Next Routine View Section
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
            Row(
              children: <Widget>[
                Expanded(
                  child: CustomCard(
                    cardChild: _routineTimerController,
                  ),
                ),
                Expanded(
                  child: CustomCard(
                    cardChild: _sessionTimerController,
                  ),
                ),
              ],
            ),

            Container(
              padding: kContentPadding,
              child: GestureDetector(
                onLongPress: () {
                  _session.totalElapsetime =
                      _sessionTimerController.getCurrentTime();
                  _navigateToDashboard();
                },
                child: _session.isFinished(_routineIndex)
                    ? RaisedButton(
                        child: Text(
                          'END',
                          style: kButtonTextFontStyle,
                        ),
                        color: kRedButtonColor,
                        onPressed: () {
                          _session.totalElapsetime =
                              _sessionTimerController.getCurrentTime();
                          _navigateToDashboard();
                        })
                    : RaisedButton(
                        child: Text(
                          _sessionIsPaused ? 'GO' : 'PAUSE',
                          style: kButtonTextFontStyle,
                        ),
                        color: _sessionIsPaused
                            ? kGreenButtonColor
                            : kBlueButtonColor,
                        onPressed: () {
                          setState(() {
                            _sessionIsPaused
                                ? _sessionIsPaused = false
                                : _sessionIsPaused = true;
                          });
                        }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
