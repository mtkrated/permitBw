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
  String fullName;
  String location;
  String gender;
  String identificationNum;
  String nationality;
  String dateOfBirth;
  String physicalAddress;
  String email;
  String phone;
  String password;

  void setName(String name){
    this.fullName = name;
  }
  void setSurname(String name){
    this.location = name;
  }
  void setGender(String name){
    this.gender = name;
  }
  void setIdNo(String name){
    this.identificationNum = name;
  }
  void setNationality(String name){
    this.nationality = name;
  }
  void setdob(String name){
    this.dateOfBirth = name;
  }
  void setPhyAdd(String name){
    this.physicalAddress = name;
  }
  void setEmail(String name){
    this.email = name;
  }
  void setNo1(String name){
    this.phone = name;
  }
  void setPassword(String name){
    this.password = name;
  }


  String getName(){
    return fullName;
  }
  String getSurname(){
    return location;
  }
  String getGender(){
    return gender;
  }
  String getIdNo(){
    return identificationNum;
  }
  String getNationality(){
    return nationality;
  }
  String getdob(){
    return dateOfBirth;
  }
  String getPhyAdd(){
    return physicalAddress;
  }
  String getEmail(){
    return email;
  }
  String getNo1(){
    return phone;
  }

  User({this.id, this.fullName, this.location, this.gender, this.identificationNum, this.nationality, this.dateOfBirth, this.physicalAddress
  , this.email, this.phone});

  User.fromData(Map<String, dynamic>data) :
        fullName = data['fullname'],
        location = data['location'],
        gender = data['gender'],
        identificationNum = data['identificationNum'],
        nationality = data['nationality'],
        dateOfBirth = data['dateOfBirth'],
        physicalAddress = data['physicalAddress'],
//        email = data['email'],
        phone = data['phone'];

  Map<String, dynamic> toJson() {
    return {
      "fullname": fullName,
      "location": location,
      "gender": gender,
      "identificationNum": identificationNum,
      "nationality": nationality,
      "dateOfBirth": dateOfBirth,
      "physicalAddress": physicalAddress,
//      "email": email,
      "phone": phone,
    };
  }


  factory User.fromDocument(DocumentSnapshot doc) {
    Map data = doc.data;
    return User(
      fullName: data['fullname'],
      gender: data['gender'],
      identificationNum: data['identificationNum'],
      nationality: data['nationality'],
      dateOfBirth: data['dateOfBirth'],
      phone: data['phone'],
      physicalAddress: data['physicalAddress'],
    );
  }
}