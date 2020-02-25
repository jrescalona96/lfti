import 'package:lfti_app/classes/Routine.dart';
import 'package:lfti_app/classes/Exercise.dart';
import 'package:lfti_app/classes/Workout.dart';

class WorkoutsGenerator {
  final List<Exercise> chest = [
    Exercise(name: 'Barbell Bench Press', bodyPart: "chest"),
    Exercise(name: 'Dumbell Press', bodyPart: "chest"),
    Exercise(name: 'Dumbell Fly', bodyPart: "chest"),
    Exercise(name: 'Push Up', bodyPart: "chest"),
    Exercise(name: 'Fly', bodyPart: "chest"),
    Exercise(name: 'Decline dumbbell bench press', bodyPart: "chest"),
    Exercise(name: 'Dumbell pullover', bodyPart: 'chest'),
    Exercise(name: 'Cable Iron Cross', bodyPart: 'chest')
  ];

  final List<Exercise> leg = [
    Exercise(name: 'Barbell Squat', bodyPart: 'leg'),
    Exercise(name: 'Leg Press', bodyPart: 'leg'),
    Exercise(name: 'Dumbbell Walking Lunge', bodyPart: 'leg'),
    Exercise(name: 'Leg Extensions', bodyPart: 'leg'),
    Exercise(name: 'Romanian Deadlift', bodyPart: 'leg'),
    Exercise(name: 'Lying Leg Curls', bodyPart: 'leg'),
    Exercise(name: 'Standing Calf Raises', bodyPart: 'leg')
  ];

  final List<Exercise> back = [
    Exercise(name: 'Barbell Deadlift', bodyPart: 'back'),
    Exercise(name: 'Pull-Ups With A Wide Grip', bodyPart: 'back'),
    Exercise(name: 'Standing T-Bar Rowing', bodyPart: 'back'),
    Exercise(name: 'Seated Cable Rowing With A Wide Grip', bodyPart: 'back'),
    Exercise(name: 'Smith Machine Rowing', bodyPart: 'back'),
    Exercise(name: 'Pull-Downs With A Narrow Grip', bodyPart: 'back'),
    Exercise(name: 'Single-Arm Dumbbell Row', bodyPart: 'back'),
    Exercise(name: 'Dumbbell Pull-Over On A Decline Bench', bodyPart: 'back')
  ];

  Exercise rest = Exercise(name: 'Rest', bodyPart: '');

  List fetchAllWorkouts() {
    var w = List<Workout>();

    w.add(
      Workout(
          name: "Monday Workout",
          description: "First workout of the week",
          routines: [
            Routine(exercise: back[0], sets: 3, reps: 10),
            Routine(exercise: rest, timeToPerformInSeconds: 90),
            Routine(exercise: back[1], sets: 3, reps: 10),
            Routine(exercise: rest, timeToPerformInSeconds: 90),
            Routine(exercise: back[2], sets: 3, reps: 10),
            Routine(exercise: rest, timeToPerformInSeconds: 90),
            Routine(exercise: back[3], sets: 3, reps: 10),
            Routine(exercise: rest, timeToPerformInSeconds: 90),
            Routine(exercise: back[4], sets: 3, reps: 10),
            Routine(exercise: rest, timeToPerformInSeconds: 120),
            Routine(exercise: back[5], sets: 3, reps: 10),
            Routine(exercise: rest, timeToPerformInSeconds: 300),
          ]),
    );
    w.add(
      Workout(
          name: "Tuesday Workout",
          description: "Second workout of the week",
          routines: [
            Routine(exercise: leg[0], sets: 3, reps: 10),
            Routine(exercise: rest, timeToPerformInSeconds: 90),
            Routine(exercise: leg[1], sets: 3, reps: 10),
            Routine(exercise: rest, timeToPerformInSeconds: 90),
            Routine(exercise: leg[2], sets: 3, reps: 10),
            Routine(exercise: rest, timeToPerformInSeconds: 90),
            Routine(exercise: leg[3], sets: 3, reps: 10),
            Routine(exercise: rest, timeToPerformInSeconds: 90),
            Routine(exercise: leg[4], sets: 3, reps: 10),
            Routine(exercise: rest, timeToPerformInSeconds: 120),
            Routine(exercise: leg[5], sets: 3, reps: 10),
            Routine(exercise: rest, timeToPerformInSeconds: 120),
          ]),
    );
    w.add(
      Workout(
          name: "Friday Workout",
          description: "Third workout of the week",
          routines: [
            Routine(exercise: chest[0], sets: 3, reps: 10),
            Routine(exercise: rest, timeToPerformInSeconds: 90),
            Routine(exercise: chest[1], sets: 3, reps: 10),
            Routine(exercise: rest, timeToPerformInSeconds: 90),
            Routine(exercise: chest[2], sets: 3, reps: 10),
            Routine(exercise: rest, timeToPerformInSeconds: 90),
            Routine(exercise: chest[3], sets: 3, reps: 10),
            Routine(exercise: rest, timeToPerformInSeconds: 90),
            Routine(exercise: chest[4], sets: 3, reps: 10),
            Routine(exercise: rest, timeToPerformInSeconds: 120),
          ]),
    );
    return w;
  }
}
