import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/User.dart";
import "package:lfti_app/components/menu.dart";
import "package:lfti_app/components/custom_card.dart";
import "package:lfti_app/components/bottom_navigation_button.dart";
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
  List _checklist;

  _EditChecklistPageState(this._currentUser) {
    this._checklist = this._currentUser.getChecklist();
  }

  Future<void> _addChecklistItem() async {
    final _descriptionTextController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Description'),
          content: TextFormField(
            controller: _descriptionTextController,
            keyboardType: TextInputType.text,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("ADD"),
              onPressed: () {
                print("Item Added!");
                _currentUser
                    .getChecklist()
                    .add(_descriptionTextController.text);
                setState(() {
                  _checklist = _currentUser.getChecklist();
                });
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
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
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
}
