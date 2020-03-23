import "package:flutter/material.dart";
import "package:lfti_app/components/workout_card.dart";
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/screens/loading_screen.dart";
import "package:lfti_app/classes/User.dart";
import "package:lfti_app/components/bottom_navigation_button.dart";

class SelectWorkoutPage extends StatefulWidget {
  final User _user;
  SelectWorkoutPage(this._user);

  @override
  _SelectWorkoutPageState createState() => _SelectWorkoutPageState(_user);
}

class _SelectWorkoutPageState extends State<SelectWorkoutPage> {
  User _currentUser;
  _SelectWorkoutPageState(this._currentUser);

  void _navigate() {
    Navigator.pushNamed(context, "/editWorkouts", arguments: _currentUser);
  }

  Widget _buildWorkoutsList() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SELECT WORKOUT",
          style: kMediumBoldTextStyle,
        ),
      ),
      body: SafeArea(
        child: _currentUser.getWorkoutList() != null
            ? CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      Widget item;
                      if (index < _currentUser.getWorkoutList().length) {
                        item = WorkoutCard(_currentUser, index);
                      }
                      return item;
                    }),
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Nothing here yet!",
                      style: kMediumBoldTextStyle,
                    ),
                    Text(
                      "Create workout routines first.",
                      style: kMediumLabelTextStyle,
                    )
                  ],
                ),
              ),
      ),
      bottomNavigationBar: _currentUser.getWorkoutList() != null
          ? null
          : BottomNavigationButton(
              label: "CREATE ROUTINE!",
              action: _navigate,
              color: kBlueButtonColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _currentUser.getDocument() == null
        ? LoadingScreen()
        : _buildWorkoutsList();
  }
}
