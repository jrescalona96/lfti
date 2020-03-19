import "package:flutter/material.dart";
// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/User.dart";
// component imports
import "package:lfti_app/components/checklist.dart";
import "package:lfti_app/components/dashboard_card_tile.dart";
import "package:lfti_app/components/custom_card.dart";
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

  bool _isNotEmpty(String key) {
    return _currentUser.getDocument().data[key].length > 0;
  }

  bool _isDataSet(Map sessionData) {
    return (sessionData["name"] != null && sessionData["description"] != null);
  }

  @override
  Widget build(BuildContext context) {
    return _currentUser.getDocument() == null
        ? LoadingScreen()
        : _buildDashboardPage(context);
  }

  Scaffold _buildDashboardPage(BuildContext context) {
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
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              child: DashboardCardTile(
                  heading: "LAST SESSION",
                  mainInfo: _isDataSet(_currentUser.getLastSession())
                      ? _currentUser.getLastSession()["name"]
                      : "Nothing here yet!",
                  details: _isDataSet(_currentUser.getLastSession())
                      ? _currentUser.getLastSession()["description"]
                      : "You have not done anyting yet."),
            ),
            Container(
              child: DashboardCardTile(
                heading: "NEXT SESSION",
                mainInfo: _isDataSet(_currentUser.getNextSession())
                    ? _currentUser.getNextSession()["name"]
                    : "Nothing here yet!",
                details: _isDataSet(_currentUser.getNextSession())
                    ? _currentUser.getNextSession()["name"]
                    : "Add new workout routines.",
              ),
            ),
            CustomCard(
              cardChild: _isNotEmpty("checklist")
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
      bottomNavigationBar: GestureDetector(
        onTap: () => Navigator.pushNamed(context, "/selectWorkout",
            arguments: _currentUser),
        child: Container(
          color: kStartButtonColor,
          height: kStartButtonHeight,
          alignment: Alignment.center,
          child: Text(
            "LET'S GO!",
            style: kButtonBoldTextFontStyle,
          ),
        ),
      ),
    );
  }

  Widget _buildChecklist() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(child: Text("CHECKLIST", style: kLabelTextStyle)),
          Checklist(_currentUser.getDocument().data["checklist"])
        ],
      ),
    );
  }
}
