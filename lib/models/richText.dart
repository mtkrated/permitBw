import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichTxt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: new TextSpan(text: 'I agree to the ? ',
            style: TextStyle(color: Colors.black),
            children: [
              new TextSpan(
                  text: 'terms',
                  style: TextStyle(color: Colors.blue),
                  recognizer: new TapGestureRecognizer() ..onTap = (){}
              ),
              new TextSpan(
                  text: ' and ',
                  style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                  text: 'privacy policy',
                  style: TextStyle(color: Colors.blue),
                  recognizer: new TapGestureRecognizer() ..onTap = (){}
              ),
            ]
        )
    );
  }
}
