import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permitappbw/models/user.dart';
import 'package:permitappbw/classes/values.dart';


final _formKey = GlobalKey<FormState>();
final nameController = TextEditingController();
final surnameController = TextEditingController();
final myController = TextEditingController();
final idNumberController = TextEditingController();
final passportNumController = TextEditingController();
final emailController = TextEditingController();
final numberController = TextEditingController();
final physicalAddController = TextEditingController();
final postalAddController = TextEditingController();
String gender;

class FormAFields extends StatefulWidget {
  @override
  _FormAFieldsState createState() => _FormAFieldsState();
}

class _FormAFieldsState extends State<FormAFields> {

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: true,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0)
                  ),
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  labelText: 'Name',
                ),
                cursorColor: Colors.lightBlueAccent,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter your name!';
                  }
                  if (value.length < 2) {
                    return "Name must be more than one character.";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: surnameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0)
                  ),
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  labelText: 'Surname',
                ),
                cursorColor: Colors.lightBlueAccent,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter your surname!';
                  }
                  if (value.length < 2) {
                    return "Name must be more than one character.";
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              decoration: myBoxDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _myRadioButton(
                    title: "Male",
                    value: 0,
                    onChanged: (newValue) => setState(() => _genderValue = newValue),
                  ),
                  _myRadioButton(
                    title: "Female",
                    value: 1,
                    onChanged: (newValue) => setState(() => _genderValue = newValue),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: idNumberController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0)
                  ),
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  labelText: 'Identity Number',
                ),
                cursorColor: Colors.lightBlueAccent,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter your Id Number!';
                  }
                  if (value.length != 9) {
                    return "Please enter a valid Id Number.";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: passportNumController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0)
                  ),
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  labelText: 'Passport Number',
                ),
                cursorColor: Colors.lightBlueAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0)
                  ),
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  labelText: 'Email',
                ),
                cursorColor: Colors.lightBlueAccent,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter your email address!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: numberController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0)
                  ),
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  labelText: 'Number',
                ),
                cursorColor: Colors.lightBlueAccent,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter your phone number!';
                  }
                  if (value.length != 8) {
                    return "Please enter a valid number.";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: physicalAddController,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0)
                  ),
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  labelText: 'Physical Address',
                ),
                cursorColor: Colors.lightBlueAccent,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter your Physical Address!';
                  }
                  if (value.length < 10) {
                    return "Please enter a valid address";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: postalAddController,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0)
                  ),
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  labelText: 'Postal Address',
                ),
                cursorColor: Colors.lightBlueAccent,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter your Postal Addres!';
                  }
                  if (value.length < 10){
                    return "Please enter a valid address";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: (){
                  if (_formKey.currentState.validate()){
                    if(_genderValue == 0){
                      gender = "male";
                    }else if(_genderValue == 1){
                      gender = "female";
                    }
                    if((_genderValue == 0) ^ (_genderValue == 1)){
                      Navigator.pushNamed(context, '/movement2');
                    }else{
                      Fluttertoast.showToast(
                          msg: "Please select your gender",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.blueGrey,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                  }
                },
                child: Text('Next'),
                color: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(color: Colors.lightBlueAccent),
    borderRadius: BorderRadius.circular(10.0),
  );
}

int _genderValue = -1;

Widget _myRadioButton({String title, int value, Function onChanged}) {
  return RadioListTile(
    value: value,
    groupValue: _genderValue,
    onChanged: onChanged,
    title: Text(title),
  );
}