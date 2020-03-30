import "package:flutter/material.dart";

// package imports
import "package:intl/intl.dart";

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/User.dart";
import "package:lfti_app/classes/Workout.dart";
import "package:lfti_app/classes/Routine.dart";

// component imports
import "package:lfti_app/components/menu.dart";
import "package:lfti_app/components/bottom_navigation_button.dart";
import "package:lfti_app/components/empty_state_notification.dart";
import "package:lfti_app/components/routine_card.dart";
import "package:lfti_app/components/time_dropdown_menu.dart";
import "package:lfti_app/components/custom_button_card.dart";
import "package:lfti_app/components/custom_card.dart";

// firestore import
import "package:cloud_firestore/cloud_firestore.dart";

class UpdateWorkoutPage extends StatefulWidget {
  final Map _args;
  UpdateWorkoutPage(this._args);

  @override
  _UpdateWorkoutPageState createState() => _UpdateWorkoutPageState(this._args);
}

class _UpdateWorkoutPageState extends State<UpdateWorkoutPage> {
  User _currentUser;
  Workout _workout;
  int _workoutIndex;
  List<Routine> _routineList;

  _UpdateWorkoutPageState(Map args) {
    this._currentUser = args["user"];
    this._workoutIndex = args["index"];
    this._workout = this._currentUser.getWorkoutAt(this._workoutIndex);
    this._routineList = this._workout.routines;
  }

  void _showUpdateRestTimeDialog(int index) async {
    final _timeDropdownMenu =
        TimeDropdownMenu(_workout.routines[index].timeToPerformInSeconds);
    return await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter Time (seconds)"),
          content: _timeDropdownMenu,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          backgroundColor: kCardBackground.withOpacity(0.9),
          actions: <Widget>[
            FlatButton(
              color: kRedButtonColor.withOpacity(0.5),
              child: Text("DELETE", style: kSmallTextStyle),
              onPressed: () {
                setState(() {
                  this._currentUser.deleteRoutineAt(this._workoutIndex, index);
                });
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("CONFIRM", style: kSmallTextStyle),
              onPressed: () {
                setState(() {
                  _workout.routines[index].timeToPerformInSeconds =
                      _timeDropdownMenu.getValue();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addExerciseRoutine() {
    print("add routine");
  }

  void _updateExerciseRoutine(int index) {
    Navigator.pushNamed(context, "/updateRoutine", arguments: {
      "user": this._currentUser,
      "workoutIndex": this._workoutIndex,
      "routineIndex": index
    });
  }

  void _saveChanges() {
    // TODO: Create a class schema for workout
    List newWorkoutList = _currentUser
        .getWorkoutList()
        .map((w) => {
              "id": "W" + DateFormat(kFormatDateId).format(DateTime.now()),
              "name": w.name.toString(),
              "description": w.description.toString(),
              "routines": w.routines
                  .map((r) => {
                        "exercise": {
                          "name": r.exercise.name.toString(),
                          "focus": r.exercise.focus.toString(),
                        },
                        "reps": r.exercise.name == "Rest" ? 1 : r.reps,
                        "sets": r.exercise.name == "Rest" ? 1 : r.sets
                      })
                  .toList()
            })
        .toList();
    print(newWorkoutList);
    Firestore.instance.runTransaction((transaction) async {
      transaction
          .update(_currentUser.getFirestoreReference(),
              {"workouts": newWorkoutList})
          .then((val) => print("Success: Workouts successfully updated!"))
          .catchError((e) =>
              print("Error: Failed to update user Workouts! " + e.toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(
          "Edit " + _workout.name,
          style: kSmallTextStyle,
        ),
      ),
      drawer: Menu(_currentUser),
      body: _routineList != null
          ? CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    Widget item;
                    if (index < _routineList.length) {
                      item = RoutineCard(
                        dottedBorder: true,
                        routine: _routineList[index],
                        onTap: _routineList[index].exercise.name == "Rest"
                            ? () => _showUpdateRestTimeDialog(index)
                            : () => _updateExerciseRoutine(index),
                      );
                    } else if (index == _routineList.length) {
                      item = CustomButtonCard(onTap: _addExerciseRoutine);
                    }
                    return item;
                  }),
                ),
              ],
            )
          : EmptyStateNotification(sub: "Add Routines/Exercises"),
      bottomNavigationBar: BottomNavigationButton(
        label: "SAVE CHANGES",
        action: () {
          _saveChanges();
          Navigator.pushNamed(context, "/workouts", arguments: _currentUser);
        },
        color: kBlueButtonColor,
      ),
    );
  }
}
