import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permitappbw/models/user.dart';
import 'package:permitappbw/views/home.dart';

final _formKey2 = GlobalKey<FormState>();

class Form2 extends StatefulWidget {
  Form2({Key key, @required this.uid}) : super(key: key);

  final String uid;
  @override
  _Form2State createState() => _Form2State();
}

class _Form2State extends State<Form2> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController surnameController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  TextEditingController name2Controller = new TextEditingController();
  TextEditingController surname2Controller = new TextEditingController();
  TextEditingController number2Controller = new TextEditingController();

  FirebaseUser currentUser;
  final firestoreInstance = Firestore.instance;

  @override
  void initState() {
    nameController.addListener(() {
      setState(() {});
    });
    name2Controller.addListener(() {
      setState(() {});
    });
    surnameController.addListener(() {
      setState(() {});
    });
    surname2Controller.addListener(() {
      setState(() {});
    });
    numberController.addListener(() {
      setState(() {});
    });
    number2Controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    surnameController.dispose();
    numberController.dispose();
    name2Controller.dispose();
    surname2Controller.dispose();
    number2Controller.dispose();
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
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              'Household Details',
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                color: Colors.lime[900],
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                )
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.grey[200],
      ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Builder(
                  builder: (context) => Form(
                    key: _formKey2,
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                'Details of other household members',
                                style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                textAlign: TextAlign.center,
                              ),
                              Container(
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
                                          'Member 1 Details',
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
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                                        padding: const EdgeInsets.all(8.0),
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
                                              return "Surame must be more than one character.";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: numberController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                                borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0)
                                            ),
                                            labelStyle: TextStyle(color: Colors.grey[700]),
                                            labelText: 'Contact No.',
                                          ),
                                          cursorColor: Colors.lightBlueAccent,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please Enter your contact number!';
                                            }
                                            if (value.length < 2) {
                                              return "Please enter a valid number.";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(10.0),
                                padding: const EdgeInsets.all(10.0),
                                decoration: myBoxDecoration(),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Column(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Member 2 Details',
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
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: name2Controller,
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: surname2Controller,
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
                                              return "Surame must be more than one character.";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: number2Controller,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                                borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0)
                                            ),
                                            labelStyle: TextStyle(color: Colors.grey[700]),
                                            labelText: 'Contact No.',
                                          ),
                                          cursorColor: Colors.lightBlueAccent,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please Enter your contact number!';
                                            }
                                            if (value.length < 2) {
                                              return "Please enter a valid number.";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  onPressed: () async{
                                    if(_formKey2.currentState.validate()){
                                      var firebaseUser = await FirebaseAuth.instance.currentUser();
                                      firestoreInstance.collection("users").document(firebaseUser.uid).setData(
                                        {
                                          "member1": {
                                            "name": nameController.text,
                                            "surname": surnameController.text,
                                            "number": numberController.text,
                                          },
                                          "member2": {
                                            "name": name2Controller.text,
                                            "surname": surname2Controller.text,
                                            "number": number2Controller.text,
                                          },
                                        },merge: true
                                      );
//                                      Navigator.pushReplacement(
//                                        context,
//                                        MaterialPageRoute(builder: (context) => HomePage(uid: firebaseUser.uid)),
//                                      ).then((_) => _formKey2.currentState.reset());
                                    } else{
                                      Fluttertoast.showToast(
                                          msg: "Failure",
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
                                  color: Colors.lightBlueAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(18.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ),
                  )
            ),
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