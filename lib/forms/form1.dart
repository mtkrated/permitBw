import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permitappbw/forms/form2.dart';
import 'package:permitappbw/models/labeledCheckBox.dart';
import 'package:permitappbw/models/commons.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permitappbw/models/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _formKey = GlobalKey<FormState>();

int _selectedGender = 0;
String _date = "Date of Birth";

class Form1 extends StatefulWidget {
  Form1({Key key, this.uid}) : super(key: key);

  final String uid;
  @override
  _Form1State createState() => _Form1State();
}

class _Form1State extends State<Form1> {
  TextEditingController nameController =  TextEditingController();
  TextEditingController surnameController =  TextEditingController();
  TextEditingController id_numberController =  TextEditingController();
  TextEditingController nationalityController =  TextEditingController();
  TextEditingController physicalAddController =  TextEditingController();
  TextEditingController plotNoController =  TextEditingController();
  TextEditingController wardController =  TextEditingController();
  TextEditingController villageCityController =  TextEditingController();
  TextEditingController number1Controller =  TextEditingController();
  TextEditingController number2Controller =  TextEditingController();
  TextEditingController householdCController =  TextEditingController();
  TextEditingController otherController =  TextEditingController();


  @override
  void initState() {
    nameController.addListener(() {
      setState(() {});
    });
    surnameController.addListener(() {
      setState(() {});
    });
    id_numberController.addListener(() {
      setState(() {});
    });
    nationalityController.addListener(() {
      setState(() {});
    });
    physicalAddController.addListener(() {
      setState(() {});
    });
    plotNoController.addListener(() {
      setState(() {});
    });
    wardController.addListener(() {
      setState(() {});
    });
    villageCityController.addListener(() {
      setState(() {});
    });
    number1Controller.addListener(() {
      setState(() {});
    });
    number1Controller.addListener(() {
      setState(() {});
    });
    number2Controller.addListener(() {
      setState(() {});
    });
    householdCController.addListener(() {
      setState(() {});
    });
    otherController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
    nameController.dispose();
    surnameController.dispose();
    id_numberController.dispose();
    nationalityController.dispose();
    physicalAddController.dispose();
    plotNoController.dispose();
    wardController.dispose();
    villageCityController.dispose();
    number1Controller.dispose();
    number1Controller.dispose();
    number2Controller.dispose();
    householdCController.dispose();
    otherController.dispose();
  }

  FirebaseUser currentUser;
  final firestoreInstance = Firestore.instance;
  List<DropdownMenuItem<int>> genderList = [];

  bool _is1Selected = false;
  bool _is2Selected = false;
  bool _is3Selected = false;
  bool _is4Selected = false;

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

  @override
  Widget build(BuildContext context) {
    loadGenderList();

    DateTime initialDate = DateTime(DateTime.now().year - 16,DateTime.now().month,DateTime.now().day);
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

    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
//          leading: IconButton(
//            icon: Icon(Icons.arrow_back, color: Colors.black),
//            onPressed: () => Navigator.of(context).pop(),
//          ),
          title: Text(
            'Personal Details',
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
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Builder(
            builder: (context) => Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: id_numberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0)
                          ),
                          labelStyle: TextStyle(color: Colors.grey[700]),
                          labelText: 'Identity No. (O)/(P)',
                        ),
                        cursorColor: Colors.lightBlueAccent,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter your Identity Number!';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: nationalityController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0)
                          ),
                          labelStyle: TextStyle(color: Colors.grey[700]),
                          labelText: 'Nationality',
                        ),
                        cursorColor: Colors.lightBlueAccent,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter your Nationality!';
                          }
                          if (value.length < 2) {
                            return "Nationality must be more than one character.";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: physicalAddController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
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
                          if (value.length < 2) {
                            return "Physical Address must be more than one character.";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: plotNoController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0)
                          ),
                          labelStyle: TextStyle(color: Colors.grey[700]),
                          labelText: 'Plot/House Number',
                        ),
                        cursorColor: Colors.lightBlueAccent,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter your Plot/House Number!';
                          }
                          if (value.length < 2) {
                            return "Plot/House Number must be more than one character.";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: wardController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0)
                          ),
                          labelStyle: TextStyle(color: Colors.grey[700]),
                          labelText: 'Ward',
                        ),
                        cursorColor: Colors.lightBlueAccent,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter the name of your ward!';
                          }
                          if (value.length < 2) {
                            return "Ward name must be more than one character.";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: villageCityController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0)
                          ),
                          labelStyle: TextStyle(color: Colors.grey[700]),
                          labelText: 'Village/City',
                        ),
                        cursorColor: Colors.lightBlueAccent,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter your Village/City name!';
                          }
                          if (value.length < 2) {
                            return "Village/City must be more than one character.";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: number1Controller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0)
                          ),
                          labelStyle: TextStyle(color: Colors.grey[700]),
                          labelText: 'Contact No.1',
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
                          labelText: 'Contact No.2',
                        ),
                        cursorColor: Colors.lightBlueAccent,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: myBoxDecoration(),
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 10.0,),
                                LabeledCheckbox(
                                  label: 'Multiple houses',
                                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                                  value: _is1Selected,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      _is1Selected = newValue;
                                    });
                                  },
                                ),
                                LabeledCheckbox(
                                  label: 'Single houses',
                                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                                  value: _is2Selected,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      _is2Selected = newValue;
                                    });
                                  },
                                ),
                                LabeledCheckbox(
                                  label: 'Private toilet',
                                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                                  value: _is3Selected,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      _is3Selected = newValue;
                                    });
                                  },
                                ),
                                LabeledCheckbox(
                                  label: 'Shared toilet',
                                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                                  value: _is4Selected,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      _is4Selected = newValue;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Household Characteristics:',
                              style: GoogleFonts.aBeeZee(
                                  textStyle: TextStyle(
                                    color: Colors.blueAccent,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  )
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: otherController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0)
                          ),
                          labelStyle: TextStyle(color: Colors.grey[700]),
                          labelText: 'Other (Please Describe)',
                        ),
                        cursorColor: Colors.lightBlueAccent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: RaisedButton(
                        onPressed: () async{
                          if(_formKey.currentState.validate()){
                            if(_is1Selected || _is2Selected || _is3Selected || _is4Selected){
                              var firebaseUser = await FirebaseAuth.instance.currentUser();
                              firestoreInstance.collection("users").document(firebaseUser.uid).setData(
                                  {
                                    "name": nameController.text,
                                    "surname": surnameController.text,
                                    "gender": getGender(_selectedGender),
                                    "id_number": id_numberController,
                                    "nationality": nationalityController.text,
                                    "doB": _date,
                                    "physicalAdd": physicalAddController.text,
                                    "plotNo": plotNoController.text,
                                    "ward": wardController.text,
                                    "villageCity": villageCityController.text,
                                    "number1": number1Controller.text,
                                    "number2": number2Controller.text,
                                    "householdC": '',
                                    "other": otherController.text,
                                  }
                              );
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Form2()));
                            } else{
                              Fluttertoast.showToast(
                                  msg: "Please choose the type of household",
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
            ),
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


String validateEmail(String value) {
  if (value.isEmpty) {
    return 'Please enter your mail';
  }

  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Please enter a Valid Email';
  else
    return null;
}

String getGender(int value){
  if(value == 0){
    return 'Male';
  }else if(value == 1){
    return 'Female';
  }else{
    return 'Other';
  }
}