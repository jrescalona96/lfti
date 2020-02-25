import 'package:flutter/cupertino.dart';
import 'package:lfti_app/classes/Routine.dart';

class Workout {
  int id = 0;
  String name;
  List<Routine> routines;
  String description;

  Workout(
      {this.id,
      @required this.name,
      this.description = '',
      @required this.routines});

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
