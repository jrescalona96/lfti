import 'package:lfti_app/classes/Routine.dart';
import 'package:lfti_app/classes/Exercise.dart';
import 'package:lfti_app/classes/Workout.dart';

class WorkoutsGenerator {
  final List<Exercise> chest = [
    Exercise(name: 'Barbell Bench Press', focus: "Chest"),
    Exercise(name: 'Dumbell Press', focus: "Chest"),
    Exercise(name: 'Dumbell Fly', focus: "Chest"),
    Exercise(name: 'Push Up', focus: "Chest"),
    Exercise(name: 'Fly', focus: "Chest"),
    Exercise(name: 'Decline dumbbell bench press', focus: "Chest"),
    Exercise(name: 'Dumbell pullover', focus: 'Chest'),
    Exercise(name: 'Cable Iron Cross', focus: 'Chest')
  ];

  final List<Exercise> leg = [
    Exercise(name: 'Barbell Squat', focus: 'Leg'),
    Exercise(name: 'Leg Press', focus: 'Leg'),
    Exercise(name: 'Dumbbell Walking Lunge', focus: 'Leg'),
    Exercise(name: 'Leg Extensions', focus: 'Leg'),
    Exercise(name: 'Romanian Deadlift', focus: 'Leg'),
    Exercise(name: 'Lying Leg Curls', focus: 'Leg'),
    Exercise(name: 'Standing Calf Raises', focus: 'Leg')
  ];

  final List<Exercise> back = [
    Exercise(name: 'Barbell Deadlift', focus: 'Back'),
    Exercise(name: 'Pull-Ups With A Wide Grip', focus: 'Back'),
    Exercise(name: 'Standing T-Bar Rowing', focus: 'Back'),
    Exercise(name: 'Seated Cable Rowing With A Wide Grip', focus: 'Back'),
    Exercise(name: 'Smith Machine Rowing', focus: 'Back'),
    Exercise(name: 'Pull-Downs With A Narrow Grip', focus: 'Back'),
    Exercise(name: 'Single-Arm Dumbbell Row', focus: 'Back'),
    Exercise(name: 'Dumbbell Pull-Over On A Decline Bench', focus: 'Back')
  ];

  Exercise rest = Exercise(name: 'Rest', focus: '');

  List fetchAllWorkouts() {
    var w = List<Workout>();

    w.add(
      Workout(
          name: "Chestday Monday",
          description: "First workout of the week",
          routines: [
            Routine(exercise: chest[0], sets: 3, reps: 10),
            Routine(
                exercise: rest, timeToPerformInSeconds: 90, sets: 1, reps: 1),
            Routine(exercise: chest[1], sets: 3, reps: 10),
            Routine(
                exercise: rest, timeToPerformInSeconds: 90, sets: 1, reps: 1),
            Routine(exercise: chest[2], sets: 3, reps: 10),
            Routine(
                exercise: rest, timeToPerformInSeconds: 90, sets: 1, reps: 1),
            Routine(exercise: chest[3], sets: 3, reps: 10),
            Routine(
                exercise: rest, timeToPerformInSeconds: 90, sets: 1, reps: 1),
            Routine(exercise: chest[4], sets: 3, reps: 10),
            Routine(
                exercise: rest, timeToPerformInSeconds: 120, sets: 1, reps: 1),
            Routine(exercise: chest[5], sets: 3, reps: 10),
            Routine(
                exercise: rest, timeToPerformInSeconds: 300, sets: 1, reps: 1),
          ]),
    );
    w.add(
      Workout(
          name: "Taco Tuesday",
          description: "Second workout of the week",
          routines: [
            Routine(exercise: back[0], sets: 3, reps: 10),
            Routine(
                exercise: rest, timeToPerformInSeconds: 90, sets: 1, reps: 1),
            Routine(exercise: back[1], sets: 3, reps: 10),
            Routine(
                exercise: rest, timeToPerformInSeconds: 90, sets: 1, reps: 1),
            Routine(exercise: back[2], sets: 3, reps: 10),
            Routine(
                exercise: rest, timeToPerformInSeconds: 90, sets: 1, reps: 1),
            Routine(exercise: back[3], sets: 3, reps: 10),
            Routine(
                exercise: rest, timeToPerformInSeconds: 90, sets: 1, reps: 1),
            Routine(exercise: back[4], sets: 3, reps: 10),
            Routine(
                exercise: rest, timeToPerformInSeconds: 120, sets: 1, reps: 1),
            Routine(exercise: back[5], sets: 3, reps: 10),
            Routine(
                exercise: rest, timeToPerformInSeconds: 120, sets: 1, reps: 1),
          ]),
    );
    w.add(
      Workout(
          name: "Leyggg dey",
          description: "Third workout of the week",
          routines: [
            Routine(exercise: leg[0], sets: 3, reps: 10),
            Routine(
                exercise: rest, timeToPerformInSeconds: 90, sets: 1, reps: 1),
            Routine(exercise: leg[1], sets: 3, reps: 10),
            Routine(
                exercise: rest, timeToPerformInSeconds: 90, sets: 1, reps: 1),
            Routine(exercise: leg[2], sets: 3, reps: 10),
            Routine(
                exercise: rest, timeToPerformInSeconds: 90, sets: 1, reps: 1),
            Routine(exercise: leg[3], sets: 3, reps: 10),
            Routine(
                exercise: rest, timeToPerformInSeconds: 90, sets: 1, reps: 1),
            Routine(exercise: leg[4], sets: 3, reps: 10),
            Routine(
                exercise: rest, timeToPerformInSeconds: 120, sets: 1, reps: 1),
          ]),
    );
    return w;
  }
}
