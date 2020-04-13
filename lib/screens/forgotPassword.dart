import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permitappbw/services/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flushbar/flushbar.dart';

class ForgotPassword extends StatefulWidget {
  final BaseAuth auth;

  ForgotPassword({this.auth});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController =  TextEditingController();

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

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () async{
        if (_formKey.currentState.validate()){
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Center(child: CircularProgressIndicator(),);
              });
          await validateAndSubmit();
          Navigator.pop(context);
          ;
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xffbef0ff), Color(0xfff5ffff)])),
        child: Text(
          'Reset password',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }

  Widget _entryField(String title, TextEditingController name) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        autofocus: false,
        controller: name,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.lightBlueAccent)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0)
          ),
          labelStyle: TextStyle(color: Colors.grey[700]),
          labelText: title,
        ),
        validator: emailValidator,
        cursorColor: Colors.lightBlueAccent,
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email", emailController),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
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
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: SizedBox(),
                      ),
                      Text(
                        'Reset Password',
                        style: GoogleFonts.abel(
                            textStyle: TextStyle(
                                color: Colors.black,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold,
                                fontSize: 40.0
                            )
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          'Please enter your email address',
                        style: GoogleFonts.abel(
                            textStyle: TextStyle(
                                color: Colors.black,
                                letterSpacing: 1.0,
//                                fontWeight: FontWeight.bold,
                                fontSize: 16.0
                            )
                        ),
                      ),
                      Text(
                        'to request a password reset',
                        style: GoogleFonts.abel(
                            textStyle: TextStyle(
                                color: Colors.black,
                                letterSpacing: 1.0,
//                                fontWeight: FontWeight.bold,
                                fontSize: 16.0
                            )
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      _emailPasswordWidget(),
                      SizedBox(
                        height: 20,
                      ),
                      _submitButton(),
                      Expanded(
                        flex: 3,
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
                Positioned(top: 40, left: 0, child: _backButton()),
              ],
            ),
          ),
        )
      ),
    );
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return 'Required';
    } else if(!regex.hasMatch(value)) {
      return 'Email format is invalid!';
    }else {
      return null;
    }
  }

  Future<bool> validateAndSubmit() async {
    try {
      await widget.auth.forgotPasswordEmail(emailController.text.trim());
      Flushbar(
        flushbarPosition: FlushbarPosition.BOTTOM,
        message: "Password Reset Email Sent",
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.red,
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
        leftBarIndicatorColor: Colors.red,
      )..show(context).then((value) => Navigator.pop(context));
    } catch (e) {
      print(e.message);
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(widget.auth.getExceptionText(e)),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
    await new Future.delayed(const Duration(seconds: 1));
    return true;
  }

}

