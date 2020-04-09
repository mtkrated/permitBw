import 'package:flutter/material.dart';
import 'package:permitappbw/models/user.dart';

class Commons{
  int _selectedGender = 0;

   var user = new User();

  List<DropdownMenuItem<int>> genderList = [];

  void loadGenderList() {
    genderList = [];
    genderList.add(new DropdownMenuItem(
      child: new Text('Male'),
      value: 0,
    ));
    genderList.add(new DropdownMenuItem(
      child: new Text('Female'),
      value: 1,
    ));
    genderList.add(new DropdownMenuItem(
        child: new Text('Other'),
    value: 2,
    ));
  }

}
