import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'package:lfti_app/classes/Routine.dart';
import 'package:lfti_app/classes/TimedRoutine.dart';
import 'package:lfti_app/components/custom_card.dart';

class RoutineCard extends StatelessWidget {
  final routine;
  final Function onTap;
  final bool dottedBorder;
  final Function onOptionsTap;
  IconData optionsIcon;
  RoutineCard({
    @required this.routine,
    this.onTap,
    this.dottedBorder = false,
    this.onOptionsTap,
    this.optionsIcon,
  });

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
    return GestureDetector(
      onTap: this.onTap,
      child: CustomCard(
        color: routine.exercise.name == "Rest"
            ? kBlueButtonColor.withOpacity(0.1)
            : kGreenButtonColor.withOpacity(0.1),
        dottedBorder: this.dottedBorder,
        cardChild: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Exercise name
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        routine.exercise.name == null
                            ? "Null"
                            : routine.exercise.name,
                        style: routine.exercise.name == "Rest"
                            ? kMediumBoldTextStyle.copyWith(
                                color: kBlueButtonColor)
                            : kMediumBoldTextStyle.copyWith(
                                color: kGreenButtonColor),
                      ),
                    ),
                    this.onOptionsTap == null
                        ? SizedBox(height: 0.0)
                        : Expanded(
                            child: GestureDetector(
                              child: Container(
                                  alignment: AlignmentDirectional.topEnd,
                                  child: Icon(optionsIcon, size: 20.0)),
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
                          style: routine.exercise.name == "Rest"
                              ? kMediumLabelTextStyle.copyWith(
                                  color: kBlueButtonColor)
                              : kMediumLabelTextStyle.copyWith(
                                  color: kGreenButtonColor),
                        ),
                ),
              ],
            ),
            SizedBox(height: kSizedBoxHeight),
            Text(
              "Target: " + _generateTargetString(),
              style: routine.exercise.name == "Rest"
                  ? kMediumLabelTextStyle.copyWith(color: kBlueButtonColor)
                  : kMediumLabelTextStyle.copyWith(color: kGreenButtonColor),
            )
          ],
        ),
      ),
    );
  }
}
