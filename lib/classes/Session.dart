import 'package:lfti_app/classes/Exercise.dart';
import "package:lfti_app/classes/Workout.dart";
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

  Routine getCurrentRoutine() {
    Routine r;
    try {
      r = _workout.routines[_currentRoutineIndex];
    } catch (e) {
      print("Accessed invalid routine index. " + e.toString());
    }
    return r;
  }

  Routine getNextRoutine() {
    try {
      return _workout.routines[_currentRoutineIndex + 1];
    } catch (e) {
      print("No more routines left. " + e.toString());
      return Routine(
        exercise: Exercise(name: "Last Exercise"),
        reps: 0,
        sets: 0,
      );
    }
  }

  bool isFinished() {
    int totalRoutineCount = _workout.routines.length - 1;
    int totalSetCount = getCurrentRoutine().sets - 1;
    return _currentRoutineIndex >= totalRoutineCount &&
        _currentSet >= totalSetCount - 1;
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
    if (this._currentSet < getCurrentRoutine().sets) {
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
    if (this._currentRoutineIndex < _workout.routines.length) {
      this._currentRoutineIndex++;
      print("Session next routine was called!");
    }
  }

  void previousRoutine() {
    if (_currentRoutineIndex > 0) {
      this._currentRoutineIndex--;
    }
  }

  void skip() {
    print("Skipped => " + getCurrentRoutine().exercise.name);
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

  bool hasNext() {
    return _currentRoutineIndex >= _workout.routines.length &&
        _currentSet >= getCurrentRoutine().sets - 1;
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
      Routine r = getWorkout().routines[i];
      if (r.exercise.name != "Rest") {
        _skippedRoutines.add(r);
        _skippedSets = this._skippedSets + r.sets;
      }
    }
  }
}
