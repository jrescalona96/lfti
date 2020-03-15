import "package:flutter/material.dart";
import "package:lfti_app/classes/Constants.dart";

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
      ),
    );
  }
}
