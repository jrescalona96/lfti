import 'package:flutter/services.dart';
import "package:lfti_app/classes/Workout.dart";
import "package:lfti_app/classes/TimedRoutine.dart";
import "package:lfti_app/classes/Routine.dart";
import "package:intl/intl.dart";
import "package:lfti_app/classes/Constants.dart";

class Session {
  Workout _workout;
  String id;
  String _elapseTime;
  String date;
  int _currentSet = 1;
  int _currentRoutineIndex = 0;
  int _skippedSets = 0;
  int _performedSets = 0;
  bool isPaused = false;
  final _skippedRoutines =
      List<Routine>(); // List implemented as a Stack, no Stack class in Dart
  final _performedRoutines =
      List<Routine>(); // List implemented as a Stack, no Stack class in Dart

  Session(this._workout) {
    this.id = "S" + DateFormat(kFormatDateId).format(DateTime.now());
    this.date = DateFormat(kFormatDateMMddyyyy).format(DateTime.now());
  }

  // getters
  Workout getWorkout() {
    return this._workout;
  }

  List<Routine> getSkippedRoutines() {
    return this._skippedRoutines;
  }

  List<Routine> getPerformedRoutines() {
    return this._performedRoutines;
  }

  int getSkippedSets() {
    return this._skippedSets;
  }

  int getPerformedSets() {
    return this._performedSets;
  }

  int getCurrentRoutineIndex() {
    return this._currentRoutineIndex;
  }

  dynamic getCurrentRoutine() {
    try {
      return _workout.routines[_currentRoutineIndex];
    } catch (e) {
      print("Accessed invalid Routine index. " + e.toString());
    }
  }

  Routine getNextRoutine() {
    try {
      if (!isLastRoutine()) return _workout.routines[_currentRoutineIndex + 1];
    } catch (e) {
      print("Error: Next routine index invalid " + e.toString());
    }
  }

  bool isFinished() {
    return isLastRoutine() && isLastSet();
  }

  int getCurrentSet() {
    return _currentSet;
  }

  String getElapseTime() {
    return this._elapseTime;
  }

  void togglePause() {
    this.isPaused ? this.isPaused = false : this.isPaused = true;
  }

  void _setElapseTime(String t) {
    this._elapseTime = t;
  }

  void next() {
    this._performedSets++;
    if (!isLastSet()) {
      this._currentSet++;
    } else {
      this._currentSet = 1;
      this._performedRoutines.add(getCurrentRoutine());
      nextRoutine();
    }
    print("Session next was called!");
  }

  void previous() {
    this._performedSets--;
    if (this._currentSet > 1) {
      // not first set
      this._currentSet--;
    } else {
      this._performedRoutines.removeLast();
      if (_currentRoutineIndex > 0) {
        // not first routine
        _currentSet = getCurrentRoutine().sets;
        previousRoutine();
      } else {
        // first routine
        _currentSet = 1;
      }
    }
  }

  void nextRoutine() {
    if (!isLastRoutine()) {
      this._currentRoutineIndex++;
    }
  }

  void previousRoutine() {
    if (_currentRoutineIndex > 0) {
      this._currentRoutineIndex--;
    }
  }

  void skip() {
    // remainingSets offset by 1 since _currentSet starts at 1
    int performedSets = _currentSet - 1;
    int remainingSets = getCurrentRoutine().sets - performedSets;

    if (getCurrentRoutine().exercise.name != "Rest") {
      this._skippedSets = this._skippedSets + remainingSets;
      if (_currentSet <= 1) {
        // entire routine is skipped
        this._skippedRoutines.add(getCurrentRoutine());
      } else {
        // some sets performed
        this._performedRoutines.add(getCurrentRoutine());
      }
    }
    nextRoutine();
  }

  bool isLastRoutine() {
    return _currentRoutineIndex >= _workout.routines.length - 1;
  }

  bool isLastSet() {
    return _currentSet >= getCurrentRoutine().sets;
  }

  bool hasNext() {
    return !isLastRoutine() || !isLastSet();
  }

  bool isRoutineDone() {
    return _currentSet >= getCurrentRoutine().sets - 1;
  }

  void end(String t) {
    _setElapseTime(t);
    // add sets performed on current routine
    skip();
    for (int i = _currentRoutineIndex + 1;
        i < getWorkout().routines.length;
        i++) {
      var r = getWorkout().routines[i];
      if (r.exercise.name != "Rest") {
        _skippedRoutines.add(r);
        _skippedSets = this._skippedSets + r.sets;
      }
    }
  }
}
