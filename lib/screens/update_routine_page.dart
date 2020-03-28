import "package:flutter/material.dart";

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/Routine.dart";
import "package:lfti_app/classes/user.dart";

class UpdateRoutinePage extends StatefulWidget {
  final Map _args;
  UpdateRoutinePage(this._args);

  @override
  _UpdateRoutinePageState createState() => _UpdateRoutinePageState(this._args);
}

class _UpdateRoutinePageState extends State<UpdateRoutinePage> {
  User _currentUser;
  Routine _routine;
  _UpdateRoutinePageState(Map args) {
    this._currentUser = args["user"];
    this._routine = args["routine"];
    _nameTextController = TextEditingController(text: _routine.exercise.name);
    _focusTextController = TextEditingController(text: _routine.exercise.focus);
    _repsTextController = TextEditingController(text: _routine.reps.toString());
    _setsTextController = TextEditingController(text: _routine.sets.toString());
  }

  TextEditingController _nameTextController,
      _focusTextController,
      _repsTextController,
      _setsTextController;

  bool _isNumber(String s) {
    return double.tryParse(s) == null ? false : true;
  }

  String _validateNumber(String s) {
    if (_isNumber(s)) {
      return "Please enter a valid number.";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_routine.exercise.name),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _nameTextController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Name"),
                ),
                SizedBox(height: kSizedBoxHeight),
                TextFormField(
                  controller: _focusTextController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Muscle Group Focus"),
                ),
                SizedBox(height: kSizedBoxHeight),
                // TODO: change to Dropdown menu (count from 1 - 500?)
                TextFormField(
                  controller: _repsTextController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Reps"),
                  validator: (val) => _validateNumber(val),
                ),
                SizedBox(height: kSizedBoxHeight),
                // TODO: change to Dropdown menu (count from 1 - 500?)
                TextFormField(
                  controller: _setsTextController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Sets"),
                  validator: (val) => _validateNumber(val),
                ),
                SizedBox(height: kSizedBoxHeight),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
