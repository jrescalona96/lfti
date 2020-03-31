import "package:flutter/material.dart";

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/User.dart";
import "package:lfti_app/classes/Workout.dart";
import "package:lfti_app/classes/Routine.dart";
import "package:lfti_app/classes/TimedRoutine.dart";

// component imports
import "package:lfti_app/components/menu.dart";
import "package:lfti_app/components/bottom_navigation_button.dart";
import "package:lfti_app/components/routine_card.dart";
import "package:lfti_app/components/time_dropdown_menu.dart";
import "package:lfti_app/components/custom_button_card.dart";
import "package:lfti_app/components/custom_dialog_button.dart";
import "package:lfti_app/components/custom_text_form_field.dart";

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
  String _name, _description;

  TextEditingController _nameTextController, _descriptionTextController;

  _UpdateWorkoutPageState(Map args) {
    this._currentUser = args["user"];
    this._workoutIndex = args["index"];
    this._workout = this._currentUser.getWorkoutAt(this._workoutIndex);
    this._routineList = this._workout.routines;
    this._name = this._workout.name;
    this._description = this._workout.description;
    this._nameTextController = TextEditingController(text: _name);
    this._descriptionTextController = TextEditingController(text: _description);
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
            CustomDialogButton(
              label: "DELETE",
              onPressed: () {
                setState(() {
                  this._currentUser.deleteRoutineAt(this._workoutIndex, index);
                });
                Navigator.of(context).pop();
              },
              color: kRedButtonColor.withOpacity(0.5),
            ),
            CustomDialogButton(
              label: "CONFIRM",
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

  List<RoutineCard> _getRoutineCards() {
    final routines = List<RoutineCard>();
    if (this._routineList.isNotEmpty) {
      for (int i = 0; i < this._routineList.length; i++) {
        routines.add(
          RoutineCard(
              routine: _routineList[i],
              onTap: _routineList[i] is TimedRoutine
                  ? () => _showUpdateRestTimeDialog(i)
                  : () => _updateExerciseRoutine(i)),
        );
      }
    }
    return routines;
  }

  void _showAddExerciseDialog() {
    print("TODO: Need to implement");
  }

  void _saveChanges() {
    this._workout.setName(_nameTextController.text);
    this._workout.setDescription(_descriptionTextController.text);
    this._workout.setRoutines(this._routineList);
    this._currentUser.setWorkoutAt(this._workoutIndex, _workout);
    // TODO: Create a class schema for workout
    var newWorkoutList = _currentUser
        .getWorkoutList()
        .map((w) => {
              "id": w.id,
              "name": w.name,
              "description": w.description,
              "routines": w.routines
                  .map((r) => (r is TimedRoutine)
                      ? {
                          "type": "TIMED",
                          "exercise": {
                            "name": r.exercise.name,
                            "focus": r.exercise.focus
                          },
                          "timeToPerformInSeconds": r.timeToPerformInSeconds
                        }
                      : {
                          "type": "COUNTED",
                          "exercise": {
                            "name": r.exercise.name,
                            "focus": r.exercise.focus
                          },
                          "reps": r.reps,
                          "sets": r.sets
                        })
                  .toList()
            })
        .toList();

    Firestore.instance.runTransaction((transaction) async {
      transaction
          .update(_currentUser.getFirestoreReference(),
              {"workouts": newWorkoutList})
          .then((val) => print("Success: Workouts successfully updated!"))
          .catchError((e) => print(
              "Error: Failed to update user Workouts! : " + e.toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // line divider
    var lineDivider = Divider(
      indent: 40.0,
      endIndent: 40.0,
      color: kIconColor.withOpacity(0.2),
      thickness: 1.0,
    );
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
      body: ListView(
        children: <Widget>[
          CustomTextFormField(
              textController: _nameTextController, label: "Name"),
          lineDivider,
          CustomTextFormField(
              textController: _descriptionTextController, label: "Description"),
          Container(
            child: _routineList.isNotEmpty
                ? lineDivider
                : Text(
                    "Add Routines",
                    style: kSmallBoldTextStyle,
                  ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ..._getRoutineCards(),
              lineDivider,
              CustomButtonCard(onTap: () => _showAddExerciseDialog()),
            ],
          ),
        ],
      ),
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
