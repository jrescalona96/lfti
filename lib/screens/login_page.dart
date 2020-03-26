import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';
import "package:lfti_app/classes/User.dart";

// firebase imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  final Map<String, String> _emailAndPassword;
  LoginPage(this._emailAndPassword);
  @override
  _LoginPageState createState() => _LoginPageState(_emailAndPassword);
}

class _LoginPageState extends State<LoginPage> {
  Map<String, String> _emailAndPassword;
  _LoginPageState(this._emailAndPassword);

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _currentUser = User();

  bool _isInputNotEmpty() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty)
      return true;
    else
      return false;
  }

  void _init() {
    // _emailTextController.text = _emailAndPassword["email"];
    // _passwordTextController.text = _emailAndPassword["pw"];
    // TODO: DELETE BEFORE PUBLISH
    _emailTextController.text = "jrescalona@gmail.com";
    _passwordTextController.text = "thisisatest";
  }

  @override
  Widget build(BuildContext context) {
    _init();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Log In",
          style: kMediumBoldTextStyle,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: kContentPadding,
          child: Center(
            child: Column(
              children: <Widget>[
                Text('Welcome Back!', style: kMediumBoldTextStyle),
                Center(
                  child: SingleChildScrollView(
                    padding: kContentPadding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                            controller: _emailTextController,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                InputDecoration(labelText: "Email Address")),
                        SizedBox(height: kSizedBoxHeight),
                        TextFormField(
                            controller: _passwordTextController,
                            obscureText: true,
                            decoration: InputDecoration(labelText: "Password")),
                        SizedBox(height: kSizedBoxHeight),
                        SizedBox(height: kSizedBoxHeight),
                        RaisedButton(
                            child: Text(
                              "LOGIN",
                              style: kButtonTextFontStyle,
                            ),
                            onPressed: () async {
                              if (_isInputNotEmpty()) {
                                await _currentUser.login(
                                    _emailTextController.text.trim(),
                                    _passwordTextController.text);
                                if (_currentUser.isLoggedIn()) {
                                  print("Login Successfull: Logged in as " +
                                      _currentUser.getFirstName() +
                                      _currentUser.getLastName() +
                                      ", uid : " +
                                      _currentUser.getAuth().user.uid);
                                  Navigator.pushNamed(context, '/dashboard',
                                      arguments: _currentUser);
                                } else {
                                  // TODO: create an alert to tell the user of errror
                                  _passwordTextController.clear();
                                }
                              } else {
                                // TODO: implement alert dialog box
                                print('Alert: Empty Fields');
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
