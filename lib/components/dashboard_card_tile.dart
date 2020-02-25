import 'package:flutter/material.dart';

const inactiveCardColor = Color(0xFF1D1E33);
const activeCardColor = Color(0xFF111328);
const textGap = 5.0;

class DashboardCardTile extends StatelessWidget {
  final String heading;
  final String mainInfo;
  final String details;

  DashboardCardTile(
      {@required this.heading, @required this.mainInfo, this.details = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        color: Theme.of(context).accentColor,
      ),
      child: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                heading,
                style: Theme.of(context).textTheme.display2,
              ),
              SizedBox(
                height: textGap,
              ),
              Text(
                mainInfo,
                style: Theme.of(context).textTheme.subhead,
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: textGap,
              ),
              Text(
                details,
                style: Theme.of(context).textTheme.display3,
              ),
            ]),
      ),
    );
  }
}
