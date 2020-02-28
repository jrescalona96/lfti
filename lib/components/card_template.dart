/// This class serves as template for all container

import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';

class CardTemplate extends StatelessWidget {
  final Widget cardChild;
  CardTemplate({this.cardChild});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kContentPadding,
      margin: kContentPadding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: kCardBackground,
      ),
      child: cardChild,
    );
  }
}
