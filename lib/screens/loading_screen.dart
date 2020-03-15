import "package:flutter/material.dart";
import "package:lfti_app/classes/Constants.dart";

class LoaderPage extends StatelessWidget {
  const LoaderPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("Loading...", style: kMediumBoldTextStyle),
      ),
    );
  }
}
