
import 'package:flutter/material.dart';

class BottomSheetProvider extends ChangeNotifier {

  bool bypass = false;
  get bypassValue{
    return bypass;
  }
  toggleBypass(value){
    bypass = value;
    notifyListeners();
  }



  List <String> allLocations = ["<None>", "Gate 3", "Gate 4", "Maadi", "Nasr City", "New Cairo", "Dokki", "6th October", "Madinaty",
    "Korba", "Al Azhar", "Sayeda Aisha", "Shoubra ElKheima", "Saqr Qureish", "Zamalek"];
  String selectedPickup = "<None>";
  String selectedDestination = "<None>";

  get locations{
    return allLocations;
  }
  get selectedPickupLoc{
    return selectedPickup;
  }
  get selectedDestinationLoc{
    return selectedDestination;
  }
  changePickup(value){
    selectedPickup = value.toString();
    notifyListeners();
  }
  changeDestination(value){
    selectedDestination = value.toString();
    notifyListeners();
  }




  List<String> rideTimes = ["7:30 am", "5:30 pm"];
  String selectedTime = "<None>"; //group value

  get ridesTimes{
    return rideTimes;
  }
  get selectTimes{
    return selectedTime;
  }
  toggleTime(value) {
    selectedTime = value.toString();
    notifyListeners();
  }



}