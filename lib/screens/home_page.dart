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
                child: Container(
                  padding: kContentPadding,
                  margin: kContentMargin,
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
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
                          Navigator.pushNamed(context, '/signup');
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
