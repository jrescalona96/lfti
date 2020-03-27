// flutter & dart imports
import "package:flutter/material.dart";

// component imports
import "package:lfti_app/components/routine_card.dart";
import "package:lfti_app/components/bottom_navigation_button.dart";
import "package:lfti_app/components/menu.dart";
import "package:lfti_app/components/empty_state_notification.dart";

// class imports
import "package:lfti_app/classes/Routine.dart";
import "package:lfti_app/classes/User.dart";
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/Workout.dart";

class UpdateRoutinesPage extends StatefulWidget {
  User _currentUser;
  UpdateRoutinesPage(this._currentUser);

  @override
  _UpdateRoutinesPageState createState() =>
      _UpdateRoutinesPageState(this._currentUser);
}

class _UpdateRoutinesPageState extends State<UpdateRoutinesPage> {
  User _currentUser;
  Workout _workout;
  List<Routine> _routineList;

 _UpdateRoutinesPageState(this._currentUser) {
   this._workout = this._currentUser
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
          "WORKOUTS",
          style: kSmallTextStyle,
        ),
      ),
      drawer: Menu(_currentUser),
      body: this._routineList.length > 0
          ? CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    Widget item;
                    if (index < _currentUser.getWorkoutList().length) {
                      item = RoutineCard(_currentUser, index);
                    }
                    return item;
                  }),
                ),
              ],
            )
          : EmptyStateNotification(sub: "Create workout routines first."),
      bottomNavigationBar: BottomNavigationButton(
        label: "ADD ROUTINE",
        action: _createNewRoutine,
        color: kBlueButtonColor,
      ),
    );
  }
}
