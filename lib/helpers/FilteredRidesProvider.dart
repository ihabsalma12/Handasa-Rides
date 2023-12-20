
//TODO delete this

import 'package:demo/helpers/Ride.dart';
import 'package:flutter/material.dart';

class FilteredRidesProvider extends ChangeNotifier{
  List<Ride> routeList = [];
  get routesList{
    return routeList;
  }
  updateRouteList(newList){
    routeList = newList;
    notifyListeners();
  }
}