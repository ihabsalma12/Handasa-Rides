import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Classes.dart';
import '../controller.dart';


class UserRidesPage extends StatefulWidget {
  const UserRidesPage({super.key});

  @override
  State<UserRidesPage> createState() => _UserRidesPageState();
}

class _UserRidesPageState extends State<UserRidesPage> {
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final riderUser = Provider.of<AuthService>(context).user;

    return Scaffold(
        appBar: AppBar(
          title: Text("My Profile", style: TextStyle(
              fontSize:20, fontWeight: FontWeight.bold),),
          actions: [
            Container(
              margin: EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () async {
                    await authService.signOut();
                    debugPrint("Signing you out!");
                    //Navigator.pushReplacementNamed(context, "/Login");
                  },
                  style: ElevatedButton.styleFrom(
                    //padding: EdgeInsets.symmetric(horizontal: 15.0),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      //eccentricity: 0.5
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                  ),
                  child: Text("Sign out", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,
                    color: Theme.of(context).primaryColorDark,),)
              ),
            ),
          ],
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
        ),
        body: ListView(
          children: [

            Card(
              margin: EdgeInsetsDirectional.symmetric(vertical: 8.0, horizontal: 20.0),
              color: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                //eccentricity: 0.5
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                //margin: EdgeInsetsDirectional.symmetric(vertical: 2.0, horizontal: 2.0),


                  padding: const EdgeInsets.all(20.0),
                  child: StreamBuilder(stream: authService.user, builder: (_, AsyncSnapshot<Rider?> snapshot){
                    if(snapshot.connectionState == ConnectionState.active){
                      final Rider? rider = snapshot.data;
                      return rider == null ? Text("Null rider") : Text(rider.fullName! + '\n' + rider.email!);
                    }
                    else{
                      return Center(child:CircularProgressIndicator(),);
                    }
                  },)),
            ),
            Divider(thickness:0, height: 40, color: Colors.transparent,),
            Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsetsDirectional.symmetric(horizontal: 20.0),
              // color: Colors.grey.shade400,
              child: ElevatedButton.icon(
                onPressed: (){
                  Navigator.pushNamed(context, "/RouteSelect");
                },
                style: ElevatedButton.styleFrom(
                  //padding: EdgeInsets.symmetric(horizontal: 15.0),
                  // elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    //eccentricity: 0.5
                    borderRadius: BorderRadius.circular(10),
                    // side: BorderSide(width:1.0),
                  ),
                  backgroundColor: Colors.purpleAccent.shade700,
                ),
                icon: Icon(Icons.add),
                label: Text("Add Ride", style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ),
            Card(
              margin: EdgeInsetsDirectional.symmetric(horizontal: 20.0),
              color: Colors.lightGreenAccent,
              shape: RoundedRectangleBorder(
                //eccentricity: 0.5
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                //margin: EdgeInsetsDirectional.symmetric(vertical: 2.0, horizontal: 2.0),


                  padding: const EdgeInsets.all(20.0),
                  child: Text("my rides here!!")),
            ),

          ],

        )
    );
  }
}


