import "package:flutter/material.dart";
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/components/loader.dart";

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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _usersRef = Firestore.instance.collection("users");

  AuthResult _newUser;
  DocumentReference _userDocumentRef;
  Loader _loader = Loader();

  void _signUp() async {
    setState(() async {
      try {
        _newUser = await _auth.createUserWithEmailAndPassword(
            email: _emailTextController.text,
            password: _passwordTextController.text);
        print("Sign Up Successfull. UID : " + _newUser.user.uid.toString());
        _initUser();
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
      "email": _emailTextController.text.trim(),
    }).then((res) {
      print("User Added!");
    }).catchError((e) {
      print("Failed to Add User! " + e.toString());
    });
  }

  bool _isAllInputNotEmpty() {
    if (_firstNameTextController.text.isNotEmpty &&
        _lastNameTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty)
      return true;
    else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("Hello Stranger!", style: kMediumBoldTextStyle),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: kContentPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text("Sign Up!", style: kMediumBoldTextStyle),
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
                          Navigator.pushNamed(context, "/login", arguments: {
                            "email": _emailTextController.text.trim(),
                            "pw": _passwordTextController.text
                          });
                        } else {
                          _loader.showAlertDialog(
                              "Incomplete", "Please complete form!", context);
                          print("Alert: Empty Fields");
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
