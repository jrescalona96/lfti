import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Session.dart';

class Session extends StatefulWidget {
  final Session session;
  Session({@required this.session});

  @override
  _SessionState createState() => _SessionState();
}

class _SessionState extends State<Session> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("session.name"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Text('Testing'),
          ),
        ],
      ),
    );
  }
}
