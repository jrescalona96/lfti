import 'package:lfti_app/classes/Workout.dart';

class Session {
  int id;
  String name;
  Workout workout;
  String totalElapsetime;
  bool isPaused = false;

  bool isFinished(int index) {
    int lastRoutineIndex = workout.routines.length - 1;
    return index >= lastRoutineIndex ? true : false;
  }

  void pause() {
    this.isPaused = true;
  }

  void start() {
    this.isPaused = false;
  }

  Session({
    this.id,
    this.name,
    this.workout,
    this.totalElapsetime = '00:00',
    this.isPaused,
  });
}
