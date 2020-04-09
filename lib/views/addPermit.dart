import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

String _date = "Depart Date";
String _departureTime = "Departure Time";


class AddPermit extends StatefulWidget {
  @override
  _AddPermitState createState() => _AddPermitState();
}

class _AddPermitState extends State<AddPermit> {
  DateTime initialDate = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);

  Future showDate() async{
    DateTime newDateTime = await showRoundedDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year+100,DateTime.now().month,DateTime.now().day),
      borderRadius: 10,
    );
    _date = '${newDateTime.day} / ${newDateTime.month} / ${newDateTime.year}';
    setState(() {
    });
  }

  Future showTime()async{
    TimeOfDay newTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget child){
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child,
          );
        }
    );
    _departureTime = '${newTime.hour} : ${newTime.minute}';
    setState(() {
    });
  }

  Widget _departDate(){
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

  Widget _returnTime(){
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
              onPressed: showTime,
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.access_time,
                            size: 25.0,
                            color: Colors.lightBlueAccent,
                          ),
                          SizedBox(width: 20.0),
                          Text(
                            '$_departureTime',
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

  Widget _departTime(){
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
              onPressed: showTime,
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.time_to_leave,
                            size: 25.0,
                            color: Colors.lightBlueAccent,
                          ),
                          SizedBox(width: 20.0),
                          Text(
                            '$_departureTime',
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

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Name of Organization"),
        _entryField("Contact Person"),
        _entryField("Designation"),
        _entryField("Mobile Numbers"),
        _entryField("De"),
        _departDate(),
        _departTime(),
        _returnTime(),
      ],
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
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

  Widget _entryField(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        autofocus: false,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            backgroundColor: Colors.grey[200],),
      body: SingleChildScrollView(
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
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    Expanded(
                      flex: 2,
                      child: SizedBox(),
                    ),
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
