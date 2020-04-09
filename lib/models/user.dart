import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

User userFromJson(String str) {
  final jsonData = json.decode(str);
  //return User.fromJson(jsonData);
}

String userToJson(User data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class User{
  String id ;
  String name;
  String surname;
  String gender;
  String idNumber;
  String nationality;
  String doB;
  String physicalAdd;
  String plotNo;
  String ward;
  String villageCity;
  String email;
  String number1;
  String number2;
  String other;
  String password;
  String member1Name;
  String member2Name;
  String member1Surname;
  String member2Surname;
  String member1Number;
  String member2Number;

  void setName(String name){
    this.name = name;
  }
  void setSurname(String name){
    this.surname = name;
  }
  void setGender(String name){
    this.gender = name;
  }
  void setIdNo(String name){
    this.idNumber = name;
  }
  void setNationality(String name){
    this.nationality = name;
  }
  void setdob(String name){
    this.doB = name;
  }
  void setPhyAdd(String name){
    this.physicalAdd = name;
  }
  void setPlot(String name){
    this.plotNo = name;
  }
  void setWard(String name){
    this.ward = name;
  }
  void setEmail(String name){
    this.email = name;
  }
  void setNo1(String name){
    this.number1 = name;
  }
  void setNo2(String name){
    this.number2 = name;
  }
  void setVil(String name){
    this.villageCity = name;
  }
  void setOther(String name){
    this.other = name;
  }
  void setPassword(String name){
    this.password = name;
  }


  User({this.id, this.name, this.surname, this.gender, this.idNumber, this.nationality, this.doB, this.physicalAdd,this.plotNo
  , this.ward, this.villageCity, this.email, this.number1, this.number2, this.other, this.member1Name, this.member2Name, this.member1Surname,
  this.member2Surname, this.member1Number, this.member2Number});

  User.fromData(Map<String, dynamic>data) :
        id = data['id'],
        name = data['name'],
        surname = data['surname'],
        gender = data['gender'],
        idNumber = data['id_number'],
        nationality = data['nationality'],
        doB = data['date_of_birth'],
        physicalAdd = data['physical_address'],
        plotNo = data['plot_no'],
        ward = data['ward'],
        villageCity = data['village_city'],
        email = data['email'],
        number1 = data['number1'],
        number2 = data['number2'],
        other = data['other'];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "surname": surname,
      "gender": gender,
      "id_number": idNumber,
      "nationality": nationality,
      "date_of_birth": doB,
      "physical_address": physicalAdd,
      "plot_no": plotNo,
      "ward": ward,
      "village_city": villageCity,
      "email": email,
      "number1": number1,
      "number2": number2,
      "other": other,
    };
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    //return User.fromJson(doc.data);
  }
}