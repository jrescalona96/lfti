import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    'lfti',
                    style: kLargeBoldTextStyle2x,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        // TODO: navigate to log in page
                        Navigator.pushNamed(context, '/dashboard');
                      },
                      child: Container(
                        child: Text(
                          'LOG IN',
                          style: kButtonTextFontStyle,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      onPressed: () {
                        // TODO: navigate to sign up page
                      },
                      child: Container(
                        child: Text(
                          'SIGN UP',
                          style: kButtonTextFontStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
