import "package:flutter/material.dart";
import "package:lfti_app/components/workout_card.dart";
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/screens/loading_screen.dart";
import "package:lfti_app/classes/User.dart";

class SelectWorkoutPage extends StatefulWidget {
  final User _user;
  SelectWorkoutPage(this._user);

  @override
  _SelectWorkoutPageState createState() => _SelectWorkoutPageState(_user);
}

class _SelectWorkoutPageState extends State<SelectWorkoutPage> {
  User _currentUser;
  _SelectWorkoutPageState(this._currentUser);

  Widget _buildWorkoutsList() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SELECT WORKOUT",
          style: kMediumBoldTextStyle,
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                Widget item;
                if (index < 3) {
                  item = WorkoutCard(_currentUser, index);
                }
                return item;
              }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _currentUser.getDocument() == null
        ? LoadingScreen()
        : _buildWorkoutsList();
  }
}
