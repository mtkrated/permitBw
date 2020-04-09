import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permitappbw/classes/customDrawer.dart';
import 'package:permitappbw/classes/customDrawer.dart';
import 'package:permitappbw/services/auth.dart';
import 'package:permitappbw/views/addPermit.dart';
import 'package:permitappbw/views/welcome.dart';

import '../main.dart';

class HomePage extends StatefulWidget {

  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: new IconThemeData(color: Colors.black),
          title: Text(
            'Home',
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
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
              ),
              onPressed: (){
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut().then((res){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Splash()),
                  );
                });
              },
            )
          ],
        ),
        body: Center(
            child: Text('HOME')
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.lightBlue,
          foregroundColor: Colors.white,
          tooltip: 'New Permit',
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => WelcomeForm()));
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
    );
  }
}
