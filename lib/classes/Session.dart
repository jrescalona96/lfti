import 'package:lfti_app/classes/Workout.dart';

class Session {
  int id;
  String name;
  Workout workout;
  String totalElapsetime;
  bool isPaused = false;
  String date = "01/01/2020";
  // var date = {"month": 1, "day": 1, "year": 2020, "weekday": "Monday"};

  bool isFinished(int index) {
    int lastRoutineIndex = workout.routines.length - 1;
    return index >= lastRoutineIndex ? true : false;
  }

  Session(
      {this.id,
      this.name,
      this.workout,
      this.totalElapsetime = '00:00',
      this.isPaused,
      this.date});

  void pause() {
    this.isPaused = true;
  }

  void start() {
    this.isPaused = false;
  }
}
