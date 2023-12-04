import 'package:demo/DatabaseV3.dart';
import 'package:demo/view/login.dart';
import 'package:demo/view/my_rides.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:demo/Classes.dart';


//controls login and signup in firebase
class AuthService{
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  Rider? _riderFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return Rider(user.uid, user.displayName, user.email, user.hashCode.toString());
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

  Future<Rider?> createUserWithEmailAndPassword({required String fullName, required String email, required String password}) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    await credential.user?.updateDisplayName(fullName);
    return _riderFromFirebase(credential.user);
    // auth.notifyListeners();
  }

//   Future<Rider?> reauth({required String email, required String newPassword}) async {
// // Prompt the user to re-provide their sign-in credentials.
// // Then, use the credentials to reauthenticate:
// //     await user?.reauthenticateWithCredential(email);
// //     await user?.updatePassword(newPassword);
//   //firebase admin sdk
// //     admin.auth().getUserByEmail(email)
// //         .then(function(userRecord) {
// //         // See the UserRecord reference doc for the contents of userRecord.
// //         console.log("Successfully fetched user data:", userRecord.toJSON());
// //   })
// //         .catch(function(error) {
// //     console.log("Error fetching user data:", error);
// //     });
//     // auth.notifyListeners();
//   }


  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
    // notifyListeners();
  }

}





DatabaseV3 myDBinstance = DatabaseV3();
//controls which screen to show first
class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<Rider?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<Rider?> snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          final Rider? rider = snapshot.data;
          //TODO
          return (rider == null)? LoginPage() : UserRidesPage();
          // if(rider == null){
          //   myDBinstance.resetting(); //delete sharedPreferences file
          //
          //   return LoginPage();
          // }
          // else{
          //   if(!myDBinstance.ifExist()){
          //
          //     debugPrint("Implement creating a new sharedPreferences file...");
          //     // await myDBinstance.Writing('''
          //     //       INSERT INTO 'RIDER_PROFILE' ('NAME', 'EMAIL')
          //     //       VALUES (\"${rider.fullName}\", \"${rider.email}\")''');
          //   }
          //   return UserRidesPage();
          // }
        }
        else{
          return Scaffold(body:Center(child:CircularProgressIndicator(),),);
        }
      },
    );

  }


}



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
