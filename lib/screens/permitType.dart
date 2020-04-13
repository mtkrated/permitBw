import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permitappbw/services/auth.dart';
import 'addPermit.dart';

class PermitType extends StatefulWidget {
  final BaseAuth auth;
  final String userId;
  PermitType({this.auth, this.userId});

  @override
  _PermitTypeState createState() => _PermitTypeState();
}

class _PermitTypeState extends State<PermitType> {
  int _groupValue = -1;

  @override
  void initState() {
    int _groupValue = -1;
    super.initState();
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
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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
          backgroundColor: Color(0xfff5ffff),
        ),
        body: SingleChildScrollView(
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
            child: Column(
              children: <Widget>[
                new Image.asset('images/coat_of_arms_of.png', width: 150, height: 150,),
                SizedBox(height: 10.0,),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: myBoxDecoration(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 8.0,),
                      Text(
                        'Please select the type of permit',
                        style: GoogleFonts.abel(
                            textStyle: TextStyle(
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            )
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: myBoxDecoration(),
                        child: _myRadioButton(
                          title: "Essential Services",
                          value: 0,
                          onChanged: (newValue) => setState(() => _groupValue = newValue),
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: myBoxDecoration(),
                        child: _myRadioButton(
                          title: "Transport of Essential goods ",
                          value: 1,
                          onChanged: (newValue) => setState(() => _groupValue = newValue),
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: myBoxDecoration(),
                        child: _myRadioButton(
                          title: "Special Permit",
                          value: 2,
                          onChanged: (newValue) => setState(() => _groupValue = newValue),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: (){
                              if(_groupValue == 0 || _groupValue == 1 || _groupValue == 2){
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => AddPermit(auth: widget.auth, permitType: _groupValue, userId: widget.userId,)));
                              }else{
                                Fluttertoast.showToast(
                                    msg: "Please choose an option",
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
                            color: Colors.blue[200],
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(),
    );
  }

  Widget _myRadioButton({String title, int value, Function onChanged}) {
    return RadioListTile(
      value: value,
      groupValue: _groupValue,
      onChanged: onChanged,
      title: Text(title),
    );
  }

  String getPermitType(int value){
    if(value == 0){
      return 'Transport of essential goods';
    }else if(value == 1){
      return 'Essential services';
    }else{
      return 'Special Permit';
    }
  }

}