import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseService{


  static Stream<List<DocumentSnapshot<Map<String, dynamic>>>> getRiderHistory(rider_uid){

    return FirebaseFirestore.instance
        .collectionGroup('riders')
        .where('rider_uid', isEqualTo: rider_uid)
        .snapshots()
        .asyncMap((QuerySnapshot querySnapshot) async {
      List<DocumentSnapshot<Map<String, dynamic>>> rideHistory = [];

      for (QueryDocumentSnapshot riderDoc in querySnapshot.docs) {
        // Retrieve the parent route document
        DocumentReference<Map<String, dynamic>> routeRef = riderDoc.reference.parent.parent!;
        DocumentSnapshot<Map<String, dynamic>> routeSnapshot = await routeRef.get();
        var routeData = routeSnapshot;

        debugPrint('${routeData.id} => ${routeData.data()}');

        rideHistory.add(routeData);
      }

      return rideHistory;
    });

    // var snapshots = FirebaseFirestore.instance.collectionGroup('riders')
    //     .where('rider_uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    //     .snapshots();
    //
    // documents = [];
    // var riderDocs = snapshot.data!.docs; //List of QueryDocumentSnapshot
    // for(var doc in riderDocs){
    //   var ride = doc.reference.parent.parent?.id; //DocumentReference
    //   debugPrint(ride);
    //   FirebaseFirestore.instance.collection('routes').doc(ride).get().then(
    //           (DocumentSnapshot doc){
    //         documents.add(doc);
    //         debugPrint('${doc.id} => ${doc.data()}');
    //         // final data = doc.data() as Map<String, dynamic>;
    //         // debugPrint(data['from_loc'].toString());
    //       }
    //   );
    // }
  }

  static Stream<List<DocumentSnapshot>> getRiderCart(rider_uid){
    var result = FirebaseFirestore.instance
        .collectionGroup('riders')
        .where('rider_uid', isEqualTo: rider_uid)
        .where('status', isEqualTo: "approved") //approved to pay
        .snapshots()
        .asyncMap((QuerySnapshot querySnapshot) async {
      List<DocumentSnapshot> rideCart = [];

      for (QueryDocumentSnapshot riderDoc in querySnapshot.docs) {
        // Retrieve the parent route document
        DocumentReference routeRef = riderDoc.reference.parent.parent!;
        DocumentSnapshot routeSnapshot = await routeRef.get();
        var routeData = routeSnapshot;

        debugPrint('${routeData.id} => ${routeData.data()}');

        rideCart.add(routeData);
      }

      return rideCart;
    });

    return result;
  }

  // static double getTotalCreditDue(rider_uid){
  //
  //   double sum = 0.0;
  //
  //   FirebaseFirestore.instance
  //       .collectionGroup('riders')
  //       .where('rider_uid', isEqualTo: rider_uid)
  //       .where('status', isEqualTo: "approved") //approved to pay
  //       .snapshots()
  //       .forEach((QuerySnapshot querySnapshot) async {
  //     // List<DocumentSnapshot> rideCart = [];
  //
  //     for (QueryDocumentSnapshot riderDoc in querySnapshot.docs) {
  //       // Retrieve the parent route document
  //       DocumentReference routeRef = riderDoc.reference.parent.parent!;
  //       DocumentSnapshot routeSnapshot = await routeRef.get();
  //       var routeData = routeSnapshot.data() as Map; //Map
  //
  //
  //
  //       debugPrint('SALMA OUTSIDE ${routeData['price']}, to sum: $sum');
  //       // rideCart.add(routeData);
  //     }
  //     debugPrint('SALMA OUT OF THE OUTSIDE , to sum: $sum');
  //
  //     // return rideCart;
  //   });
  //   debugPrint('SALMA PLEASE , to sum: $sum');
  //
  //   return sum;
  // }


  static void payRide(route_id, rider_uid, method) async {
    final docRoute = await FirebaseFirestore.instance.collection('routes').doc(route_id)
        .collection('riders').doc(rider_uid)
        .update(
        {
          'status': "paid",
          'pay_method' : method
        }
    );
    debugPrint('DocumentSnapshot \'routes\' edited with ID: ${route_id}. \'riders\': ${rider_uid}');
  }
}