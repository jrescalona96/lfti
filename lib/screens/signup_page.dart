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
  final _dayTextController = TextEditingController();
  final _monthTextController = TextEditingController();
  final _yearTextController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _usersRef = Firestore.instance.collection("users");

  AuthResult _newUser;
  DocumentReference _userDocumentRef;

  void _signUp() async {
    setState(() async {
      try {
        _newUser = await _auth.createUserWithEmailAndPassword(
            email: _emailTextController.text,
            password: _passwordTextController.text);
        print("Sign Up Successfull. UID : " + _newUser.user.uid.toString());
        _initUser();
        _login();
      } catch (e) {
        print(e.toString());
      }
    });
  }

  void _initUser() {
    print("Adding new user id : " + _newUser.user.uid.toString());
    setState(() {
      _userDocumentRef = _usersRef.document(_newUser.user.uid.toString());
    });

    _userDocumentRef == null
        ? print("Error: Document Reference not Set!")
        : print("Document Reference Set!");

    // initialize user database
    _userDocumentRef.setData({
      "firstName": _firstNameTextController.text,
      "lastName": _lastNameTextController.text,
      "dob": {
        "month": _monthTextController.text,
        "day": _dayTextController.text,
        "year": _yearTextController.text
      },
      "email": _emailTextController.text,
      "lastSessionIndex": -1,
      "nextSessionIndex": -1,
      "workouts": [],
      "checklist": []
    }).then((res) {
      print("User Added!");
    }).catchError((e) {
      print("Failed to Add User! " + e.toString());
    });
  }

  void _login() {
    print("Loggin in as : " + _newUser.user.uid);
    Navigator.pushNamed(context, "/login", arguments: {
      "email": _emailTextController.text.trim(),
      "pw": _passwordTextController.text
    });
  }

  bool _isAllInputNotEmpty() {
    if (_firstNameTextController.text.isNotEmpty &&
        _lastNameTextController.text.isNotEmpty &&
        _dayTextController.text.isNotEmpty &&
        _monthTextController.text.isNotEmpty &&
        _yearTextController.text.isNotEmpty &&
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Birthday", style: kLabelTextStyle),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                                controller: _dayTextController,
                                keyboardType: TextInputType.text,
                                decoration:
                                    InputDecoration(labelText: "Month")),
                          ),
                          SizedBox(width: kSizedBoxHeight),
                          Expanded(
                            child: TextFormField(
                                controller: _monthTextController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(labelText: "Day")),
                          ),
                          SizedBox(width: kSizedBoxHeight),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                                controller: _yearTextController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(labelText: "Year")),
                          ),
                        ],
                      ),
                    ],
                  ),
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
