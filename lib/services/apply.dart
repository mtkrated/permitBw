import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:permitappbw/classes/formAClass.dart';
import 'package:permitappbw/models/user.dart';
import 'package:permitappbw/classes/values.dart';

var formInfo = new User();

class Apply extends StatefulWidget {
  @override
  _ApplyState createState() => _ApplyState();
}

class _ApplyState extends State<Apply> {

  bool visible = false ;

  Future userApply() async{

    // Showing CircularProgressIndicator.
    setState(() {
      visible = true ;
    });

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
//    String reason = reasonController.text;

    // SERVER API URL
    var url = 'http://afrovenus.com/webservice/permit_app/apply.php';

    // Store all data with Param Name.
    var data = {
      "name": name,
      "surname": surname,
      "gender": gender,
      "id_number": idNumber,
      "passport_number": passportNum,
      "email": email,
      "number": number,
      "physical_address": physicalAdd,
      "postal_address": postalAdd,
      "date": date,
      "departure_time": depart_time,
      "return_time": return_time,
//      "reason": reason,
    };

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if(response.statusCode == 200){
      setState(() {
        visible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
