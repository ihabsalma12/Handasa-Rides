import 'package:demo/screens/login.dart';
import 'package:demo/screens/my_rides.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AuthService{
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  Rider? _riderFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return Rider(user.uid, user.email);
  }

  Stream<Rider?>? get user{
    return _firebaseAuth.authStateChanges().map(_riderFromFirebase);
  }

  Future<Rider?> signInWithEmailAndPassword({required String email, required String password}) async {
    // try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return _riderFromFirebase(credential.user);
    // }
    // on FirebaseAuthException catch (e) {
    //   //TODO this works! but debug statements do not show...
    //
    //   debugPrint("SALMA! Login error happened:${e.message}");
    // }
    // auth.notifyListeners();
  }

  Future<Rider?> createUserWithEmailAndPassword({required String email, required String password}) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return _riderFromFirebase(credential.user);
    // auth.notifyListeners();
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
    // notifyListeners();
  }

}


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
  final String uid;
  final String? email;

  Student(this.uid, this.email);

}

class Driver extends Student{
  Driver(super.uid, super.email);

}

class Rider extends Student{
  Rider(super.uid, super.email);
}



class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<Rider?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<Rider?> snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          final Rider? rider = snapshot.data;
          return rider == null ? LoginPage() : UserRidesPage();
        }
        else{
          return Scaffold(body:Center(child:CircularProgressIndicator(),),);
        }
      },
    );

  }

}



//TODO move to a separate assets file
// class MyTextField extends StatelessWidget {
//
//   final TextEditingController controller;
//   final String fieldName;
//   MyTextField({super.key, required this.controller, required this.fieldName});
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: this.controller,
//       textAlign: TextAlign.center,
//       style: TextStyle(
//         color: Color(0xFF393939),
//         fontSize: 13,
//         fontFamily: 'Poppins',
//         fontWeight: FontWeight.w400,
//       ),
//       decoration: InputDecoration(
//         labelText: this.fieldName,
//         labelStyle: TextStyle(
//           color: Color(0xFF755DC1),
//           fontSize: 15,
//           fontFamily: 'Poppins',
//           fontWeight: FontWeight.w600,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10)),
//           borderSide: BorderSide(
//             width: 1,
//             color: Color(0xFF837E93),
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10)),
//           borderSide: BorderSide(
//             width: 1,
//             color: Color(0xFF9F7BFF),
//           ),
//         ),
//       ),
//     );
//   }
// }