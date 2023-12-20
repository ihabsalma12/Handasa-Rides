//controls which screen to show first
import 'package:demo/services/AuthService.dart';
import 'package:demo/classes/Rider.dart';
import 'package:demo/view/login.dart';
import 'package:demo/view/my_rides.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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