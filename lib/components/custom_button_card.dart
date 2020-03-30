import "package:flutter/material.dart";
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/components/custom_card.dart";

class CustomButtonCard extends StatelessWidget {
  final Function onTap;
  final Color color;
  final IconData icon;
  const CustomButtonCard(
      {@required this.onTap, this.color, this.icon = Icons.add});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CustomCard(
        color: this.color,
        cardChild: Center(
          child: Icon(
            this.icon,
            size: 42.0,
            color: kIconColor,
          ),
        ),
        onTap: this.onTap,
      ),
    );
  }
}
