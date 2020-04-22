import "package:flutter/material.dart";
import "package:lfti_app/classes/Constants.dart";

class ChecklistItemCard extends StatefulWidget {
  final Key key;
  final Function onTap, onOptionsTap;
  final IconData optionsIcon;
  final String data;
  final int index;
  ChecklistItemCard(
      {@required this.key,
      @required this.onTap,
      this.onOptionsTap,
      this.data = "",
      this.optionsIcon = Icons.delete,
      this.index});

  @override
  _ChecklistItemCardState createState() => _ChecklistItemCardState(
      key: this.key,
      onTap: this.onTap,
      onOptionsTap: this.onOptionsTap,
      data: this.data,
      optionsIcon: this.optionsIcon,
      index: this.index);
}

class _ChecklistItemCardState extends State<ChecklistItemCard> {
  Function onTap, onOptionsTap;
  IconData optionsIcon;
  String data;
  Key key;
  int index;

  _ChecklistItemCardState(
      {this.key,
      this.onTap,
      this.onOptionsTap,
      this.data,
      this.optionsIcon,
      this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 1.0),
      decoration: BoxDecoration(color: kCardBackground),
      child: GestureDetector(
        onTap: () => this.onTap(),
        child: Container(
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Text(this.data, style: kSmallBoldTextStyle),
              ),
              GestureDetector(
                onTap: () => this.onOptionsTap(),
                child: Icon(this.optionsIcon, color: kIconColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
