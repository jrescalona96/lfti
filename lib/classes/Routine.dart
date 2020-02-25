import 'package:lfti_app/classes/Exercise.dart';

// TODO: separate exercise and rest

class Routine {
  int id;
  Exercise exercise;
  int sets;
  int reps;
  int timeToPerformInSeconds;

  Routine({
    this.id,
    this.exercise,
    this.sets = 0,
    this.reps = 0,
    this.timeToPerformInSeconds = 0,
  });
}
