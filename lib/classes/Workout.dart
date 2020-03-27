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
        ? ("W" + DateFormat(kFormatDateAndTime).format(DateTime.now()))
        : this.id;
  }
  add(Routine routine) {
    routines.add(routine);
  }

  remove(int index) {
    routines.removeAt(index);
  }

  reset() {
    routines.clear();
  }
}
