import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'package:lfti_app/classes/TimedRoutine.dart';
import 'package:lfti_app/components/custom_card.dart';

class RoutineCard extends StatelessWidget {
  final key;
  final routine;
  final Function onTap;
  final bool dottedBorder;
  final Function onOptionsTap;
  final IconData optionsIcon;
  final IconData dupOptionIcon;
  final Function onDupOptionTap;
  final bool shadowOn;
  RoutineCard(
      {@required this.routine,
      this.onTap,
      this.dottedBorder = false,
      this.optionsIcon = Icons.delete,
      this.onOptionsTap,
      this.dupOptionIcon = Icons.content_copy,
      this.onDupOptionTap,
      this.shadowOn = false,
      this.key});

  String _generateTargetString() {
    String target = '';
    if (routine is TimedRoutine)
      target = routine.timeToPerformInSeconds.toString() + ' sec';
    else {
      target = routine.reps.toString() +
          " reps x " +
          routine.sets.toString() +
          " sets";
    }
    return target;
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      shadow: this.shadowOn,
      key: Key(routine.id),
      onTap: this.onTap,
      color:
          routine.exercise.name == "Rest" ? kCardBackground : kAmberButtonColor,
      dottedBorder: this.dottedBorder,
      cardChild: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Exercise name
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        routine.exercise.name,
                        style: kMediumBoldTextStyle,
                      ),
                    ),
                    this.onOptionsTap == null
                        ? SizedBox(height: 0.0)
                        : Expanded(
                            child: GestureDetector(
                              child: Container(
                                  padding: EdgeInsets.zero,
                                  alignment: AlignmentDirectional.topEnd,
                                  child: Icon(optionsIcon, size: 25.0)),
                              onTap: this.onOptionsTap,
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: kSmallSizedBoxHeight,
                ),
                // Exercise Description
                Container(
                  child: routine is TimedRoutine
                      ? null
                      : Text(
                          routine.exercise.focus == null
                              ? "Null"
                              : routine.exercise.focus,
                          style: kSmallTextStyle,
                        ),
                ),
              ],
            ),
            SizedBox(height: kSizedBoxHeight),
            Row(
              children: <Widget>[
                Text(
                  "Target: " + _generateTargetString(),
                  style: kMediumLabelTextStyle,
                ),
                this.onDupOptionTap == null
                    ? SizedBox(height: 0.0)
                    : Expanded(
                        child: GestureDetector(
                          child: Container(
                              padding: EdgeInsets.zero,
                              alignment: AlignmentDirectional.topEnd,
                              child: Icon(dupOptionIcon, size: 25.0)),
                          onTap: this.onDupOptionTap,
                        ),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
