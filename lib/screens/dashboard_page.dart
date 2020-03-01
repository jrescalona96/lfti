import "package:flutter/material.dart";
import "package:lfti_app/components/checklist.dart";
import "package:lfti_app/components/dashboard_card_tile.dart";
import 'package:lfti_app/classes/Constants.dart';
import 'package:lfti_app/components/custom_card.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String username = "Mond";

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
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              child: DashboardCardTile(
                heading: 'LAST SESSION',
                mainInfo: 'Monday Chest Day',
                details: 'Chest',
              ),
            ),
            Container(
              child: DashboardCardTile(
                heading: 'NEXT SESSION',
                mainInfo: 'Tuesday Arm Day',
                details: 'Legs',
              ),
            ),
            Container(
              child: DashboardCardTile(
                  heading: 'NEAREST GYM LOCATION',
                  mainInfo: "LA Fitness (2.0 miles)",
                  details: "La Verne, CA 91768"),
            ),
            // checklist section
            CustomCard(
              cardChild: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('CHECKLIST', style: kLabelTextStyle),
                    Checklist(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/selectWorkout'),
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
}
