import "package:flutter/material.dart";
import "package:lfti_app/components/checklist_generator.dart";
import "package:lfti_app/components/card_tile.dart";

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
          'username',
        ),
      ),
      body: ListView(
        children: <Widget>[
          CardTile('Last Workout', 'Chest', ''),
          CardTile('Next Workout', 'Arms', ''),
          CardTile('Nearby Gyms', "La Verne (2.0 miles)", "La Verne, CA 91768"),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: Theme.of(context).accentColor,
            ),
            child: Column(
              children: <Widget>[
                Text('Checklist', style: Theme.of(context).textTheme.headline),
                ChecklistGenerator(),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: RaisedButton(
              onPressed: () {
                // TODO: navigate to session page
              },
              child: Container(
                child: Text(
                  "Let's Go!",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
