import 'package:flutter/cupertino.dart';
import 'package:permitappbw/classes/formAClass.dart';
import 'package:permitappbw/models/user.dart';

class Values{
  String name = nameController.text;
  String surname = surnameController.text;
  String idNumber = idNumberController.text;
  String passportNum = passportNumController.text;
  String email = emailController.text;
  String number = numberController.text;
  String physicalAdd = physicalAddController.text;
  String postalAdd = postalAddController.text;
  String gender = "";
  String date = "";
  String depart_time = "";
  String return_time = "";
//  String reason = reasonController.text;

  final User formInfo;

  Values({this.formInfo});
}