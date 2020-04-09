import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:permitappbw/models/user.dart';
import 'package:permitappbw/services/auth.dart';
import 'package:permitappbw/views/signup3.dart';


class SignUpTwo extends StatefulWidget {
  final User user;
  final BaseAuth auth;
  final VoidCallback loginCallback;
  SignUpTwo({Key key, @required this.user, this.auth, this.loginCallback}) : super(key: key);

  @override
  _SignUpTwoState createState() => _SignUpTwoState();
}

class _SignUpTwoState extends State<SignUpTwo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController physicalAddController =  TextEditingController();
  TextEditingController plotNoController =  TextEditingController();
  TextEditingController wardController =  TextEditingController();
  TextEditingController villageController =  TextEditingController();
  TextEditingController otherController =  TextEditingController();

  @override
  // TODO: implement widget
  SignUpTwo get widget => super.widget;

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
  Widget _entryField(String title, TextEditingController name,{bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
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
          widget.user.setPhyAdd(physicalAddController.text);
          widget.user.setPlot(plotNoController.text);
          widget.user.setWard(wardController.text);
          widget.user.setVil(villageController.text);
          widget.user.setOther(otherController.text);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpThree(user: widget.user,
          auth: widget.auth, loginCallback: widget.loginCallback,)));
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
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

  Widget _entryField2(String title,{bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: isPassword,
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
        cursorColor: Colors.lightBlueAccent,
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Physical Address", physicalAddController),
        _entryField("Plot/House Number", plotNoController),
        _entryField("Ward", wardController),
        _entryField("Village/City", villageController),
        _entryField2("Other"),
      ],
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
                Positioned(top: 40, left: 0, child: _backButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
