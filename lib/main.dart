import 'package:flutter/material.dart';
import 'package:permitappbw/services/authentication.dart';
import 'package:permitappbw/services/root_page.dart';
import 'package:permitappbw/views/register.dart';
import 'package:permitappbw/views/home.dart';
import 'package:permitappbw/views/welcome.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permitappbw/views/welcomeScreen.dart';
import 'package:splashscreen/splashscreen.dart';

import 'forms/form1.dart';
import 'forms/form2.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          home: Splash(),
    );
//        home: new RootPage(auth: new Auth()));
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    super.initState();
    FirebaseAuth.instance.currentUser().then((res) {
      print(res);
      if (res != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage(userId: res.uid)),
        );
      }
      else
      {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomePage()),
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
