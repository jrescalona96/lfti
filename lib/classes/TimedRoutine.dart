import "Routine.dart";
import "Exercise.dart";

class TimedRoutine extends Routine {
  int timeToPerformInSeconds;
  static Exercise rest = Exercise(name: "Rest", focus: "Body");
  TimedRoutine({this.timeToPerformInSeconds = 90}) : super(exercise: rest);
}
