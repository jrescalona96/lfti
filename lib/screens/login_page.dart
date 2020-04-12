import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'package:lfti_app/classes/Loader.dart';
import "package:lfti_app/classes/User.dart";
import "package:firebase_auth/firebase_auth.dart";

class LoginPage extends StatefulWidget {
  final Map<String, String> _emailAndPassword;
  LoginPage(this._emailAndPassword);
  @override
  _LoginPageState createState() => _LoginPageState(_emailAndPassword);
}

class _LoginPageState extends State<LoginPage> {
  Map<String, String> _userCredentials;
  _LoginPageState(this._userCredentials);
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _loader = Loader();

  void _init() {
    _emailTextController.text = _userCredentials["email"];
    _passwordTextController.text = _userCredentials["pw"];
  }

  Future<User> _login(String email, String password) async {
    User _currentUser = User();
    AuthResult auth;
    DocumentReference ref;
    DocumentSnapshot ds;
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      auth = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      ref = Firestore.instance.collection("users").document(auth.user.uid);
      ds = await ref.get();
      _currentUser.setAuthResult(auth);
      _currentUser.setDatabaseReference(ref);
      _currentUser.setDocumentSnapshot(ds);
      _currentUser.initUserData();
      print("Success: Logged in complete!");
      return Future.value(_currentUser);
    } catch (e) {
      print("Error: Unable to Log in! $e");
      return Future.error(e);
    }
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
                              try {
                                _login(_emailTextController.text.trim(),
                                        _passwordTextController.text)
                                    .then(
                                      (val) => Navigator.pushNamed(
                                          context, "/dashboard",
                                          arguments: val),
                                    )
                                    .catchError(
                                      (e) => print("Error: Log In Failed"),
                                    );
                                _loader.showLoadingDialog(context);
                              } catch (e) {
                                _loader.showAlertDialog("Failed to Log In!",
                                    "Please try again.", context);
                                print("Error: User Initialization Failed! $e");
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
