import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permitappbw/models/permit.dart';
import 'package:permitappbw/models/user.dart';
import 'package:permitappbw/services/auth.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';
import 'package:crypto/crypto.dart';

import 'home.dart';

class CardDetails extends StatefulWidget {
  final permitId;
  final BaseAuth auth;
  final String userId;

  CardDetails({this.permitId, this.userId, this.auth});
  @override
  _CardDetailsState createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  var permit = Permit();
  var user = User();

  Widget _text(String title){
    return Text(
        title
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPermitDataFirestore();
  }

  Widget getPermitStatus(){
    if(permit.status == "Pending"){
      return Card(
        elevation: 2.0,
        margin: EdgeInsets.all(8.0),
        color: Colors.orange,
        child: Center(
          child: Text(
            permit.status,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }else if(permit.status == "Approved"){
      return Card(
        elevation: 2.0,
        margin: EdgeInsets.all(8.0),
        color: Colors.green,
        child: Center(
          child: Text(
            permit.status,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }else if(permit.status == "Denied"){
      return Card(
        elevation: 2.0,
        margin: EdgeInsets.all(8.0),
        color: Colors.red,
        child: Center(
          child: Text(
            permit.status,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }else if(permit.status == "Expired"){
      return Card(
        elevation: 2.0,
        margin: EdgeInsets.all(8.0),
        color: Colors.red,
        child: Center(
          child: Text(
            permit.status,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
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

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'M',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: 'y Per',
              style: TextStyle(color: Colors.blue, fontSize: 30),
            ),
            TextSpan(
              text: 'mit',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
//        appBar: AppBar(
//          leading: new IconButton(
//            icon: new Icon(Icons.arrow_back),
//            onPressed: () {
//              Navigator.pop(context);
//            },
//          ),
//          iconTheme: new IconThemeData(color: Colors.black),
//          title: Text(
//            'Permit Application',
//            style: GoogleFonts.aBeeZee(
//                textStyle: TextStyle(
//                  color: Colors.lime[900],
//                  letterSpacing: 2.0,
//                  fontWeight: FontWeight.bold,
//                )
//            ),
//          ),
//          centerTitle: true,
//          backgroundColor: Colors.grey[200],
//        ),
        body: Stack(
          children: <Widget>[
            Container(
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
                          colors: [Color(0xffbef0ff), Color(0xfff5ffff)])),
                  height: MediaQuery.of(context).size.height,
                  width:MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 30.0,),
                        _title(),
                        SizedBox(height: 150.0),
                        QrImage(
                          data: 'BW-COVID-19-APP:' + widget.permitId + ':' + generateMd5(widget.permitId).substring(0,14),
                          version: QrVersions.auto,
                          size: 175,
                          gapless: false,
                          foregroundColor: Colors.lightBlueAccent,
                        ),
                        SizedBox(height: 6.0,),
                        Text(
                            'Your QR Code',
                          style: GoogleFonts.abel(
                              textStyle: TextStyle(
                                color: Colors.black,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0
                              )
                          ),
                        ),
                        SizedBox(height: 6.0,),
                        Text(
                          'Get you Qr code scanned at police roadblocks',
                          style: GoogleFonts.abel(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 1.0,
                                  fontSize: 14.0
                              )
                          ),
                        )
                      ],
                    ),
                ),
                Positioned(top: 20, left: 0, child: _backButton()),
              ],
        ),
      ),
    );
  }

  void getPermitDataFirestore() async{
    var document = await Firestore.instance.collection("permits").document(widget.permitId).get();
     permit = Permit.fromDocument(document);
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}
