import "package:flutter/material.dart";

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/Routine.dart";

// TODO: Continue here, make statefull widget change ables to be textfields
class EditRoutineCard extends StatefulWidget {
  final Routine _routine;
  EditRoutineCard(this._routine);

  @override
  _EditRoutineCardState createState() => _EditRoutineCardState(_routine);
}

class _EditRoutineCardState extends State<EditRoutineCard> {
  Routine _routine;
  _EditRoutineCardState(this._routine);

  TextEditingController _nameTextController,
      _focusTextController,
      _repsTextController,
      _setsTextController,
      _descriptionTextController,
      _timeTextController;

  void _init() {
    setState(() {
      _nameTextController = TextEditingController(text: _routine.exercise.name);
      _focusTextController =
          TextEditingController(text: _routine.exercise.focus);
      _repsTextController =
          TextEditingController(text: _routine.reps.toString());
      _setsTextController =
          TextEditingController(text: _routine.sets.toString());
      _descriptionTextController =
          TextEditingController(text: _routine.reps.toString());
      _timeTextController = TextEditingController(
        text: _routine.timeToPerformInSeconds == null
            ? 120
            : _routine.timeToPerformInSeconds.toString(),
      );
    });
  }

  bool _isRestRoutine() {
    return _routine.exercise.name == "Rest";
  }

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
    _init();
    return Scaffold(
      appBar: AppBar(
        title: Text(_routine.exercise.name),
      ),
      body: _isRestRoutine()
          ? Container(
              child: Column(children: <Widget>[
                Text(
                  _routine.exercise.name,
                  style: kSmallTextStyle,
                ),
                SizedBox(
                  height: kSmallSizedBoxHeight,
                ),
                TextFormField(
                  controller: _timeTextController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Time(seconds)"),
                  validator: (val) => _validateNumber(val),
                ),
              ]),
            )
          : Container(
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
                        decoration:
                            InputDecoration(labelText: "Muscle Group Focus"),
                      ),
                      SizedBox(height: kSizedBoxHeight),
                      TextFormField(
                        controller: _descriptionTextController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: "Description"),
                      ),
                      SizedBox(height: kSizedBoxHeight),
                      TextFormField(
                        controller: _repsTextController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: "Reps"),
                        validator: (val) => _validateNumber(val),
                      ),
                      SizedBox(height: kSizedBoxHeight),
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
