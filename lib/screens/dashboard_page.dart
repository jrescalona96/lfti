import "package:flutter/material.dart";
import "package:lfti_app/components/checklist_generator.dart";
import "package:lfti_app/components/dashboard_card_tile.dart";

const contentMargin = EdgeInsets.all(15.0);
const contentPadding = EdgeInsets.all(15.0);
const cardPadding = 20.0;
const startButtonHeight = 85.0;
const startButtonWidth = double.infinity;
const startButtonColor = Colors.blueAccent;

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String username = "Mon";
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
          "Hello $username!",
          style: Theme.of(context).textTheme.body2,
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/selectWorkout'),
        child: Container(
          color: startButtonColor,
          height: startButtonHeight,
          alignment: Alignment.center,
          child: Text(
            "Let's go!",
            style: Theme.of(context).textTheme.subhead,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
              margin: contentMargin,
              child: DashboardCardTile(
                  heading: 'Last Workout', mainInfo: 'Chest')),
          Container(
              margin: contentMargin,
              child:
                  DashboardCardTile(heading: 'Next Workout', mainInfo: 'Arms')),
          Container(
            margin: contentMargin,
            child: DashboardCardTile(
                heading: 'Nearby Gyms',
                mainInfo: "LA Fitness (2.0 miles)",
                details: "La Verne, CA 91768"),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: contentMargin,
            padding: contentPadding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: Theme.of(context).accentColor,
            ),
            child: Column(
              children: <Widget>[
                Text('Checklist', style: Theme.of(context).textTheme.title),
                ChecklistGenerator(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
