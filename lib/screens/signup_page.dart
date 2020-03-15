import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import "package:lfti_app/classes/Constants.dart";

// firebase imports
import "package:firebase_auth/firebase_auth.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _dobTextController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _usersRef = Firestore.instance.collection("users");

  void _signUp() async {
    try {
      AuthResult _newUser = await _auth.createUserWithEmailAndPassword(
          email: _emailTextController.text,
          password: _passwordTextController.text);
      print("Sign Up Successfull. UID : " + _newUser.user.uid.toString());
      _initUser(_newUser.user.uid.toString());
      _signIn(_newUser.user.uid.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  void _signIn(String uid) async {
    try {
      DocumentSnapshot _userData = await _usersRef.document(uid).get();
      Navigator.pushNamed(context, "/dashboard", arguments: _userData);
    } catch (e) {
      print(e.toString());
    }
  }

  void _initUser(String newUserId) {
    print("Adding new user id : $newUserId");
    _usersRef.document(newUserId).setData({
      "firstName": _firstNameTextController.text,
      "lastName": _lastNameTextController.text,
      "dob": _dobTextController.text,
      "email": _emailTextController.text,
      "lastSession": -1,
      "nextSession": -1,
      "workouts": [],
      "checklist": []
    }).then((res) {
      print("User Added!");
    }).catchError((e) {
      print("Failed to Add User! " + e.toString());
    });
  }

  bool _isAllInputNotEmpty() {
    if (_firstNameTextController.text.isNotEmpty &&
        _lastNameTextController.text.isNotEmpty &&
        _dobTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty)
      return true;
    else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Hello Stranger!", style: kMediumBoldTextStyle),
      ),
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: kContentPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Center(
                      child:
                          Text("Welcome Back!", style: kLargeBoldTextStyle1x),
                    ),
                  ),
                  TextFormField(
                      controller: _firstNameTextController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: "First Name")),
                  SizedBox(height: kSizedBoxHeight),
                  TextFormField(
                      controller: _lastNameTextController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: "Last Name")),
                  SizedBox(height: kSizedBoxHeight),
                  TextFormField(
                      controller: _dobTextController,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(labelText: "Birthday")),
                  SizedBox(height: kSizedBoxHeight),
                  TextFormField(
                      controller: _emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: "Email Address")),
                  SizedBox(height: kSizedBoxHeight),
                  TextFormField(
                      controller: _passwordTextController,
                      obscureText: true,
                      decoration: InputDecoration(labelText: "Password")),
                  SizedBox(height: kSizedBoxHeight),
                  SizedBox(height: kSizedBoxHeight),
                  RaisedButton(
                      child: Text(
                        "SIGN UP",
                        style: kButtonTextFontStyle,
                      ),
                      onPressed: () async {
                        if (_isAllInputNotEmpty()) {
                          _signUp();
                        } else {
                          // TODO: implement alert dialog box
                          print("Alert: Empty Fields");
                        }
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
