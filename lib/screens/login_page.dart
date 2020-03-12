import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference _db = FirebaseDatabase.instance.reference();

  void _loginAndNavigate() {
    _auth
        .signInWithEmailAndPassword(
            email: _emailTextController.text.toString().trim(),
            password: _passwordTextController.text.toString())
        .then((value) async {
      DataSnapshot _userDataSnapShot =
          await _db.child('/users/' + value.user.uid).once();
      Navigator.pushNamed(context, '/dashboard', arguments: _userDataSnapShot);
    }).catchError((e) {
      print('Sign In Failed!');
      _passwordTextController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Log In",
          style: kMediumBoldTextStyle,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: kContentPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Center(
                    child: Text('Welcome Back!', style: kLargeBoldTextStyle1x)),
              ),
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
                    "LOGIN",
                    style: kButtonTextFontStyle,
                  ),
                  onPressed: () {
                    if (_emailTextController.text.isNotEmpty) {
                      _loginAndNavigate();
                    } else {
                      // TODO: implement input verifications
                      print('Alert: Empty Fields');
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
