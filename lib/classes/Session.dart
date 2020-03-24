import 'package:lfti_app/classes/Workout.dart';

// TODO: Redo Session Class to encapsulate proper methods and attributes
class Session {
  String id;
  Workout workout;
  String totalElapsetime;
  bool isPaused = false;
  String date = "01/01/2020";

  bool isFinished(int index, int sets) {
    int routineIndex = workout.routines.length - 1;
    int routineSets = workout.routines[index].sets - 1;
    return index >= routineIndex && sets >= routineSets;
  }

  Session(
      {this.id,
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
