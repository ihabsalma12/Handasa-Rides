import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/classes/RiderSubcollectionWidget.dart';
import 'package:demo/services/FirebaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo/classes/Rider.dart';
import 'package:demo/services/AuthService.dart';


class UserRidesPage extends StatefulWidget {
  const UserRidesPage({super.key});

  @override
  State<UserRidesPage> createState() => _UserRidesPageState();
}

class _UserRidesPageState extends State<UserRidesPage> {

  final CollectionReference routesCollection = FirebaseFirestore.instance.collection("routes");




  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("My Profile", style: TextStyle(
              color: Colors.white, fontSize:20, fontWeight: FontWeight.bold),),
          actions: [
            Container(
              margin: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () async {
                    await authService.signOut();
                    debugPrint("Signing you out!");
                    if(context.mounted)Navigator.pushReplacementNamed(context, "/Login");
                  },
                  style: ElevatedButton.styleFrom(
                    //padding: EdgeInsets.symmetric(horizontal: 15.0),
                    elevation: 2.0,
                    shape: const RoundedRectangleBorder(
                      //eccentricity: 0.5                      borderRadius: BorderRadius.circular(20),
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
              margin: const EdgeInsetsDirectional.symmetric(vertical: 8.0, horizontal: 20.0),
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
                      return rider == null ? const Text("Null rider") : Text('${rider.fullName!}\n${rider.email!}');
                    }
                    else{
                      return const Center(child:CircularProgressIndicator(),);
                    }
                  },)),
            ),
            const Divider(thickness:0, height: 5, color: Colors.transparent,),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsetsDirectional.symmetric(horizontal: 20.0),
              // color: Colors.grey.shade400,
              child: Container(
                width: 60.0,
                height: 60.0,
                decoration: const BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart, color: Colors.white),
                  onPressed: (){
                    Navigator.pushNamed(context, "/Cart");
                  },
                ),
              ),
              // ElevatedButton.icon(
              //   onPressed: (){
              //     Navigator.pushNamed(context, "/Cart");
              //   },
              //   style: ElevatedButton.styleFrom(
              //     //padding: EdgeInsets.symmetric(horizontal: 15.0),
              //     // elevation: 2.0,
              //     shape: RoundedRectangleBorder(
              //       //eccentricity: 0.5
              //       borderRadius: BorderRadius.circular(10),
              //       // side: BorderSide(width:1.0),
              //     ),
              //     backgroundColor: Colors.deepPurpleAccent,
              //   ),
              //   icon: const Icon(Icons.credit_card),
              //   label: const Text("Go to my cart", style: TextStyle(fontWeight: FontWeight.bold),),
              // ),
            ),
            const Divider(thickness:0, height: 15, color: Colors.transparent,),
            Container(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsetsDirectional.symmetric(horizontal: 20.0),
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
                icon: Icon(Icons.add, color: Theme.of(context).secondaryHeaderColor),
                label: Text("Add Ride",
                  style: TextStyle(fontWeight: FontWeight.bold
                  , color: Theme.of(context).secondaryHeaderColor,),),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(20.0),
              color: Colors.lightGreenAccent,
              shape: RoundedRectangleBorder(
                //eccentricity: 0.5
                borderRadius: BorderRadius.circular(10),
              ),
              child: StreamBuilder(
                stream: FirebaseService.getRiderHistory(authService.getUserUID()),
                //returns a stream of ONLY the rides where user is involved.
                builder: (context, snapshot){
                  if (snapshot.hasData){


                    //updates the documents with the rides
                    //TODO very important: ride status, when changed, is not updated at rider's end. (unless hot reload)
                    // // Extract a list of DocumentChanges
                    // List<DocumentChange<Map<String, dynamic>>> documentChanges = snapshot.data!.docChanges;

                    List<DocumentSnapshot> rideHistory = snapshot.data!;


                    // return Text('${rideHistory[0].id} => ${rideHistory[0].data()} check debug');
                    // documents = snapshot.data!.docs;
                    // documents = documents.where((element) {
                    //   return element
                    //       .get('riders')
                    //       .contains(searchText.toLowerCase());
                    // }).toList();

                    return ListView.builder(
                    itemCount: rideHistory.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.white70,
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                        title: Wrap(
                          children: [
                            Text("${rideHistory[index]['from_loc']}",
                                style: const TextStyle(fontWeight: FontWeight.bold,)),
                            const Text(" to "),
                            Text("${rideHistory[index]['to_loc']}",
                                style: const TextStyle(fontWeight: FontWeight.bold,)),
                          ],
                        ),
                        subtitle: Wrap(
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text("driver ${rideHistory[index]['status']} "),
                                Text("my status: ", //display the rider subcollection info
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple.shade800),),
                                RiderSubcollectionWidget(
                                    route_id: rideHistory[index].id, rider_uid: authService.getUserUID()),
                                const SizedBox(height:10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${rideHistory[index]['time']}"),
                                    Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(5.0),
                                        color:Colors.purple.shade100,
                                        child: Text("${rideHistory[index]['price']} L.E."))
                                  ],
                                )
                              ]
                            ),
                          ],
                        ),

                        ),
                      );
                    }, //list of listTiles


                    );
                  }
                  else if (snapshot.hasError){
                    debugPrint("${snapshot.error}");
                    return Text("${snapshot.error}");
                  }
                  else{
                    return const CircularProgressIndicator();
                  }

                },
              ),
            ),

          ],

        )
    );
  }
}


