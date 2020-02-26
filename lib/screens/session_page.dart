import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Session.dart';

const textGap = 5.0;

class SessionPage extends StatefulWidget {
  final Session session;
  SessionPage({Key key, @required this.session}) : super(key: key);

  @override
  _SessionPageState createState() => _SessionPageState(session: session);
}

class _SessionPageState extends State<SessionPage> {
  final Session session;
  _SessionPageState({this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(session.name),
      ),
      body: Column(
        children: <Widget>[
          Container(
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
                    // Exercise
                    Text(
                      'Exercise',
                      style: Theme.of(context).textTheme.display2,
                    ),
                    SizedBox(
                      height: textGap,
                    ),
                    Text(
                      session.workout.routines[0].exercise.name,
                      style: Theme.of(context).textTheme.subhead,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: textGap,
                    ),
                    // Target
                    Text(
                      'Target',
                      style: Theme.of(context).textTheme.display2,
                    ),
                    SizedBox(
                      height: textGap,
                    ),
                    Text(
                      session.workout.routines[0].reps.toString(),
                      style: Theme.of(context).textTheme.subhead,
                      textAlign: TextAlign.left,
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
