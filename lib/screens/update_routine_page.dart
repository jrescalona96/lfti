import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:numberpicker/numberpicker.dart";

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/Routine.dart";
import "package:lfti_app/classes/Workout.dart";
import "package:lfti_app/classes/User.dart";

// component imports
import 'package:lfti_app/components/bottom_navigation_button.dart';
import "package:lfti_app/components/custom_dropdown_menu.dart";
import "package:lfti_app/components/custom_card.dart";

class UpdateRoutinePage extends StatefulWidget {
  final Map _args;
  UpdateRoutinePage(this._args);

  @override
  _UpdateRoutinePageState createState() => _UpdateRoutinePageState(this._args);
}

class _UpdateRoutinePageState extends State<UpdateRoutinePage> {
  User _currentUser;
  Routine _routine;
  int _workoutIndex;
  int _routineIndex;
  TextEditingController _nameTextController;

  _UpdateRoutinePageState(Map args) {
    this._currentUser = args["user"];
    this._workoutIndex = args["workoutIndex"];
    this._routineIndex = args["routineIndex"];
    this._routine = _currentUser
        .getWorkoutAt(this._workoutIndex)
        .routines[this._routineIndex];
    _nameTextController = TextEditingController(text: _routine.exercise.name);
  }

  void _showRepsOptionDialog() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return NumberPickerDialog.integer(
            minValue: 1,
            maxValue: 100,
            title: Text("Rep Count"),
            initialIntegerValue: _routine.reps,
          );
        }).then((int val) {
      if (val != null) {
        _updateReps(val);
      }
    });
  }

  void _showSetsOptionDialog() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return NumberPickerDialog.integer(
            minValue: 1,
            maxValue: 10,
            title: Text("Set Count"),
            initialIntegerValue: _routine.sets,
          );
        }).then((int val) {
      if (val != null) {
        _updateSets(val);
      }
    });
  }

  void _showMuscleGroupOptionDialog() async {
    var _dropdown = CustomDropdownMenu(
      initialValue: this._routine.exercise.focus,
      items: [
        "Chest",
        "Back",
        "Bicep",
        "Tricep",
        "Legs",
        "Shoulder",
      ],
    );
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose Muscle Group"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          content: _dropdown,
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Cancel",
                style: kSmallTextStyle,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "Confirm",
                style: kSmallTextStyle,
              ),
              onPressed: () {
                _updateMuscleGroupFocus(_dropdown.getValue());
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateMuscleGroupFocus(String val) {
    setState(() {
      this._routine.exercise.focus = val;
    });
  }

  void _updateReps(int val) {
    if (this._routine.reps != val) {
      setState(() {
        this._routine.reps = val;
      });
    }
  }

  void _updateSets(int val) {
    if (this._routine.sets != val) {
      setState(() {
        this._routine.sets = val;
      });
    }
  }

  void _saveChanges() {
    // TODO: consider using ".pop(result)" instead
    Workout workout = _currentUser.getWorkoutAt(this._workoutIndex);
    workout.setRoutineAt(this._routineIndex, this._routine);
    this._currentUser.setWorkoutAt(
          this._workoutIndex,
          workout,
        );
    Navigator.pushNamed(
      context,
      "/updateWorkout",
      arguments: {"user": _currentUser, "index": _workoutIndex},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_routine.exercise.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: kSizedBoxHeight),
          CustomCard(
            cardChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Name", style: kLabelTextStyle),
                TextFormField(
                  controller: _nameTextController,
                  style: kMediumTextStyle,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.times,
                        size: 18.0,
                        color: Colors.white60,
                      ),
                      onPressed: () {
                        _nameTextController.clear();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // muscle group section
          CustomCard(
            cardChild: GestureDetector(
              onTap: _showMuscleGroupOptionDialog,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text("Major Muscle Group", style: kLabelTextStyle),
                  SizedBox(height: kSmallSizedBoxHeight),
                  Text(
                    _routine.exercise.focus,
                    style: kMediumTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // reps section
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () => _showRepsOptionDialog(),
                  child: CustomCard(
                    cardChild: Column(
                      children: <Widget>[
                        Text("Reps", style: kLabelTextStyle),
                        SizedBox(height: kSmallSizedBoxHeight),
                        Text(
                          this._routine.reps.toString(),
                          style: kMediumTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // sets section
              Expanded(
                child: GestureDetector(
                  onTap: () => _showSetsOptionDialog(),
                  child: CustomCard(
                    cardChild: Column(
                      children: <Widget>[
                        Text("Sets", style: kLabelTextStyle),
                        SizedBox(height: kSmallSizedBoxHeight),
                        Text(
                          this._routine.sets.toString(),
                          style: kMediumTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationButton(
          label: "SAVE CHANGES",
          action: () => _saveChanges(),
          color: kGreenButtonColor),
    );
  }
}
