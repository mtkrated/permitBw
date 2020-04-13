import 'package:flutter/material.dart';
import 'package:permitappbw/services/auth.dart';
import 'package:permitappbw/screens/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permitappbw/screens/welcomeScreen.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'), // English
        ],
        debugShowCheckedModeBanner: false,
        title: 'Meet Up',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
            home: Splash(auth: new Auth()),
      ),
    );
  }
}

class Splash extends StatefulWidget {
  final BaseAuth auth;
  Splash({this.auth});
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    super.initState();
    widget.auth.getCurrentUser().then((res) {
      print(res);
      if (res != null) {
        widget.auth.getUserData(res.uid).then((DocumentSnapshot result) =>
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage(auth: widget.auth,userId: res.uid )),
        ).catchError((err) => print(err)));
      }
      else
      {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomePage(auth: widget.auth,)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 5,
        title: new Text('Welcome!',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),),
        image: Image.asset('images/coat_of_arms_of.png',fit:BoxFit.scaleDown),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: ()=>print("flutter"),
        loaderColor: Colors.red
    );
  }
}
