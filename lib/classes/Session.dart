import "package:lfti_app/classes/Workout.dart";
import "package:lfti_app/classes/Routine.dart";
import "package:intl/intl.dart";
import "package:lfti_app/classes/Constants.dart";

class Session {
  Workout _workout;
  String id;
  String _elapseTime;
  String date;
  int _currentSet = 0;
  int _currentRoutineIndex = 0;
  int _skippedSets = 0;
  int _performedSets = 0;
  bool isPaused = false;
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

  List getSkippedRoutines() {
    List skippedRoutines = List();
    getWorkout().routines.forEach((routine) {
      if (!_performedRoutines.contains(routine)) skippedRoutines.add(routine);
    });
    return skippedRoutines;
  }

  List<Routine> getPerformedRoutines() {
    return this._performedRoutines;
  }

  int getSkippedSets() {
    int total = 0;
    for (var item in getWorkout().routines) {
      if (item.exercise.name != "Rest") total += item.sets;
    }
    print("Total = $total");
    return total - this._performedSets;
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
    if (getCurrentRoutine().exercise.name != "Rest") this._performedSets++;
    if (!isLastSet()) {
      this._currentSet++;
    } else {
      if (!isLastRoutine()) {
        this._currentSet = 0;
        this._performedRoutines.add(getCurrentRoutine());
        nextRoutine();
      }
    }
  }

  void previous() {
    if (this._currentSet > 0) {
      // not first set
      this._performedSets--;
      this._currentSet--;
    } else {
      this._performedRoutines.removeLast();
      if (_currentRoutineIndex > 0) {
        // not first routine
        previousRoutine();
        _currentSet = getCurrentRoutine().sets - 1;
      } else {
        // first routine
        _currentSet = 0;
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
    int performedSets = _currentSet;
    int remainingSets = getCurrentRoutine().sets - performedSets;
    if (getCurrentRoutine().exercise.name != "Rest") {
      this._skippedSets = this._skippedSets + remainingSets;
      if (_currentSet > 0) {
        // entire routine is skipped
        if (!this._performedRoutines.contains(getCurrentRoutine()))
          this._performedRoutines.add(getCurrentRoutine());
      }
    }
    nextRoutine();
  }

  bool isLastRoutine() {
    return _currentRoutineIndex >= _workout.routines.length - 1;
  }

  bool isLastSet() {
    return _currentSet >= getCurrentRoutine().sets - 1;
  }

  bool hasNext() {
    return !isLastRoutine() || !isLastSet();
  }

  bool isRoutineDone() {
    return _currentSet >= getCurrentRoutine().sets - 1;
  }

  void end(String t) {
    _setElapseTime(t);
  }
}
