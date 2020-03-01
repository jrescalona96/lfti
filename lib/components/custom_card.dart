/// This class serves as template for all container

import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';

class CustomCard extends StatelessWidget {
  final Widget cardChild;
  final Function cardAction;
  CustomCard({@required this.cardChild, this.cardAction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: cardAction,
      child: Container(
        padding: kContentPadding,
        margin: kContentPadding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: kCardBackground,
        ),
        child: cardChild,
      ),
    );
  }
}
