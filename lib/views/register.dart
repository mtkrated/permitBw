import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permitappbw/services/authentication.dart';
import 'package:permitappbw/models/labeledCheck.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'home.dart';
import 'login.dart';

//final _formkey1 = GlobalKey<FormState>();
//FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("Users");

class Register extends StatefulWidget {
  Register({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  String _errorMessage;

  bool _isLoading;
  bool _isSelected = false;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
//  bool _isSelected = false;

//  @override
//  void initState() {
//    passwordController.addListener(() {
//      setState(() {});
//    });
//    emailController.addListener(() {
//      setState(() {});
//    });
//    super.initState();
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    emailController.dispose();
//    passwordController.dispose();
//  }
//
//  void register() {
//    _firebaseAuth
//        .createUserWithEmailAndPassword(
//        email: emailController.text, password: passwordController.text)
//        .then((result) {
//        Navigator.pushReplacement(
//          context,
//          MaterialPageRoute(builder: (context) => Form1(uid: result.user.uid)),
//        );
//        }).catchError((err) {
//      showDialog(
//          context: context,
//          builder: (BuildContext context) {
//            return AlertDialog(
//              title: Text("Error"),
//              content: Text(err.message),
//              actions: [
//                FlatButton(
//                  child: Text("Ok"),
//                  onPressed: () {
//                    Navigator.of(context).pop();
//                  },
//                )
//              ],
//            );
//          });
//    });
//  }

  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 20.0);
    TextStyle linkStyle = TextStyle(color: Colors.blue);
    return Scaffold(
      body: Stack(
        children: <Widget>[
            showForm(),
        ],
      ),
//        resizeToAvoidBottomInset: false,
    );
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget showForm(){
    return Center(
      child: new Container(
        padding: EdgeInsets.all(16.0),
        alignment: Alignment(0.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Create account',
                style: GoogleFonts.abel(
                    textStyle: TextStyle(
                      fontSize: 40.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0)
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter your email';
                    }
                    return null;
                  },
                  //onSaved: (value) => _email = value.trim(),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(height: 10.0,),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.lightBlueAccent)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0)
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter your password';
                    }
                    return null;
                  },
                  //onSaved: (value) => _password = value.trim(),
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
              LabeledCheck(
                label: 'I agree to the terms and privacy policy',
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                value: _isSelected,
                onChanged: (bool newValue) {
                  setState(() {
                    _isSelected = newValue;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                child: RaisedButton(
                  onPressed: () {
                    if(_isSelected){
                      validateAndSubmit;
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(38.0, 30.0, 30.0, 0.0),
                child: RichText(
                    text: new TextSpan(text: 'Already have an account? ',
                        style: TextStyle(color: Colors.black),
                        children: [
                          new TextSpan(
                              text: 'Sign in',
                              style: TextStyle(color: Colors.blue),
                              recognizer: new TapGestureRecognizer() ..onTap = (){
//                                        Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LogIn()),
                                );
                              }
                          )
                        ]
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (_formKey.currentState.validate()) {
      String userId = "";
      try {
          userId = await widget.auth.signUp(emailController.text, passwordController.text);
          print('Signed up user: $userId');
          setState(() {
          _isLoading = false;
        });
          if (userId.length > 0 && userId != null) {
            widget.loginCallback();
          }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }
}
