import 'package:lfti_app/classes/Workout.dart';

class Session {
  int id;
  String name;
  Workout workout;
  int totalTimeInSeconds;

  Session({this.id, this.name, this.workout, this.totalTimeInSeconds = 0});

  reset() {
    // TODO: reset everything;
  }
}
