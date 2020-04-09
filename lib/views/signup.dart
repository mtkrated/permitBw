import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permitappbw/models/user.dart';
import 'package:permitappbw/services/auth.dart';
import 'package:permitappbw/ui/state_widget.dart';
import 'package:permitappbw/views/signup1.dart';
import 'loginPage.dart';
//import 'package:flushbar/flushbar.dart';
import 'package:flutter/services.dart';


class SignUpPage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback loginCallback;

  SignUpPage({this.auth, this.loginCallback});
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final data = User();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController =  TextEditingController();
  TextEditingController surnameController =  TextEditingController();
  TextEditingController emailController =  TextEditingController();
  TextEditingController passwordController =  TextEditingController();

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

  Widget _entryField(String title, TextEditingController name, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        autofocus: false,
        obscureText: isPassword,
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
        validator: (value) {
          if (value.isEmpty) {
            return 'Required!';
          }
          return null;
        },
        cursorColor: Colors.lightBlueAccent,
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        if(_formKey.currentState.validate()){
          checkUserEmail(email: emailController.text, password: passwordController.text, context: context);
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
          'Continue',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Bot',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: 'swa',
              style: TextStyle(color: Colors.blue, fontSize: 30),
            ),
            TextSpan(
              text: 'na',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ]),
    );
  }


  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Name", nameController),
        _entryField("Surname", surnameController),
        _entryField("Email", emailController),
        _entryField("Password",passwordController, isPassword: true),
      ],
    );
  }
  Widget _loginAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Already have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
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
                        _title(),
                        SizedBox(
                          height: 50,
                        ),
                        _emailPasswordWidget(),
                        SizedBox(
                          height: 20,
                        ),
                        _submitButton(),
                        Expanded(
                          flex: 2,
                          child: SizedBox(),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _loginAccountLabel(),
                  ),
                  Positioned(top: 40, left: 0, child: _backButton()),
                ],
              ),
            ),
          ),
        ),
    );
  }

  String getString(TextEditingController name,){
    return name.text;
  }

  void checkUserEmail({String email, String password, BuildContext context}) async{
    if(_formKey.currentState.validate()){
      try{
        await widget.auth.signIn(email, password).then((uid) => Navigator.of(context).pop());
      }catch(e){
        data.setName(nameController.text);
        data.setEmail(emailController.text);
        data.setSurname(surnameController.text);
        data.setPassword(passwordController.text);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpOne(user: data, auth: widget.auth, loginCallback: widget.loginCallback,)));
      }
    }
  }
}
