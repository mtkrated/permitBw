import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:permitappbw/models/permit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permitappbw/models/user.dart';
import 'package:permitappbw/services/auth.dart';
import 'package:permitappbw/screens/permitType.dart';
import 'package:permitappbw/screens/welcomeScreen.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'home.dart';

class AddPermit extends StatefulWidget {
  int permitType;
  final BaseAuth auth;
  final String userId;
  AddPermit({Key key, @required this.permitType, this.auth, this.userId}) : super(key: key);

  @override
  _AddPermitState createState() => _AddPermitState();
}

class _AddPermitState extends State<AddPermit> {
  final dateFormat = DateFormat("dd/MM/yyyy");
  final timeFormat = DateFormat("HH:mm");
  DateTime now = new DateTime.now();
  final permit = Permit();
  var user = User();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameOfOrgController =  TextEditingController();
  TextEditingController contactPersonController =  TextEditingController();
  TextEditingController designationController =  TextEditingController();
  TextEditingController mobileNumbersController =  TextEditingController();
  TextEditingController destinationController =  TextEditingController();
  TextEditingController locationController =  TextEditingController();
  TextEditingController reasonController =  TextEditingController();
  TextEditingController startDateController =  TextEditingController();
  TextEditingController endDateController =  TextEditingController();
  TextEditingController startTimeController =  TextEditingController();
  TextEditingController endTimeController =  TextEditingController();


