import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance; // init firebase _auth

  void _signInThenNavigateToNextPage(
      {@required String email, @required String pw}) {
    _auth.signInWithEmailAndPassword(email: email, password: pw).then((value) {
      print('User successcully Signed In!');
      Navigator.pushNamed(context, '/dashboard', arguments: value.user);
    }).catchError((e) {
      print('Sign In Failed! ==> ' + e.toString());
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
                      _signInThenNavigateToNextPage(
                          email:
                              _emailTextController.text.toString().trimRight(),
                          pw: _passwordTextController.text.toString());
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
