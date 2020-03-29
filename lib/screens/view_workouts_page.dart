import "package:flutter/material.dart";

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/User.dart";
import "package:lfti_app/classes/Workout.dart";
import "package:lfti_app/classes/Routine.dart";

// screen imports
import "package:lfti_app/screens/loading_screen.dart";

// component imports
import "package:lfti_app/components/workout_card.dart";
import "package:lfti_app/components/menu.dart";
import "package:lfti_app/components/empty_state_notification.dart";

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

  Future<void> _createNewWorkout() async {
    final _nameTextController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter Name"),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: kCardBackground.withOpacity(0.9),
          content: TextFormField(
              controller: _nameTextController,
              keyboardType: TextInputType.text),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Create"),
              onPressed: () {
                if (_nameTextController.text != null) {
                  _workoutList.add(
                    Workout(
                      name: _nameTextController.text,
                      routines: List<Routine>(),
                    ),
                  );
                  print(_nameTextController.text + " Workout Initialized");
                  this._currentUser.setWorkoutList(_workoutList);
                  Navigator.pushNamed(context, "/updateWorkout",
                      arguments: {"user": _currentUser, "index": null});
                } else {
                  // TODO: Dialog Box to Warn user
                  print("Empty Name Field!");
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _currentUser.getDocument() == null
        ? LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                },
              ),
              title: Text(
                "WORKOUTS",
                style: kSmallTextStyle,
              ),
            ),
            drawer: Menu(_currentUser),
            body: _workoutList.length > 0
                ? CustomScrollView(
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          Widget item;
                          if (index < _currentUser.getWorkoutList().length) {
                            item = WorkoutCard(
                                user: _currentUser,
                                index: index,
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('/viewRoutines', arguments: {
                                    "user": this._currentUser,
                                    "workout":
                                        this._currentUser.getWorkoutAt(index)
                                  });
                                });
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
