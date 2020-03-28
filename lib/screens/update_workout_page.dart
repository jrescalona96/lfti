import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/User.dart";
import "package:lfti_app/classes/Workout.dart";
import "package:lfti_app/classes/Routine.dart";
import 'package:lfti_app/components/custom_card.dart';

// component imports
import "package:lfti_app/components/menu.dart";
import "package:lfti_app/components/bottom_navigation_button.dart";
import "package:lfti_app/components/empty_state_notification.dart";
import "package:lfti_app/components/routine_card.dart";
import "package:lfti_app/components/time_dropdown_menu.dart";

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

  _UpdateWorkoutPageState(Map args) {
    this._currentUser = args["user"];
    this._workout = this._currentUser.getWorkoutAt(args["index"]);
  }

  void _saveChanges() {
    Firestore.instance.runTransaction(
      (transaction) async {
        transaction
            .update(_currentUser.getFirestoreReference(), {
              "workouts": {_currentUser.getWorkoutList()}
            })
            .then((val) => print("Workouts successfully updated!"))
            .catchError((e) =>
                print("Error: Failed to update user Workouts!" + e.toString()));
      },
    );
  }

  void _updateExerciseRoutine(Routine r) {
    print("update routine");
  }

  void _addRoutine() {
    print("add routine");
  }

  Future<void> _updateRestRoutineTime(int index) async {
    final _timeDropdownMenu =
        TimeDropdownMenu(_workout.routines[index].timeToPerformInSeconds);
    return await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter Time"),
          content: _timeDropdownMenu,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: kCardBackground.withOpacity(0.9),
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
                _workout.routines[index].timeToPerformInSeconds =
                    _timeDropdownMenu.getValue();
                Navigator.of(context).pop();
              },
            ),
          ],
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
          "Edit " + _workout.name,
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
                        dottedBorder: true,
                        routine: _workout.routines[index],
                        onTap: _workout.routines[index].exercise.name == "Rest"
                            ? () {
                                _updateRestRoutineTime(index);
                              }
                            : () {
                                _updateExerciseRoutine(
                                    _workout.routines[index]);
                              },
                      );
                    } else if (index == _workout.routines.length) {
                      item = CustomCard(
                        cardChild: Center(
                          child: Icon(
                            FontAwesomeIcons.plus,
                            size: 32.0,
                            color: Colors.white60,
                          ),
                        ),
                        onTap: _addRoutine,
                      );
                    }
                    return item;
                  }),
                ),
              ],
            )
          : EmptyStateNotification(sub: "Add Routines/ Exercises"),
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
