import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:permitappbw/models/user.dart';
import 'package:permitappbw/services/auth.dart';
import 'package:permitappbw/views/signup2.dart';
import 'package:fluttertoast/fluttertoast.dart';

String _date = "Date of Birth";
int _selectedGender = 0;

class SignUpOne extends StatefulWidget {
  final User user;
  final BaseAuth auth;
  final VoidCallback loginCallback;
  SignUpOne({Key key, @required this.user,this.auth, this.loginCallback}) : super(key: key);

  @override
  _SignUpOneState createState() => _SignUpOneState();
}

class _SignUpOneState extends State<SignUpOne> {
  @override
  // TODO: implement widget
  SignUpOne get widget => super.widget;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nationalityController =  TextEditingController();
  TextEditingController identityController =  TextEditingController();
  TextEditingController number1Controller =  TextEditingController();
  TextEditingController number2Controller =  TextEditingController();

  DateTime initialDate = DateTime(DateTime.now().year - 16,DateTime.now().month,DateTime.now().day);
  List<DropdownMenuItem<int>> genderList = [];

  Future showDate() async{
    DateTime newDateTime = await showRoundedDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year - 16,DateTime.now().month,DateTime.now().day),
      borderRadius: 10,
    );
    _date = '${newDateTime.day} / ${newDateTime.month} / ${newDateTime.year}';
    setState(() {
    });
  }

  void loadGenderList() {
    genderList = [];
    genderList.add(new DropdownMenuItem(
      child: new Text('Male'),
      value: 0,
    ));
    genderList.add(new DropdownMenuItem(
      child: new Text('Female'),
      value: 1,
    ));
    genderList.add(new DropdownMenuItem(
      child: new Text('Other'),
      value: 2,
    ));
  }

  Widget _showGender(){
    loadGenderList();
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton(
          hint: new Text('Select Gender'),
          items: genderList,
          value: _selectedGender,
          onChanged: (value) {
            setState(() {
              _selectedGender = value;
            });
          },
          isExpanded: true,
        ),
      ),
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

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        if(_formKey.currentState.validate() && (_date != "Date of Birth")){
          widget.user.setGender(getGender(_selectedGender));
          widget.user.setdob(_date);
          widget.user.setNationality(nationalityController.text);
          widget.user.setIdNo(identityController.text);
          widget.user.setNo1(number1Controller.text);
          widget.user.setNo2(number2Controller.text);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpTwo(user: widget.user, auth: widget.auth,
          loginCallback: widget.loginCallback,)));
        } else if(_formKey.currentState.validate() && (_date != "Date of Birth")){
          Fluttertoast.showToast(
              msg: "Please select date of birth",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.blueGrey,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }else {
          return null;
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
  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _showGender(),
        _doB(),
        _entryField("Nationality", nationalityController),
        _entryField("Identity No. (O)/(P)", identityController),
        _entryField("Contact No.1", number1Controller),
        _entryField2("Contact No.2"),
      ],
    );
  }
  Widget _doB(){
    return Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 2.0,
                onPressed: showDate,
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.date_range,
                              size: 25.0,
                              color: Colors.lightBlueAccent,
                            ),
                            SizedBox(width: 20.0),
                            Text(
                              '$_date',
                              style: GoogleFonts.aBeeZee(
                                  textStyle: TextStyle(
                                    color: Colors.grey[600],
                                    letterSpacing: 2.0,
                                    fontSize: 20.0,
                                  )
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                color: Colors.white,
              )
            ],
          ),
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
                Positioned(top: 40, left: 0, child: _backButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getGender(int value){
    if (value == 0){
      return 'Male';
    }else if(value == 1){
      return 'Female';
    }else{
      return 'Other';
    }
  }
}
