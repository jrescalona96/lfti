import "package:flutter/material.dart";

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/User.dart";

// component imports
import "package:lfti_app/components/custom_card.dart";
import "package:lfti_app/components/bottom_navigation_button.dart";

class EditWorkoutPage extends StatefulWidget {
  final User _currentUser;
  EditWorkoutPage(this._currentUser);

  @override
  _EditWorkoutPageState createState() => _EditWorkoutPageState(_currentUser);
}

class _EditWorkoutPageState extends State<EditWorkoutPage> {
  User _currentUser;
  _EditWorkoutPageState(this._currentUser);

  void _save() {
    Navigator.pushNamed(context, "/viewWorkouts", arguments: _currentUser);
  }

  void _cancel() {
    Navigator.pop(context);
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
                // TODO: implement navbar drawer
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(
          _currentUser.getFirstName(),
          style: kMediumBoldTextStyle,
        ),
      ),
      body: SafeArea(
        child: Container(
          child: CustomCard(
            cardChild: Text("Create shite"),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: BottomNavigationButton(
                label: "CANCEL", action: _cancel, color: kRedButtonColor),
          ),
          Expanded(
            flex: 2,
            child: BottomNavigationButton(
                label: "SAVE", action: _save, color: kGreenButtonColor),
          )
        ],
      ),
    );
  }
}
