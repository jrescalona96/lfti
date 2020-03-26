import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/User.dart";

// component imports
import "package:lfti_app/components/menu.dart";
import "package:lfti_app/components/custom_card.dart";
import "package:lfti_app/components/bottom_navigation_button.dart";

// firestore import
import "package:cloud_firestore/cloud_firestore.dart";

class EditChecklistPage extends StatefulWidget {
  final User _currentUser;
  EditChecklistPage(this._currentUser);

  @override
  _EditChecklistPageState createState() =>
      _EditChecklistPageState(_currentUser);
}

class _EditChecklistPageState extends State<EditChecklistPage> {
  final User _currentUser;
  List _checklist = List();

  _EditChecklistPageState(this._currentUser) {
    if (this._currentUser.getChecklist() == null) {
      this._currentUser.setChecklist(List());
    }
    _checklist = this._currentUser.getChecklist();
  }

  Future<void> _addChecklistItem() async {
    final _descriptionTextController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Checklist Item name"),
          content: TextFormField(
            controller: _descriptionTextController,
            keyboardType: TextInputType.text,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Add"),
              onPressed: () {
                this
                    ._currentUser
                    .getChecklist()
                    .add(_descriptionTextController.text);
                print(this._currentUser.getWorkoutList());
                setState(() {
                  this._checklist = this._currentUser.getChecklist();
                });
                print("Item Added!");
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editChecklistItem() {
    print("edit action");
  }

  void _deleteChecklistItem(int index) {
    _currentUser.getChecklist().removeAt(index);
    setState(() {
      _checklist = _currentUser.getChecklist();
    });
  }

  void _saveChanges() {
    try {
      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(_currentUser.getFirestoreReference(),
            {"checklist": _currentUser.getChecklist()});
      });
      print("Success: Checklist Updated!");
      Navigator.pushNamed(context, "/dashboard", arguments: _currentUser);
    } catch (e) {
      print("Error: Failed to update Checklist :" + e.toString());
    }
  }

  GestureDetector buildChecklistItemCard(int index) {
    return GestureDetector(
      onTap: () {
        _editChecklistItem();
      },
      child: CustomCard(
        cardChild: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _checklist[index].toString(),
              style: kMediumLabelTextStyle,
            ),
            GestureDetector(
              onTap: () {
                _deleteChecklistItem(index);
              },
              child: Icon(Icons.close),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(
          "Edit Checklist",
          style: kMediumBoldTextStyle,
        ),
      ),
      drawer: Menu(_currentUser),
      body: _checklist == null
          ? Container(
              width: double.infinity,
              child: CustomCard(
                cardChild: Icon(
                  FontAwesomeIcons.plus,
                  size: 24.0,
                ),
                cardAction: _addChecklistItem,
              ),
            )
          : SafeArea(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      Widget item;
                      if (index < _checklist.length) {
                        item = buildChecklistItemCard(index);
                      } else if (index == _checklist.length) {
                        item = CustomCard(
                          cardChild: Icon(
                            FontAwesomeIcons.plus,
                            size: 24.0,
                          ),
                          cardAction: _addChecklistItem,
                        );
                      }
                      return item;
                    }),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigationButton(
          label: "SAVE", action: _saveChanges, color: kGreenButtonColor),
    );
  }
}
