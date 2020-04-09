import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:permitappbw/models/user.dart';
import 'package:permitappbw/services/auth.dart';
import 'package:permitappbw/views/home.dart';

class SignUpThree extends StatefulWidget {
  final User user;
  final BaseAuth auth;
  final VoidCallback loginCallback;
  SignUpThree({Key key, @required this.user, this.auth, this.loginCallback}) : super(key: key);

  @override
  _SignUpThreeState createState() => _SignUpThreeState();
}

class _SignUpThreeState extends State<SignUpThree> {
  String _errorMessage;

  bool _isLoading;
  bool _isSelected = false;

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  @override
  // TODO: implement widget
  SignUpThree get widget => super.widget;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController name1Controller =  TextEditingController();
  TextEditingController surname1Controller =  TextEditingController();
  TextEditingController numberOneController =  TextEditingController();
  TextEditingController name2Controller =  TextEditingController();
  TextEditingController surname2Controller =  TextEditingController();
  TextEditingController numberTwoController =  TextEditingController();

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
        cursorColor: Colors.lightBlueAccent,
      ),
    );
  }

  Widget _box(String title, Widget _entry1, Widget _entry2, Widget _entry3){
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: myBoxDecoration(),
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                title,
                style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      color: Colors.blueAccent,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    )
                ),
              ),
            ),
            _entry1,
            _entry2,
            _entry3,
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        validateAndSubmit();
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
  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _box('Member 1 Details',_entryField("Name" ,name1Controller),_entryField("Surname", surname1Controller),_entryField("Number", numberOneController)),
        _box('Member 2 Details',_entryField("Name", name2Controller),_entryField("Surname", surname2Controller),_entryField("Number", numberTwoController)),
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

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (_formKey.currentState.validate()) {
      String userId = "";
      try {
        userId = await widget.auth.signUp(widget.user.email, widget.user.password).then((userId){
          widget.auth.addData(new User(
            name: widget.user.name,
            surname: widget.user.surname,
            gender: widget.user.gender,
            idNumber: widget.user.idNumber,
            nationality: widget.user.nationality,
            doB: widget.user.doB,
            physicalAdd: widget.user.physicalAdd,
            plotNo: widget.user.plotNo,
            ward: widget.user.ward,
            villageCity: widget.user.villageCity,
            email: widget.user.email,
            number1: widget.user.number1,
            number2: widget.user.number2,
            other: widget.user.other,
            member1Name: name1Controller.text,
            member1Surname: surname1Controller.text,
            member1Number: numberOneController.text,
            member2Name: name2Controller.text,
            member2Surname: surname2Controller.text,
            member2Number: numberTwoController.text,
          ));
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage(userId: userId, auth: widget.auth, logoutCallback: widget.loginCallback,)));
        });
        print('Signed up user: $userId');
        setState(() {
          _isLoading = false;
        });
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

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(color: Colors.lightBlueAccent),
    borderRadius: BorderRadius.circular(10.0),
  );
}