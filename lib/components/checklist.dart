import 'package:flutter/material.dart';
import 'package:lfti_app/classes/ChecklistItem.dart';
import 'package:lfti_app/classes/Constants.dart';

class Checklist extends StatefulWidget {
  Checklist({Key key}) : super(key: key);

  @override
  _ChecklistState createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  final List<ChecklistItem> _checklist = [
    ChecklistItem('Shaker', false),
    ChecklistItem('Towel', false),
    ChecklistItem('Shoes', false),
    ChecklistItem('Protein Shake', false),
    ChecklistItem('BCAA', false),
    ChecklistItem('Earphones', false),
    ChecklistItem('Wrist Wrap', false),
    ChecklistItem('Shaker', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _checklist.map(
        (item) {
          return CheckboxListTile(
            activeColor: Colors.blueAccent,
            value: item.getStatus(),
            title: Text(
              item.getDescription(),
              style: kMediumTextStyle,
            ),
            onChanged: (bool newStatus) {
              setState(
                () => item.setStatus(newStatus),
              );
            },
          );
        },
      ).toList(),
    );
  }
}
