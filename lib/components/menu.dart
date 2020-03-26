import "package:flutter/material.dart";

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/User.dart";

class Menu extends StatelessWidget {
  final User _currentUser;
  Menu(this._currentUser);

  @override
  Widget build(BuildContext context) {
    void _navigateTo(String route) {
      Navigator.pushNamed(context, route, arguments: _currentUser);
    }

    return SafeArea(
      child: Container(
        child: Drawer(
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  _currentUser.getFirstName() +
                      " " +
                      _currentUser.getLastName(),
                  style: kMediumTextStyle,
                ),
                accountEmail: Text(
                  _currentUser.getEmail(),
                  style: kLabelTextStyle,
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    _currentUser.getFirstName()[0] +
                        _currentUser.getLastName()[0],
                    style: kLargeBoldTextStyle1x.copyWith(
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "Dashboard",
                  style: kSmallTextStyle,
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/dashboard",
                      arguments: _currentUser);
                },
              ),
              ListTile(
                title: Text(
                  "Checklist",
                  style: kSmallTextStyle,
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/editChecklist",
                      arguments: _currentUser);
                },
              ),
              ListTile(
                title: Text(
                  "Workouts",
                  style: kSmallTextStyle,
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/editWorkouts",
                      arguments: _currentUser);
                },
              ),
              // TODO: Create Settings for email, password, and profile pic changes
              ListTile(
                title: Text(
                  "Settings",
                  style: kSmallTextStyle,
                ),
                onTap: () {
                  print("Implement Settings Tab.");
                },
              ),
              ListTile(
                title: Text(
                  "Log out",
                  style: kSmallTextStyle,
                ),
                onTap: () {
                  // TODO: Add alert dialog box
                  Navigator.pushNamed(context, "/");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
