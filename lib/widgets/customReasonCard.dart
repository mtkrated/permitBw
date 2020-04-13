import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permitappbw/models/permit.dart';
import 'package:permitappbw/screens/cardDetails.dart';
import 'package:permitappbw/services/auth.dart';

class CustomReasonCard extends StatelessWidget {
  CustomReasonCard({@required this.permitType, this.date, this.permitStatus, this.reason, this.permitId, this.auth, this.userId});

  final BaseAuth auth;
  final String userId;
  final permitType;
  final date;
  final reason;
  final permitStatus;
  String permitId;


  Widget getColor(){
    if(permitStatus == "Pending"){
      return Text(
        permitStatus,
        style: TextStyle(
          color: Colors.orange,
          fontWeight: FontWeight.bold
        ),
        textAlign: TextAlign.center,
      );
    }else if(permitStatus == "Denied"){
      return Text(
        permitStatus,
        style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold
        ),
        textAlign: TextAlign.center,
      );
    }else if(permitStatus == "Approved"){
      return Text(
        permitStatus,
        style: TextStyle(
            color: Colors.green[600],
            fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      );
    }else if(permitStatus == "Expired"){
      return Text(
        permitStatus,
        style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold
        ),
        textAlign: TextAlign.center,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile() => ListTile(
      //contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
      leading: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(right: 10.0,),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Center(
            widthFactor: 1,
            child: getColor(),
          ),
      ),

      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0,),
          Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  permitType,
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                )
          ),
          SizedBox(height: 4.0,),
          Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text("Start Date: " + date,
                  style: TextStyle(color: Colors.white))
          ),
          SizedBox(height: 4.0,),
          Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                "Reason: " + reason,
                style: TextStyle(color: Colors.white),
              )
          ),
        ],
      ),
//      trailing:
//      Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 20.0),
//      onTap: () {
//        Navigator.push(
//            context, MaterialPageRoute(builder: (context) => CardDetails(permitId: permitId, userId: userId, auth: auth,)));
//      },
    );

    Card makeCard() => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: makeListTile(),
      ),
    );

    return makeCard();

  }
}