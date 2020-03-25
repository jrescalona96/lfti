import "package:flutter/material.dart";

// Class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/Session.dart";
import "package:lfti_app/classes/User.dart";
import "package:lfti_app/classes/Routine.dart";

// Component imports
import "package:lfti_app/components/custom_card.dart";
import "package:lfti_app/components/timer_card.dart";
import "package:lfti_app/components/bottom_navigation_button.dart";

class SessionPage extends StatefulWidget {
  final User _currentUser;
  SessionPage(this._currentUser);

  @override
  _SessionPageState createState() => _SessionPageState(_currentUser);
}

class _SessionPageState extends State<SessionPage> {
  User _currentUser;
  Session _session;
  int _currentSet;
  Routine _currentRoutine;

  _SessionPageState(this._currentUser) {
    this._session = _currentUser.getSession();
    this._currentSet = 1;
    this._currentRoutine = _session.getCurrentRoutine();
  }

  bool _sessionIsPaused = false;
  final _routineTimerController = TimerCard(cardLabel: "ROUTINE TIME");
  final _sessionTimerController = TimerCard(cardLabel: "SESSION TIME");

  void _navigateToDashboard() {
    Navigator.pushNamed(context, "/endSession",
        arguments: {"user": _currentUser, "session": _session});
  }

  void _endSession() {
    setState(() {
      _session.end(_sessionTimerController.getCurrentTime());
      _navigateToDashboard();
    });
  }

  bool _isFirstRoutineAndSet() {
    return _session.getCurrentRoutineIndex() == 0 &&
        _session.getCurrentSet() == 1;
  }

  void _next() {
    _routineTimerController.restart();
    _session.next();
    setState(() {
      _currentSet = _session.getCurrentSet();
      _currentRoutine = _session.getCurrentRoutine();
    });
  }

  void _back() {
    _routineTimerController.restart();
    _session.previous();
    setState(() {
      _currentSet = _session.getCurrentSet();
      _currentRoutine = _session.getCurrentRoutine();
    });
  }

  void _skipRoutine() {
    _routineTimerController.restart();
    _session.skip();
    setState(() {
      _currentSet = _session.getCurrentSet();
      _currentRoutine = _session.getCurrentRoutine();
    });
  }

  void _init() {
    // Run Timer at navigate
    _routineTimerController.start();
    _sessionTimerController.start();

    _session.isPaused
        ? _routineTimerController.pause()
        : _routineTimerController.start();
    _currentSet = _session.getCurrentSet();
    _currentRoutine = _session.getCurrentRoutine();
  }

  void _togglePause() {
    setState(() {
      _session.togglePause();
    });
  }

  @override
  Widget build(BuildContext context) {
    _init();
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Excercise Section
              Expanded(
                child: CustomCard(
                  cardChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      // Exercise Name Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "EXERCISE",
                            style: kLabelTextStyle,
                          ),
                          Text(
                            _session.getCurrentRoutine().exercise.name,
                            style: kMediumBoldTextStyle,
                          ),
                        ],
                      ),
                      // Target Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "TARGET",
                            style: kLabelTextStyle,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              Text(
                                  _currentRoutine.exercise.name == "Rest"
                                      ? _currentRoutine.timeToPerformInSeconds
                                          .toString()
                                      : _currentRoutine.reps.toString(),
                                  style: kLargeBoldTextStyle1x),
                              Text(
                                _currentRoutine.exercise.name == "Rest"
                                    ? " seconds"
                                    : " reps",
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
                            "SETS",
                            style: kLabelTextStyle,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              Text(
                                _currentSet.toString(),
                                style: kLargeBoldTextStyle1_5x,
                              ),
                              Text(
                                " / " + _currentRoutine.sets.toString(),
                                style: kLargeBoldTextStyle1_5x,
                              ),
                              Text(
                                " sets",
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
                        onPressed: _session.isPaused || _isFirstRoutineAndSet()
                            ? null
                            : _back,
                        child: Text(
                          "BACK",
                          style: kButtonBoldTextFontStyle,
                        ),
                        color: kRedButtonColor,
                      ),
                    ),

                    SizedBox(width: kSizedBoxHeight),

                    // Next Button
                    Expanded(
                      flex: 2,
                      child: RaisedButton(
                        onPressed: _session.isPaused || _session.isFinished()
                            ? null
                            : _next,
                        onLongPress: _session.isPaused || _session.isFinished()
                            ? null
                            : _skipRoutine,
                        child: Text(
                          "NEXT",
                          style: kButtonBoldTextFontStyle,
                        ),
                        color: kGreenButtonColor,
                      ),
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
                      "NEXT ROUTINE",
                      style: kLabelTextStyle,
                    ),
                    Text(
                      _session.getNextRoutine().exercise.name,
                      style: kMediumBoldTextStyle,
                    ),
                  ],
                ),
              ),

              // Timer Section
              Container(
                child: Row(
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
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        child: GestureDetector(
            onLongPress: () {
              _endSession();
            },
            child: _session.isFinished()
                ? BottomNavigationButton(
                    label: "END", action: _endSession, color: kRedButtonColor)
                : BottomNavigationButton(
                    label: _session.isPaused ? "CONTINUE" : "PAUSE",
                    action: _togglePause,
                    color: _session.isPaused
                        ? kGreenButtonColor
                        : kBlueButtonColor,
                  )),
      ),
    );
  }
}
