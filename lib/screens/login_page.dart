import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';

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

  FirebaseAuth _auth = FirebaseAuth.instance;
  final _usersRef = Firestore.instance.collection("users");

  Future<AuthResult> _login() async {
    return _auth.signInWithEmailAndPassword(
        email: _emailTextController.text.trim(),
        password: _passwordTextController.text);
  }

  DocumentReference _fetchUserData(AuthResult res) {
    print("Fetching Data.");
    return _usersRef.document(res.user.uid);
  }

  bool _isInputNotEmpty() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty)
      return true;
    else
      return false;
  }

  void _init() {
    _emailTextController.text = _emailAndPassword["email"];
    _passwordTextController.text = _emailAndPassword["pw"];
  }

  @override
  Widget build(BuildContext context) {
    _init();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                  // initialValue: _emailAndPassword["email"] == null
                  //     ? _emailTextController.text
                  //     : _emailAndPassword["email"],
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Email Address")),
              SizedBox(height: kSizedBoxHeight),
              TextFormField(
                  controller: _passwordTextController,
                  // initialValue: _emailAndPassword["pw"] == null
                  //     ? _passwordTextController.text
                  //     : _emailAndPassword["pw"],
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
                    if (_isInputNotEmpty()) {
                      _login().then((res) {
                        Navigator.pushNamed(context, '/dashboard',
                            arguments: _fetchUserData(res));
                      });
                    } else {
                      // TODOL: implement alert dialog box
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
