import "package:flutter/material.dart";

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/User.dart";

// component imports
import "package:lfti_app/components/menu.dart";
import "package:lfti_app/components/custom_card.dart";
import "package:lfti_app/components/bottom_navigation_button.dart";
import "package:lfti_app/components/empty_state_notification.dart";

// firestore import
import "package:cloud_firestore/cloud_firestore.dart";

class ChecklistPage extends StatefulWidget {
  final User _currentUser;
  ChecklistPage(this._currentUser);

  @override
  _ChecklistPageState createState() => _ChecklistPageState(_currentUser);
}

class _ChecklistPageState extends State<ChecklistPage> {
  final User _currentUser;
  List _checklist = List();

  _ChecklistPageState(this._currentUser) {
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
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: kCardBackground.withOpacity(0.8),
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

  // TODO: implement edit checklist
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
            Flexible(
              child: Text(
                _checklist[index].toString(),
                style: kMediumLabelTextStyle,
              ),
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
          "Checklist",
          style: kSmallTextStyle,
        ),
      ),
      drawer: Menu(this._currentUser),
      body: this._checklist.length > 0
          ? CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    Widget item;
                    if (index < this._checklist.length) {
                      item = buildChecklistItemCard(index);
                    }
                    return item;
                  }),
                ),
              ],
            )
          : EmptyStateNotification(sub: "Add Items to your Checklist first."),
      bottomNavigationBar: this._checklist.length > 0
          ? BottomNavigationButton(
              label: "SAVE", action: _saveChanges, color: kGreenButtonColor)
          : BottomNavigationButton(
              label: "ADD ITEM",
              action: _addChecklistItem,
              color: kBlueButtonColor,
            ),
    );
  }
}
