// flutter & dart imports
import "package:flutter/material.dart";
import "package:intl/intl.dart";

// component imports
import "package:lfti_app/components/routine_card.dart";
import "package:lfti_app/components/bottom_navigation_button.dart";
import "package:lfti_app/components/menu.dart";

// class imports
import "package:lfti_app/classes/Workout.dart";
import "package:lfti_app/classes/User.dart";
import "package:lfti_app/classes/Session.dart";
import "package:lfti_app/classes/Constants.dart";

class ViewWorkoutPage extends StatelessWidget {
  User _currentUser;
  Workout _workout;

  ViewWorkoutPage(Map args) {
    this._currentUser = args["user"];
    this._workout = args["workout"];
  }

  @override
  Widget build(BuildContext context) {
    void _navigate() {
      _currentUser.setSession(new Session(_workout));
      Navigator.pushNamed(
        context,
        '/startSession',
        arguments: _currentUser,
      );
    }

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
          title: Text(_workout.name, style: kMediumTextStyle),
        ),
        drawer: Menu(_currentUser),
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  Widget item;
                  if (index < _workout.routines.length) {
                    item = RoutineCard(_workout.routines[index]);
                  }
                  return item;
                }),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationButton(
          label: "START",
          action: _navigate,
          color: kGreenButtonColor,
        ));
  }
}
