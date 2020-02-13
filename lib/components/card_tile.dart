import 'package:flutter/material.dart';

class CardTile extends StatelessWidget {
  String _heading = '';
  String _mainInfo = '';
  String _subInfo = '';

  CardTile(this._heading, this._mainInfo, this._subInfo);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Theme.of(context).accentColor,
      ),
      child: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _heading,
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                _mainInfo,
                style: Theme.of(context).textTheme.headline,
                textAlign: TextAlign.left,
              ),
              Text(_subInfo),
            ]),
      ),
    );
  }
}
