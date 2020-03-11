import 'package:lfti_app/classes/Routine.dart';
import 'package:lfti_app/classes/Exercise.dart';
import 'package:lfti_app/classes/Workout.dart';

class WorkoutsGenerator {
  final List<Exercise> chest = [
    Exercise(name: 'Barbell Bench Press', bodyPart: "Chest"),
    Exercise(name: 'Dumbell Press', bodyPart: "Chest"),
    Exercise(name: 'Dumbell Fly', bodyPart: "Chest"),
    Exercise(name: 'Push Up', bodyPart: "Chest"),
    Exercise(name: 'Fly', bodyPart: "Chest"),
    Exercise(name: 'Decline dumbbell bench press', bodyPart: "Chest"),
    Exercise(name: 'Dumbell pullover', bodyPart: 'Chest'),
    Exercise(name: 'Cable Iron Cross', bodyPart: 'Chest')
  ];

  final List<Exercise> leg = [
    Exercise(name: 'Barbell Squat', bodyPart: 'Leg'),
    Exercise(name: 'Leg Press', bodyPart: 'Leg'),
    Exercise(name: 'Dumbbell Walking Lunge', bodyPart: 'Leg'),
    Exercise(name: 'Leg Extensions', bodyPart: 'Leg'),
    Exercise(name: 'Romanian Deadlift', bodyPart: 'Leg'),
    Exercise(name: 'Lying Leg Curls', bodyPart: 'Leg'),
    Exercise(name: 'Standing Calf Raises', bodyPart: 'Leg')
  ];

  final List<Exercise> back = [
    Exercise(name: 'Barbell Deadlift', bodyPart: 'Back'),
    Exercise(name: 'Pull-Ups With A Wide Grip', bodyPart: 'Back'),
    Exercise(name: 'Standing T-Bar Rowing', bodyPart: 'Back'),
    Exercise(name: 'Seated Cable Rowing With A Wide Grip', bodyPart: 'Back'),
    Exercise(name: 'Smith Machine Rowing', bodyPart: 'Back'),
    Exercise(name: 'Pull-Downs With A Narrow Grip', bodyPart: 'Back'),
    Exercise(name: 'Single-Arm Dumbbell Row', bodyPart: 'Back'),
    Exercise(name: 'Dumbbell Pull-Over On A Decline Bench', bodyPart: 'Back')
  ];

  Exercise rest = Exercise(name: 'Rest', bodyPart: '');

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
            Routine(exercise: leg[5], sets: 3, reps: 10),
            Routine(
                exercise: rest, timeToPerformInSeconds: 120, sets: 1, reps: 1),
          ]),
    );
    w.add(
      Workout(
          name: "Leyggg dey",
          description: "Third workout of the week",
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
          ]),
    );
    return w;
  }
}
