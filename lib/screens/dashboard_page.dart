import "package:flutter/material.dart";
// class imports

import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/User.dart";

// component imports
import "package:lfti_app/components/checklist.dart";
import "package:lfti_app/components/dashboard_card_tile.dart";
import "package:lfti_app/components/custom_card.dart";
import "package:lfti_app/components/bottom_navigation_button.dart";
import "package:lfti_app/components/menu.dart";

// screen imports
import "package:lfti_app/screens/loading_screen.dart";

class DashboardPage extends StatefulWidget {
  final User _currentUser;
  DashboardPage(this._currentUser);

  @override
  _DashboardPageState createState() {
    return _DashboardPageState(_currentUser);
  }
}

class _DashboardPageState extends State<DashboardPage> {
  User _currentUser;
  _DashboardPageState(this._currentUser);

  void _navigate() {
    Navigator.pushNamed(context, "/selectWorkout", arguments: _currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return _currentUser.getDocument() == null
        ? LoadingScreen()
        : _buildDashboardPage(context);
  }

  Scaffold _buildDashboardPage(BuildContext context) {
    print(_currentUser.getNextSession());
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
          _currentUser.getFirstName(),
          style: kMediumBoldTextStyle,
        ),
      ),
      drawer: Menu(_currentUser),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              child: DashboardCardTile(
                  heading: "LAST SESSION",
                  mainInfo: _currentUser.getLastSession() != null
                      ? _currentUser.getLastSession()["name"]
                      : "Nothing here yet!",
                  details: _currentUser.getLastSession() != null
                      ? _currentUser.getLastSession()["description"]
                      : "You have not done anyting yet."),
            ),
            CustomCard(
              cardChild: _currentUser.getChecklist() != null
                  ? _buildChecklist()
                  : DashboardCardTile(
                      heading: "CHECKLIST",
                      mainInfo: "Nothing here yet.",
                      details: "Create your checklist!",
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationButton(
          label: "LET'S GO!", action: _navigate, color: kGreenButtonColor),
    );
  }

  Widget _buildChecklist() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(child: Text("CHECKLIST", style: kLabelTextStyle)),
          Checklist(_currentUser.getChecklist())
        ],
      ),
    );
  }
}
