import "package:flutter/material.dart";
import "package:lfti_app/classes/Routine.dart";
import "package:intl/intl.dart";
import "package:lfti_app/classes/Constants.dart";

class Workout {
  String id; // TODO: rethink the use of ID (can be used in updating workouts)
  String name;
  List<Routine> routines;
  String description;
  String dateCreated = DateFormat(kFormatDateAndTime).format(DateTime.now());

  Workout({
    this.id,
    @required this.name,
    @required this.routines,
    this.description = "",
  }) {
    this.id = this.id == null
        ? "W" + DateFormat(kFormatDateAndTime).format(DateTime.now())
        : this.id;
  }

  void addRoutine(Routine r) {
    this.routines.add(r);
  }

  void deleteRoutine(int i) {
    routines.removeAt(i);
  }

  void updateRoutineAt(int i, Routine r) {
    routines[i] = r;
  }

  void reset() {
    routines.clear();
  }

  Routine getRoutineAt(int index) {
    return routines[index];
  }
}
