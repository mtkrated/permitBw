import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:permitappbw/services/authentication.dart';
import 'package:permitappbw/views/register.dart';
import 'package:permitappbw/views/welcome.dart';

import 'home.dart';

//FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//final _formkey2 = GlobalKey<FormState>();

class LogIn extends StatefulWidget {
  LogIn({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey2 = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;

  bool _isLoading;
  bool _isSelected = false;

  bool validateAndSave() {
    final form = _formKey2.currentState;
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
    _formKey2.currentState.reset();
    _errorMessage = "";
  }
//  TextEditingController emailController = TextEditingController();
//  TextEditingController passwordController = TextEditingController();
//
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
//  void logInToFb() {
//    firebaseAuth
//        .signInWithEmailAndPassword(
//        email: emailController.text, password: passwordController.text)
//        .then((result) {
//      Navigator.pushReplacement(
//        context,
//        MaterialPageRoute(builder: (context) => HomePage(uid: result.user.uid)),
//      );
//    }).catchError((err) {
//      print(err.message);
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
//


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            showForm(),
            _showCircularProgress()
          ],
        ),
    );
  }

  Widget showForm(){
    return Builder(
      builder: (context) => Form(
          key: _formKey2,
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(10.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Welcome Back',
                                style: GoogleFonts.abel(
                                    textStyle: TextStyle(
                                      fontSize: 40.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2.0,
                                    )
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Email",
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
                                      return 'Enter your email';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) => _email = value.trim(),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: TextFormField(
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
                                  onSaved: (value) => _password = value.trim(),
                                  keyboardType: TextInputType.visiblePassword,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                            'Sign in',
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
                            text: new TextSpan(text: 'Not registered? ',
                                style: TextStyle(color: Colors.black),
                                children: [
                                  new TextSpan(
                                      text: 'Create account',
                                      style: TextStyle(color: Colors.blue),
                                      recognizer: new TapGestureRecognizer() ..onTap = (){
                                        Navigator.pop(context);
//                                            Navigator.pushReplacement(
//                                              context,
//                                              MaterialPageRoute(builder: (context) => FormB()),
//                                            );
                                      }
                                  )
                                ]
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
      ),
    );
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your mail';
    }

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a Valid Email';
    else
      return null;
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
    if (validateAndSave()) {
      String userId = "";
      try {
        userId = await widget.auth.signIn(_email, _password);
        print('Signed in: $userId');
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
          _formKey2.currentState.reset();
        });
      }
    }
  }
}
