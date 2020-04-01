import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:lfti_app/classes/Constants.dart";

class CustomButtonCard extends StatelessWidget {
  final Function onTap;
  final Color color;
  final IconData icon;
  const CustomButtonCard(
      {@required this.onTap, this.color, this.icon = FontAwesomeIcons.plus});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: this.color,
        child: Center(
          child: Icon(
            this.icon,
            size: 30.0,
            color: kIconColor,
          ),
        ),
      ),
      onTap: this.onTap,
    );
  }
}
