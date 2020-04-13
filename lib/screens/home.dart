import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permitappbw/screens/cardDetails.dart';
import 'package:permitappbw/widgets/customDrawer.dart';
import 'package:permitappbw/widgets/customDrawer.dart';
import 'package:permitappbw/widgets/customCard.dart';
import 'package:permitappbw/widgets/customReasonCard.dart';
import 'package:permitappbw/models/permit.dart';
import 'package:permitappbw/models/user.dart';
import 'package:permitappbw/services/auth.dart';
import 'package:permitappbw/screens/addPermit.dart';
import 'package:permitappbw/screens/permitType.dart';
import 'package:permitappbw/screens/welcomeScreen.dart';

import '../main.dart';

class HomePage extends StatefulWidget {

  HomePage({Key key, this.auth, this.userId})
      : super(key: key);

  final BaseAuth auth;
  final String userId;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<User> FinalUserInfo = [] ;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Confirm Exit"),
              content: Text("Are you sure you want to exit?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("YES"),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
                FlatButton(
                  child: Text("NO"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
        },

      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: new IconThemeData(color: Colors.black),
            title: Text(
              'My Applications',
              style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    color: Colors.black,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  )
              ),
            ),
            centerTitle: true,
            backgroundColor: Color(0xfff5ffff),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                ),
                onPressed: (){
                    widget.auth.signOut();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomePage(auth: new Auth())));
                },
              )
            ],
          ),
          body: Center(
            child: Container(
                height: MediaQuery.of(context).size.height,
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
                padding: const EdgeInsets.all(20.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection("permits")
                      .where("applicantId", isEqualTo: widget.userId)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return new Text('Loading...');
                      default:
                        return new ListView(
                          children: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => CardDetails(permitId: document.documentID, userId: widget.userId, auth: widget.auth,)));
                              },
                              child: new CustomReasonCard(
                                permitType: document['type'],
                                permitStatus: document['status'],
                                reason: document['reason'],
                                date: document['startDate'],
                                permitId: document.documentID,
                              ),
                            );
                          }).toList(),
                        );
                    }
                  },
                )
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Color(0xffbef0ff),
            foregroundColor: Colors.black,
            tooltip: 'New Permit',
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => PermitType(auth: widget.auth, userId: widget.userId,)));
            },
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountEmail: Text('currentUser.email'),
                  accountName: Text('currentUser.'),
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                  ),
                ),
                ListTile(
                  leading: new IconButton(
                    icon: new Icon(Icons.person, color: Colors.black),
                    onPressed: () => null,
                  ),
                  title: Text('Profile'),
                  onTap: () {
                    //Navigator
                  },
                ),
                ListTile(
                  leading: new IconButton(
                    icon: new Icon(Icons.edit, color: Colors.black),
                    onPressed: () => null,
                  ),
                  title: Text('Edit profile'),
                  onTap: () {
//                  print(widget.uid);
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) => Home(uid: widget.uid)),
//                  );
                  },
                ),
                ListTile(
                  leading: new IconButton(
                    icon: new Icon(Icons.settings, color: Colors.black),
                    onPressed: () => null,
                  ),
                  title: Text('Settings'),
                  onTap: () {
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
