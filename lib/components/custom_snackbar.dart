import "package:flutter/material.dart";
import "package:lfti_app/classes/Constants.dart";

class CustomSnackBar extends StatelessWidget {
  final String message;
  CustomSnackBar({@required this.message});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      duration: Duration(seconds: 2),
      content: Text(
        "$message",
        style: kSmallTextStyle.copyWith(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
