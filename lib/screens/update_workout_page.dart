import "package:flutter/material.dart";

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/User.dart";
import "package:lfti_app/classes/Workout.dart";
import "package:lfti_app/classes/Routine.dart";

// component imports
import "package:lfti_app/components/menu.dart";
import "package:lfti_app/components/bottom_navigation_button.dart";
import "package:lfti_app/components/empty_state_notification.dart";
import "package:lfti_app/components/edit_routine_card.dart";
import "package:lfti_app/components/routine_card.dart";

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
  int _index;
  Workout _workout;

  _UpdateWorkoutPageState(Map args) {
    this._currentUser = args["user"];
    this._index = args["index"];
    print(this._index);
    if (_isNewWorkout()) {
      this._index = this._currentUser.getWorkoutList().length - 1;
    }
    this._workout = this._currentUser.getWorkoutAt(this._index);
  }

  bool _isNewWorkout() {
    return this._index == null;
  }

  void _addRoutine() {
    print("Add routines");
  }

  void _saveChanges() async {
    Firestore.instance.runTransaction((transaction) {
      transaction
          .update(_currentUser.getFirestoreReference(), {
            "workouts": {_currentUser.getWorkoutList()}
          })
          .then((val) => print("Workouts successfully updated!"))
          .catchError((e) =>
              print("Error: Failed to update user Workouts!" + e.toString()));
    });
  }

  void updateUserData() {
    print("update current user data");
  }

// TODO: Start here... Navigate to another page instead of dialog box.
  Future<void> _updateRoutine(Routine r) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            children: <Widget>[
              EditRoutineCard(r),
              Row(
                children: <Widget>[
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
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: kCardBackground.withOpacity(0.9),
        );
      },
    );
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
          _workout.name,
          style: kSmallTextStyle,
        ),
      ),
      drawer: Menu(_currentUser),
      body: _workout.routines.length > 0
          ? CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    Widget item;
                    if (index < _workout.routines.length) {
                      item = RoutineCard(
                        routine: _workout.routines[index],
                        cardAction: () {
                          _updateRoutine(_workout.routines[index]);
                        },
                      );
                    }
                    return item;
                  }),
                ),
              ],
            )
          : EmptyStateNotification(sub: "Add Routines/ Exercises"),
      bottomNavigationBar: this._workout.routines.length > 0
          ? BottomNavigationButton(
              label: "SAVE",
              action: () {
                _saveChanges();
                Navigator.pushNamed(context, "/workouts",
                    arguments: _currentUser);
              },
              color: kGreenButtonColor,
            )
          : BottomNavigationButton(
              label: "ADD ROUTINE",
              action: () {
                _addRoutine();
              },
              color: kBlueButtonColor),
    );
  }
}
