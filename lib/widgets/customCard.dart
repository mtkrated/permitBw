import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  CustomCard({@required this.permitType, this.date, this.permitStatus});

  final permitType;
  final date;
  final permitStatus;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(permitType),
                      Text(permitStatus)
                    ],
                  ),
                  SizedBox(height: 6.0),
                  Text(date),
                ],
              )),
        ));
  }
}