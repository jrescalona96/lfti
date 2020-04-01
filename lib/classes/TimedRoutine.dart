import "Routine.dart";
import "Exercise.dart";

class TimedRoutine extends Routine {
  int timeToPerformInSeconds;
  Exercise exercise;
  TimedRoutine({this.timeToPerformInSeconds = 90, this.exercise})
      : super(exercise: exercise);
}
