import "Routine.dart";
import "Exercise.dart";
import "package:flutter/material.dart";

class TimedRoutine extends Routine {
  int timeToPerformInSeconds;
  Exercise exercise;
  TimedRoutine({this.timeToPerformInSeconds = 90, @required this.exercise})
      : super(exercise: exercise);

  void setTimeToPerformInSeconds(int t) => this.timeToPerformInSeconds = t;
  int getTimeToPerformInSeconds() => this.timeToPerformInSeconds;
}
