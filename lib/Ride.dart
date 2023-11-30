import 'package:flutter/material.dart';

List <Ride> rides = [
  Ride("Gate 2", "Maadi", "5:30 pm"),
  Ride("Nasr City", "Gate 6", "7:30 am"),
  Ride("Gate 6", "New Cairo", "5:30 pm"),
  Ride("Gate 3", "Maadi", "5:30 pm"),
]; //fetch from db



class Ride {
  String? pickup;
  String? destination;
  int? distance;
  String? time;
  String? price;
  Driver? driver;
  List <Rider> riders = [];

  Ride(String this.pickup, String this.destination, String this.time);

}

class Student {
  String? name;
  String? id;
  String? pass;
  String? type;
}

class Driver extends Student{
  //profile info
}

class Rider extends Student{
  //profile info
}




//TODO move to a separate assets file
class MyTextField extends StatelessWidget {

  final TextEditingController controller;
  final String fieldName;
  MyTextField({required this.controller, required this.fieldName});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF393939),
        fontSize: 13,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        labelText: this.fieldName,
        labelStyle: TextStyle(
          color: Color(0xFF755DC1),
          fontSize: 15,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: Color(0xFF837E93),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: Color(0xFF9F7BFF),
          ),
        ),
      ),
    );
  }
}

