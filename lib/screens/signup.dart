import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permitappbw/models/user.dart';
import 'package:permitappbw/services/auth.dart';
import 'package:permitappbw/screens/home.dart';
import 'loginPage.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  final BaseAuth auth;

  SignUpPage({this.auth});
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final data = User();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem<int>> genderList = [];
  final format = DateFormat("dd/MM/yyyy");
  TextEditingController nameController =  TextEditingController();
  TextEditingController locationController =  TextEditingController();
  TextEditingController emailController =  TextEditingController();
  TextEditingController passwordController =  TextEditingController();
  TextEditingController nationalityController =  TextEditingController();
  TextEditingController identityController =  TextEditingController();
  TextEditingController number1Controller =  TextEditingController();
  TextEditingController physicalAddController =  TextEditingController();
  TextEditingController dateController =  TextEditingController();
  final focus = FocusNode();
  int _selectedGender = 0;

  Widget _showGender(){
    loadGenderList();
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
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

  @override
  Widget BasicDateField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Date of Birth',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            DateTimeField(
              format: format,
              controller: dateController,
              autovalidate: true,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
              },
            ),
          ]),
    );
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
      padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
      child: TextFormField(
        autofocus: false,
        obscureText: isPassword,
        controller: name,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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

  Widget _entryField2(String title, TextEditingController name, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
      child: TextFormField(
        autofocus: false,
        obscureText: isPassword,
        controller: name,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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

  Widget _entryField3(String title, TextEditingController name, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
      child: TextFormField(
        autofocus: false,
        obscureText: isPassword,
        controller: name,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
        validator: pwdValidator,
        cursorColor: Colors.lightBlueAccent,
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () async{
        if(_formKey.currentState.validate() && (dateController.text != '')){
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Center(child: CircularProgressIndicator(),);
              });
          await validateAndSubmit();
          Navigator.pop(context);
          _formKey.currentState.reset();
        }else{
          Fluttertoast.showToast(
              msg: "Please select date of birth",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.blueGrey,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.18,
        padding: EdgeInsets.symmetric(vertical: 15),
//        padding: EdgeInsets.fromLTRB(40.0, 6.0, 40.0, 6.0),
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
          'Sign Up',
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
        _entryField("Full name", nameController),
        _showGender(),
        BasicDateField(),
        _entryField("Identity No. (O)/(P)", identityController),
        _entryField("Nationality", nationalityController),
        _entryField("Location", locationController),
        _entryField("Physical Address", physicalAddController),
        _entryField("Number", number1Controller),
        _entryField2("Email", emailController),
        _entryField3("Password",passwordController, isPassword: true),
      ],
    );
  }
//  Widget _loginAccountLabel() {
//    return Container(
//      margin: EdgeInsets.symmetric(vertical: 20),
//      alignment: Alignment.bottomCenter,
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          Text(
//            'Already have an account ?',
//            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
//          ),
//          SizedBox(
//            width: 10,
//          ),
//          InkWell(
//            onTap: () {
//              Navigator.push(context,
//                  MaterialPageRoute(builder: (context) => LoginPage()));
//            },
//            child: Text(
//              'Login',
//              style: TextStyle(
//                  color: Color(0xfff79c4f),
//                  fontSize: 13,
//                  fontWeight: FontWeight.w600),
//            ),
//          )
//        ],
//      ),
//    );
//  }
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
//            child: SingleChildScrollView(
////              child: Container(
////                height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Stack(
                    children: <Widget>[
                      Align(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 5.0),
//                      child: Container(
//                            padding: EdgeInsets.symmetric(horizontal: 20),
                                //height: MediaQuery.of(context).size.height / 4,
                                child: ListView(
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    _title(),
                                    _emailPasswordWidget(),
                                    SizedBox(height: 8.0,),
                                    _submitButton(),
                                  ],
                                ),
//                          ),
                        ),
                      ),
                      Positioned(top: 40, left: 0, child: _backButton()),
                    ],
                  ),
              ),
//              ),
//            ),
          ),
      ),
    );
  }

  String getString(TextEditingController name,){
    return name.text;
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


  String pwdValidator(String value) {
    if (value.isEmpty) {
      return 'Required';
    } else if(value.length < 8) {
      return 'Password must be longer than 8 characters!';
    }else {
      return null;
    }
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

  Future<bool> validateAndSubmit() async {
    String userId = "";
    try {
      userId = await widget.auth.signUp(emailController.text.trim(), passwordController.text.trim()).then((userId){
        widget.auth.addData(new User(
          fullName: nameController.text.trim(),
          location: locationController.text.trim(),
          gender: getGender(_selectedGender),
          identificationNum: identityController.text.trim(),
          nationality: nationalityController.text.trim(),
          dateOfBirth: dateController.text.trim(),
          physicalAddress: physicalAddController.text.trim(),
          //email: emailController.text.trim(),
          phone: number1Controller.text.trim(),
        ));
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage(userId: userId, auth: widget.auth)));
      });
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