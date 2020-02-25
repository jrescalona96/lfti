import 'package:flutter/material.dart';
import 'package:lfti_app/classes/ChecklistItem.dart';

class ChecklistGenerator extends StatefulWidget {
  ChecklistGenerator({Key key}) : super(key: key);

  @override
  _ChecklistGeneratorState createState() => _ChecklistGeneratorState();
}

class _ChecklistGeneratorState extends State<ChecklistGenerator> {
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
            activeColor: Colors.green,
            value: item.getStatus(),
            title: Text(item.getDescription(),
                style: Theme.of(context).textTheme.body2),
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
