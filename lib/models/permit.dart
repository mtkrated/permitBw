import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Permit{
  String type;
  String status;

  String authOrganization;
  String authLocation;
  String authPhone;

  String organisation;
  String contactPerson;
  String contactPersonDesignation;
  String contactPersonNum;
  String destination;
  String departureLocation;
  String startDate;
  String endDate;
  String startTime;
  String endTime;
  String appyDate;
  String comments;
  String reason;

  String verifierDate;
  String verifierDesignation;
  String verifierName;

  String applicantId;
//  String applicantName;
//  String applicantSurname;
  String applicantIdentificationNum;

  Permit({this.type, this.status, this.authOrganization, this.authLocation, this.authPhone, this.organisation,
  this.contactPerson, this.contactPersonDesignation, this.contactPersonNum, this.destination, this.departureLocation, this.startDate,
  this.endDate, this.startTime, this.endTime, this.reason, this.verifierDate, this.verifierName, this.verifierDesignation,
  this.applicantIdentificationNum, this.applicantId, this.appyDate, this.comments});

  void setApplicantId(String name){
    this.applicantId = name;
  }
  void setApplyDate(String name){
    this.appyDate = name;
  }

//  void setApplicantName(String name){
//    this.applicantName = name;
//  }
//
//  void setApplicantSurname(String name){
//    this.applicantSurname = name;
//  }
   void setApplicantOmang(String name){
    this.applicantIdentificationNum = name;
   }

  Map<String, dynamic> toJSON() {
    return {
      "type": type,
      "status": status,

      "organisation": organisation,
      "contactPerson": contactPerson,
      "contactPersondDesignation": contactPersonDesignation,
      "contactPersonNum": contactPersonNum,

      "destination": destination,
      "startDate": startDate,
      "departureTime": startTime,
      "endDate": endDate,
      "departureLocation": departureLocation,
      "reason": reason,
      "returnTime": endTime,
      "applyDate": appyDate,
      "applicantId": applicantId,
      "applicantIdentificationNum": applicantIdentificationNum,
    };
  }

  Map<String, dynamic> toJSONSpecial() {
    return {
      "type": type,
      "status": status,
      "destination": destination,
      "startDate": startDate,
      "departureTime": startTime,
      "endDate": endDate,
      "departureLocation": departureLocation,
      "reason": reason,
      "returnTime": endTime,
      "applyDate": appyDate,
      "applicantId": applicantId,
      "applicantIdentificationNum": applicantIdentificationNum,
    };
  }

  factory Permit.fromSpecial(DocumentSnapshot doc) {
    Map data = doc.data;
    return Permit(
      type: data['type'],
      status: data['status'],
      destination: data['destination'],
      startDate: data['startDate'],
      startTime: data['startTime'],
      endDate: data['endDate'],
      departureLocation: data['departureLocation'],
      appyDate: data['applyDate'],
      reason: data['reason'],
      endTime: data['endTime'],
      applicantId: data['applicantId'],
      applicantIdentificationNum: data['applicantIdentificationNum'],
    );
  }

  factory Permit.fromDocument(DocumentSnapshot doc) {
    Map data = doc.data;
    return Permit(
      type: data['type'],
      status: data['status'],
      organisation: data['organisation'],
      contactPerson: data['contactPerson'],
      contactPersonDesignation: data['contactPersonDesignation'],
      contactPersonNum: data['contactPersonPhone'],
      destination: data['destination'],
      startDate: data['startDate'],
      startTime: data['startTime'],
      endDate: data['endDate'],
      departureLocation: data['departureLocation'],
      reason: data['reason'],
      endTime: data['endTime'],
      applicantId: data['applicantId'],
//      appyDate: data['applyDate'],
//      authLocation: data['authLocation'],
//      authPhone: data['authPhone'],
//      authOrganization: data['authOrganisation'],
//      verifierDesignation: data['verifierDesignation'],
//      verifierName: data['verifierName'],
//      verifierDate: data['verifierDate'],
//      applicantIdentificationNum: data['applicantIdentificationNum'],
    );
  }

  void setPermitType(String name){
    this.type = name;
  }
  void setPermitStatus(String name){
    this.status = name;
  }
  void setNameofOrg(String name){
    this.organisation = name;
  }
  void setContactPerson(String name){
    this.contactPerson = name;
  }
  void setDesignation(String name){
    this.contactPersonDesignation = name;
  }
  void setOrgNumber(String name){
    this.contactPersonNum = name;
  }
  void setDestination(String name){
    this.destination = name;
  }
  void setDepartTime(String name){
    this.startTime = name;
  }
  void setReturnTime(String name){
    this.endTime = name;
  }
  void setLocation(String name){
    this.departureLocation = name;
  }
  void setReason(String name){
    this.reason = name;
  }
  void setEndDate(String name){
    this.endDate = name;
  }
  void setStartDate(String name){
    this.startDate = name;
  }
}