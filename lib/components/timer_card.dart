import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'dart:async';

class TimerCard extends StatefulWidget {
  @override
  _TimerCardState createState() {
    final _timerCardState = _TimerCardState();

    void resetTimer() {
      _timerCardState.resetTimer();
    }

    return _timerCardState;
  }
}

class _TimerCardState extends State<TimerCard> {
  Stopwatch _stopwatch = Stopwatch();
  String _timerString = '00:00';
  final duration = const Duration(seconds: 1);

  // immediately start timer once Time Card is created
  _TimerCardState() {
    startTimer();
  }

  void _startTimer() {
    Timer(duration, _keepRunning);
  }

  void _keepRunning() {
    if (_stopwatch.isRunning) {
      _startTimer();
    }
    setState(() {
      _updatedTimeString();
    });
  }

  void startTimer() {
    print('Start');
    _stopwatch.start();
    _startTimer();
  }

  void pauseTimer() {
    print('Pause');
    print(_stopwatch.isRunning);
    setState(() {
      _stopwatch.stop();
    });
  }

  void resetTimer() {
    print('Reset');
    setState(() {
      _stopwatch = Stopwatch();
    });
  }

  void _updatedTimeString() {
    int _seconds = (_stopwatch.elapsedMilliseconds ~/ 1000);
    setState(() {
      _timerString = ((_seconds ~/ 60).toString().padLeft(2, '0') +
          ':' +
          (_seconds % 60).toString().padLeft(2, '0'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('ELAPSE TIME', style: kLabelTextStyle),
          Text(
            _timerString,
            style: kMediumBoldTextStyle,
          ),
          // RaisedButton(
          //   color: Colors.green,
          //   child: Text('START'),
          //   onPressed: () {
          //     startTimer();
          //     _updatedTimeString();
          //   },
          // ),
          // RaisedButton(
          //   color: Colors.blue,
          //   child: Text('PAUSE'),
          //   onPressed: () {
          //     pauseTimer();
          //   },
          // ),
          // RaisedButton(
          //   color: Colors.red,
          //   child: Text('RESET'),
          //   onPressed: () {
          //     resetTimer();
          //   },
          // )
        ],
      ),
    );
  }
}
