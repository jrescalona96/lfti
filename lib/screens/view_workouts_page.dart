import "package:flutter/material.dart";

// class imports
import "package:lfti_app/classes/User.dart";
import "package:lfti_app/classes/Workout.dart";

// component imports
import "package:lfti_app/components/workout_card.dart";
import "package:lfti_app/components/menu.dart";
import "package:lfti_app/components/empty_state_notification.dart";
import "package:lfti_app/components/custom_snackbar.dart";

class ViewWorkoutsPage extends StatefulWidget {
  final User _currentUser;
  ViewWorkoutsPage(this._currentUser);

  @override
  _ViewWorkoutsPageState createState() => _ViewWorkoutsPageState(_currentUser);
}

class _ViewWorkoutsPageState extends State<ViewWorkoutsPage> {
  User _currentUser;
  List<Workout> _workoutList;

  _ViewWorkoutsPageState(this._currentUser) {
    if (_currentUser.getWorkoutList() == null) {
      this._currentUser.setWorkoutList(List<Workout>());
    }
    this._workoutList = _currentUser.getWorkoutList();
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
        title: Text("Choose Workout"),
      ),
      drawer: Menu(_currentUser),
      body: _workoutList.isNotEmpty
          ? CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    Widget item;
                    if (index < _currentUser.getWorkoutList().length) {
                      var workout = this._currentUser.getWorkoutAt(index);
                      item = WorkoutCard(
                        user: _currentUser,
                        index: index,
                        onTap: workout.routines.isNotEmpty
                            ? () {
                                Navigator.of(context).pushNamed('/viewRoutines',
                                    arguments: {
                                      "user": this._currentUser,
                                      "workout": workout
                                    });
                              }
                            : () {
                                return Scaffold.of(context).showSnackBar(
                                  CustomSnackBar(
                                          message: "Create routines first!")
                                      .build(context),
                                );
                              },
                      );
                    }
                    return item;
                  }),
                ),
              ],
            )
          : EmptyStateNotification(sub: "Create workout routines first."),
    );
  }
}
