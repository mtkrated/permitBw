import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permitappbw/forms/form1.dart';
import 'package:permitappbw/models/labeledRadio.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'addPermit.dart';

class WelcomeForm extends StatefulWidget {
  @override
  _WelcomeFormState createState() => _WelcomeFormState();
}

class _WelcomeFormState extends State<WelcomeForm> {
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
        appBar: AppBar(
          iconTheme: new IconThemeData(color: Colors.black),
          title: Text(
            'Permit Application',
            style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                color: Colors.lime[900],
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
                )
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[200],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              new Image.asset('images/coat_of_arms_of.png', width: 150, height: 150,),
              SizedBox(height: 10.0,),
              Container(
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(10.0),
                decoration: myBoxDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 8.0,),
                    Text(
                      'Please select the type of permit',
                      style: GoogleFonts.abel(
                          textStyle: TextStyle(
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          )
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.all(5.0),
                      decoration: myBoxDecoration(),
                      child: _myRadioButton(
                        title: "Transport of Essential goods",
                        value: 0,
                        onChanged: (newValue) => setState(() => _groupValue = newValue),
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.all(5.0),
                      decoration: myBoxDecoration(),
                      child: _myRadioButton(
                        title: "Essential Services",
                        value: 1,
                        onChanged: (newValue) => setState(() => _groupValue = newValue),
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.all(5.0),
                      decoration: myBoxDecoration(),
                      child: _myRadioButton(
                        title: "Special Permit",
                        value: 2,
                        onChanged: (newValue) => setState(() => _groupValue = newValue),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: (){
                            if(_groupValue == 0){
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => AddPermit()));
                            }else if(_groupValue == 1){
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => AddPermit()));
                            }else if(_groupValue == 1){
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => AddPermit()));
                            }else{
                              Fluttertoast.showToast(
                                  msg: "Please choose an option",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.blueGrey,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                          },
                          child: Text('Next'),
                          color: Colors.blue[200],
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

int _groupValue = -1;

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(),
  );
}

Widget _myRadioButton({String title, int value, Function onChanged}) {
  return RadioListTile(
    value: value,
    groupValue: _groupValue,
    onChanged: onChanged,
    title: Text(title),
  );
}
