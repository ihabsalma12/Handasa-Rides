import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RiderSubcollectionWidget extends StatelessWidget {

  final String route_id;
  final String? rider_uid;

  RiderSubcollectionWidget({super.key, required this.route_id, required this.rider_uid});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('routes').doc(route_id).collection('riders').doc(rider_uid).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          DocumentSnapshot<Map<String, dynamic>>? routeRiderDoc = snapshot.data;

          Map<String, dynamic>? data = routeRiderDoc?.data() as Map<String, dynamic>?;
          return (data != null && data.containsKey('pay_method'))
              ? Wrap(children:[
                  Text("${routeRiderDoc?['status']} by ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple.shade800)),
                  Text("${routeRiderDoc?['pay_method']}", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline, color: Colors.purple.shade800))
                ])
              : Text("${routeRiderDoc?['status']}",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple.shade800),)
              ;
        }
        else if (snapshot.hasError) {
          return Text('Internal Error: ${snapshot.error}');
        }
        else{
          return const CircularProgressIndicator();
        }

      },

    );
  }
}