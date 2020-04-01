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
    _userDocumentRef.setData(
        //   {
        //   "firstName": _firstNameTextController.text,
        //   "lastName": _lastNameTextController.text,
        //   "dob": {
        //     "month": int.parse(_monthTextController.text),
        //     "day": int.parse(_dayTextController.text),
        //     "year": int.parse(_yearTextController.text)
        //   },
        //   "email": _emailTextController.text.trim(),
        // }
        {
          "firstName": "Richmond",
          "lastName": "Escalona",
          "dob": {"month": 9, "day": 6, "year": 1990},
          "email": "test@test.com",
          "lastSession": {
            "name": "Taco Tuesday",
            "description": "Second workout of the week",
            "date": "03/25/2019"
          },
          "nextSession": {
            "name": "Chestday Monday",
            "description": "First workout of the week",
            "date": null
          },
          "workouts": [
            {
              "id": "tempid1",
              "name": "Chestday",
              "description": "First workout of the week",
              "routines": [
                {
                  "type": "COUNTED",
                  "exercise": {"name": "Barbell Bench Press", "focus": "Chest"},
                  "reps": 10,
                  "sets": 3
                },
                {
                  "type": "TIMED",
                  "exercise": {"name": "Rest", "focus": null},
                  "timeToPerformInSeconds": 60
                },
                {
                  "type": "COUNTED",
                  "exercise": {"name": "Dumbell Press", "focus": "Chest"},
                  "reps": 10,
                  "sets": 3
                },
                {
                  "type": "TIMED",
                  "exercise": {"name": "Rest", "focus": null},
                  "timeToPerformInSeconds": 60
                },
                {
                  "type": "COUNTED",
                  "exercise": {"name": "Dumbell Fly", "focus": "Chest"},
                  "reps": 10,
                  "sets": 3
                },
                {
                  "type": "TIMED",
                  "exercise": {"name": "Rest", "focus": null},
                  "timeToPerformInSeconds": 60
                },
                {
                  "type": "COUNTED",
                  "exercise": {"name": "Push Up", "focus": "Chest"},
                  "reps": 10,
                  "sets": 3
                },
                {
                  "type": "TIMED",
                  "exercise": {"name": "Rest", "focus": null},
                  "timeToPerformInSeconds": 60
                },
                {
                  "type": "COUNTED",
                  "exercise": {"name": "Fly", "focus": "Chest"},
                  "reps": 10,
                  "sets": 3
                },
                {
                  "type": "TIMED",
                  "exercise": {"name": "Rest", "focus": null},
                  "timeToPerformInSeconds": 60
                },
                {
                  "type": "COUNTED",
                  "exercise": {
                    "name": "Decline dumbbell bench press",
                    "focus": "Chest"
                  },
                  "reps": 10,
                  "sets": 3
                },
                {
                  "type": "TIMED",
                  "exercise": {"name": "Rest", "focus": null},
                  "timeToPerformInSeconds": 60
                },
                {
                  "type": "COUNTED",
                  "exercise": {"name": "Dumbell pullover", "focus": "Chest"},
                  "reps": 10,
                  "sets": 3
                },
                {
                  "type": "TIMED",
                  "exercise": {"name": "Rest", "focus": null},
                  "timeToPerformInSeconds": 60
                },
                {
                  "type": "COUNTED",
                  "exercise": {"name": "Cable Iron Cross", "focus": "Chest"},
                  "reps": 10,
                  "sets": 3
                }
              ]
            },
            {
              "id": "tempid0",
              "name": "Backday",
              "description": "Second workout of the week",
              "routines": [
                {
                  "type": "COUNTED",
                  "exercise": {"name": "Barbell Deadlift", "focus": "Back"},
                  "reps": 10,
                  "sets": 3
                },
                {
                  "type": "TIMED",
                  "exercise": {"name": "Rest", "focus": null},
                  "timeToPerformInSeconds": 60
                },
                {
                  "type": "COUNTED",
                  "exercise": {
                    "name": "Pull-Ups With A Wide Grip",
                    "focus": "Back"
                  },
                  "reps": 10,
                  "sets": 3
                },
                {
                  "type": "TIMED",
                  "exercise": {"name": "Rest", "focus": null},
                  "timeToPerformInSeconds": 60
                },
                {
                  "type": "COUNTED",
                  "exercise": {
                    "name": "Standing T-Bar Rowing",
                    "focus": "Back"
                  },
                  "reps": 10,
                  "sets": 3
                },
                {
                  "type": "TIMED",
                  "exercise": {"name": "Rest", "focus": null},
                  "timeToPerformInSeconds": 60
                },
                {
                  "type": "COUNTED",
                  "exercise": {
                    "name": "Seated Cable Rowing With A Wide Grip",
                    "focus": "Back"
                  },
                  "reps": 10,
                  "sets": 3
                },
                {
                  "type": "TIMED",
                  "exercise": {"name": "Rest", "focus": null},
                  "timeToPerformInSeconds": 60
                },
                {
                  "type": "COUNTED",
                  "exercise": {"name": "Smith Machine Rowing", "focus": "Back"},
                  "reps": 10,
                  "sets": 3
                },
                {
                  "type": "TIMED",
                  "exercise": {"name": "Rest", "focus": null},
                  "timeToPerformInSeconds": 60
                },
                {
                  "type": "COUNTED",
                  "exercise": {
                    "name": "Pull-Downs With A Narrow Grip",
                    "focus": "Back"
                  },
                  "reps": 10,
                  "sets": 3
                },
                {
                  "type": "TIMED",
                  "exercise": {"name": "Rest", "focus": null},
                  "timeToPerformInSeconds": 60
                },
                {
                  "type": "COUNTED",
                  "exercise": {
                    "name": "Single-Arm Dumbbell Row",
                    "focus": "Back"
                  },
                  "reps": 10,
                  "sets": 3
                },
                {
                  "type": "TIMED",
                  "exercise": {"name": "Rest", "focus": null},
                  "timeToPerformInSeconds": 60
                },
                {
                  "exercise": {
                    "name": "Dumbbell Pull-Over On A Decline Bench",
                    "focus": "Back"
                  },
                  "reps": 10,
                  "sets": 3
                }
              ]
            },
            {
              "id": "tempid2",
              "name": "Leg Day",
              "description": "Third workout of the week",
              "routines": [
                {
                  "type": "COUNTED",
                  "exercise": {"name": "Barbell Squat", "focus": "Leg"},
                  "reps": 10,
                  "sets": 3
                },
                {
                  "type": "TIMED",
                  "exercise": {"name": "Rest", "focus": null},
                  "timeToPerformInSeconds": 60
                },
                {
                  "type": "COUNTED",
                  "exercise": {"name": "Leg Press", "focus": "Leg"},
                  "reps": 10,
                  "sets": 3
                },
                {
                  "type": "TIMED",
                  "exercise": {"name": "Rest", "focus": null},
                  "timeToPerformInSeconds": 60
                },
                {
                  "type": "COUNTED",
                  "exercise": {
                    "name": "Dumbbell Walking Lunge",
                    "focus": "Leg"
                  },
                  "reps": 10,
                  "sets": 3
                },
                {
                  "type": "TIMED",
                  "exercise": {"name": "Rest", "focus": null},
                  "timeToPerformInSeconds": 60
                },
                {
                  "type": "COUNTED",
                  "exercise": {"name": "Leg Extensions", "focus": "Leg"},
                  "reps": 10,
                  "sets": 3
                },
                {
                  "type": "TIMED",
                  "exercise": {"name": "Rest", "focus": null},
                  "timeToPerformInSeconds": 60
                },
                {
                  "type": "COUNTED",
                  "exercise": {"name": "Romanian Deadlift", "focus": "Leg"},
                  "reps": 10,
                  "sets": 3
                },
                {
                  "type": "TIMED",
                  "exercise": {"name": "Rest", "focus": null},
                  "timeToPerformInSeconds": 60
                },
                {
                  "type": "COUNTED",
                  "exercise": {"name": "Lying Leg Curls", "focus": "Leg"},
                  "reps": 10,
                  "sets": 3
                },
                {
                  "type": "TIMED",
                  "exercise": {"name": "Rest", "focus": null},
                  "timeToPerformInSeconds": 60
                },
                {
                  "type": "COUNTED",
                  "exercise": {"name": "Standing Calf Raises", "focus": "Leg"},
                  "reps": 10,
                  "sets": 3
                }
              ]
            }
          ],
          "checklist": [
            "shoes",
            "shaker",
            "pre-workout",
            "protien shake",
            "sanitizer",
            "self",
            "friend"
          ]
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
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("Hello Stranger!", style: kMediumBoldTextStyle),
      ),
      body: SafeArea(
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
                              decoration: InputDecoration(labelText: "Month")),
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
      ),
    );
  }
}
