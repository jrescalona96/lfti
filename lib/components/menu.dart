import "package:flutter/material.dart";

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/User.dart";

class Menu extends StatelessWidget {
  User _currentUser;
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
                  "DASHBOARD",
                  style: kSmallTextStyle,
                ),
                onTap: () {
                  _navigateTo("/dashboard");
                },
              ),
              ListTile(
                title: Text(
                  "CHECKLIST",
                  style: kSmallTextStyle,
                ),
                onTap: () {
                  _navigateTo("/editChecklist");
                },
              ),
              ListTile(
                title: Text(
                  "WORKOUTS",
                  style: kSmallTextStyle,
                ),
                onTap: () {
                  _navigateTo("/editWorkouts");
                },
              ),
              ListTile(
                title: Text(
                  "SETTINGS",
                  style: kSmallTextStyle,
                ),
                onTap: () {
                  print("Implement Settings Tab.");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