  @override
  Widget BasicDateField(TextEditingController name, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
            DateTimeField(
              format: dateFormat,
              controller: name,
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

  @override
  Widget BasicTimeField (TextEditingController name, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
            DateTimeField(
              format: timeFormat,
              controller: name,
              autovalidate: true,
              onShowPicker: (context, currentValue) async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                );
                return DateTimeField.convert(time);
              },
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    if (widget.permitType == 0){
      return Column(
        children: <Widget>[
          Text(
            'Essential Services',
            textAlign: TextAlign.center,
            style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  fontSize: 20.0,
                )
            ),
          ),
          _entryField("Organization Name", nameOfOrgController),
          _entryField("Contact Person", contactPersonController),
          _entryField("Designation", designationController),
          _entryField("Mobile Number", mobileNumbersController),

          _entryField2("Reason", reasonController),
          _entryField("Destination", destinationController),
          _entryField("Location", locationController),
          BasicDateField(startDateController, 'Start Date'),
          BasicDateField(endDateController, 'End Date'),
          BasicTimeField(startTimeController, 'Departure Time'),
          BasicTimeField(endTimeController, 'Return Time')

        ],
      );
    }else if(widget.permitType == 1){
      return Column(
        children: <Widget>[
          Text(
            'Transport of Essential Goods',
            textAlign: TextAlign.center,
            style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  fontSize: 20.0,
                )
            ),
          ),
          _entryField("Organization Name", nameOfOrgController),
          _entryField("Contact Person", contactPersonController),
          _entryField("Designation", designationController),
          _entryField("Mobile Number", mobileNumbersController),

          _entryField2("Reason", reasonController),
          _entryField("Destination", destinationController),
          _entryField("Location", locationController),
          BasicDateField(startDateController, 'Start Date'),
          BasicDateField(endDateController, 'End Date'),
          BasicTimeField(startTimeController, 'Departure Time'),
          BasicTimeField(endTimeController, 'Return Time')
        ],
      );
    }else {
      return Column(
        children: <Widget>[
          Text(
              'Special Permit',
            textAlign: TextAlign.center,
            style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  fontSize: 20.0,
                )
            ),
          ),
          _entryField2("Reason", reasonController),
          _entryField("Destination", destinationController),
          _entryField("Current Location", locationController),
          BasicDateField(startDateController, 'Start Date'),
          BasicDateField(endDateController, 'End Date'),
          BasicTimeField(startTimeController, 'Departure Time'),
          BasicTimeField(endTimeController, 'Return Time')
        ],
      );
    }

  }

  Widget _submitButton() {
    return InkWell(
      onTap: () async{
        if(widget.permitType == 0){
          if (_formKey.currentState.validate() && (startDateController != '') &&
              (endDateController != '') && (startTimeController != '') && (endTimeController != '')){
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Center(child: CircularProgressIndicator(),);
                });
            await getUserData();
            submitPermit();
            Navigator.pop(context);
            _formKey.currentState.reset();
          }else{
            Fluttertoast.showToast(
                msg: "Please fill every detail",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.blueGrey,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        }else if(widget.permitType == 1){
          if (_formKey.currentState.validate() && (startDateController != '') &&
              (endDateController != '') && (startTimeController != '') && (endTimeController != '')){
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Center(child: CircularProgressIndicator(),);
                });
            await getUserData();
            submitPermit();
            Navigator.pop(context);
            _formKey.currentState.reset();
          }else{
            Fluttertoast.showToast(
                msg: "Please fill every detail",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.blueGrey,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        }else{
          if (_formKey.currentState.validate() && (startDateController != '') &&
              (endDateController != '') && (startTimeController != '') && (endTimeController != '')){
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Center(child: CircularProgressIndicator(),);
                });
            await getUserData();
            submitSpecialPermit();
            Navigator.pop(context);
            _formKey.currentState.reset();
          }else{
            Fluttertoast.showToast(
                msg: "Please fill every detail",
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
          'Apply',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }

  Widget _entryField(String title, TextEditingController name,) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
        child: TextFormField(
          autofocus: false,
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

  Widget _entryField2(String title, TextEditingController name,) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
      child: TextFormField(
        autofocus: false,
        controller: name,
        keyboardType: TextInputType.multiline,
        maxLines: 3,
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
                      color: Colors.black,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                    )
                  ),
              ),
              centerTitle: true,
              backgroundColor: Color(0xfff5ffff),),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
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
                      colors: [Color(0xfff5ffff), Color(0xfff5ffff)])),
              //height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: <Widget>[
                          _emailPasswordWidget(),
                          _submitButton(),
                        ],
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

  void setSpecialData(Permit permit){
    var now = new DateTime.now();
    var formatter = new DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(now);

    permit.setPermitType(getPermitType(widget.permitType));
    permit.setPermitStatus('Pending');
    permit.setReason(reasonController.text);
    permit.setDestination(destinationController.text);
    permit.setLocation(locationController.text);
    permit.setStartDate(startDateController.text);
    permit.setEndDate(endDateController.text);
    permit.setDepartTime(startTimeController.text);
    permit.setReturnTime(endTimeController.text);
    permit.setApplicantId(widget.userId);
    permit.setApplicantOmang(user.getIdNo());
    permit.setApplyDate(formattedDate);
  }

  void setData(Permit permit){
    var now = new DateTime.now();
    var formatter = new DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(now);

    permit.setPermitType(getPermitType(widget.permitType));
    permit.setPermitStatus('Pending');
    permit.setNameofOrg(nameOfOrgController.text);
    permit.setContactPerson(contactPersonController.text);
    permit.setDesignation(designationController.text);
    permit.setOrgNumber(mobileNumbersController.text);
    permit.setDestination(destinationController.text);
    permit.setDepartTime(startTimeController.text);
    permit.setReturnTime(endTimeController.text);
    permit.setLocation(locationController.text);
    permit.setReason(reasonController.text);
    permit.setStartDate(startDateController.text);
    permit.setEndDate(endDateController.text);
    permit.setApplicantId(widget.userId);
    permit.setApplyDate(formattedDate);
    permit.setApplicantOmang(user.getIdNo());
  }

  String getPermitType(int value){
    if(value == 0){
      return 'Essential Service';
    }else if(value == 1){
      return 'Transport of essential goods';
    }else if(value == 2){
      return 'Special Permit';
    }
  }

  Future<bool> submitPermit() async {
    try {
      setData(permit);
      await widget.auth.addPermit(permit);
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage(userId: widget.userId, auth: widget.auth)));
    } catch (e) {
      print(e.message);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(e.message),
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
    await new Future.delayed(const Duration(seconds: 3));
    return true;
  }

  Future<bool> submitSpecialPermit() async {
    try {
      setSpecialData(permit);
      await widget.auth.addPermit(permit);
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage(userId: widget.userId, auth: widget.auth)));
    } catch (e) {
      print(e.message);
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(e.message),
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

  void getUserData() async{
    var document = await Firestore.instance.collection("applicants").document(widget.userId).get();
    user = User.fromDocument(document);
  }
}