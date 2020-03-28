/// This class serves as template for all container
import "package:dotted_border/dotted_border.dart";
import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';

class CustomCard extends StatelessWidget {
  final Widget cardChild;
  final Function onTap;
  bool dottedBorder;
  CustomCard({@required this.cardChild, this.onTap, this.dottedBorder = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        margin: kCardMargin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: kCardBackground,
        ),
        child: DottedBorder(
          color: dottedBorder ? Colors.white24 : Colors.transparent,
          strokeWidth: 3,
          padding: kContentPadding,
          dashPattern: [6.0, 6.0, 6.0, 6.0],
          child: cardChild,
        ),
      ),
    );
  }
}
