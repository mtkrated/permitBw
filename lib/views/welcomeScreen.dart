import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permitappbw/services/auth.dart';
import 'package:permitappbw/views/signup.dart';

import 'loginPage.dart';

class WelcomePage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback loginCallback;

  WelcomePage({this.auth, this.loginCallback});
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Widget loginButton(){
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.lightBlueAccent[100],
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.white),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'We',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: 'lco',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'me',
              style: TextStyle(color: Colors.blueAccent, fontSize: 30),
            ),
          ]),
    );
  }

  Widget signUpButton(){
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          border: Border.all(color: Colors.blue, width: 2),
        ),
        child: Text(
          'Register',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.shade200,
                      offset: Offset(2, 4),
                      blurRadius: 5,
                      spreadRadius: 2)
                ],
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xffbef0ff), Color(0xfff5ffff)])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _title(),
                SizedBox(
                  height: 80,
                ),
                loginButton(),
                SizedBox(
                  height: 20,
                ),
                signUpButton(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        )
    );
  }
}
