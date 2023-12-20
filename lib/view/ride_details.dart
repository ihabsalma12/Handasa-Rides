
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RouteDetailsPage extends StatefulWidget {
  const RouteDetailsPage({super.key});


  @override
  State<RouteDetailsPage> createState() => _RouteDetailsPageState();
}

class _RouteDetailsPageState extends State<RouteDetailsPage> {

  Map received_data = {};




  bookRoute() async{
    try{
		final docRoute = await FirebaseFirestore.instance
        .collection('routes')
        .doc(received_data['doc_id'])
        .collection('riders')
        .doc(FirebaseAuth.instance.currentUser!.uid).set(
        {
          'rider_uid' : FirebaseAuth.instance.currentUser!.uid,
          'rider_name' : FirebaseAuth.instance.currentUser!.displayName,
          'rider_email' : FirebaseAuth.instance.currentUser!.email,
          'status' : 'awaiting approval'
        }
        );

      // .then((DocumentReference doc) =>
      debugPrint('DocumentSnapshot added with ID: ${received_data['doc_id']}');
      if(context.mounted) {
        Navigator.of(context).pop(); ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Ride booked successfully!'),));
      }
	  }
    on Exception catch (error){
      debugPrint("Some internal error happened:${error.toString()}");
      final snackBar = SnackBar(content: Text("Some internal error happened:${error.toString()}"),);
      if(context.mounted) ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }



  }


  @override
  Widget build(BuildContext context) {

    received_data = ModalRoute.of(context)!.settings.arguments as Map;
    DocumentReference currentRoute = FirebaseFirestore.instance.collection("routes").doc(received_data['doc_id']);

    var querySnapshot = currentRoute
        .collection('riders')
        .doc(FirebaseAuth.instance.currentUser!.uid);



    checkDisabled(DocumentSnapshot document) async{
      //if status is not accepting requests
      if(document['status'] != 'accepting requests'){
        if(context.mounted) ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Ride is not accepting requests at the moment.'),));
        return true;
      }

      //if rider has already booked
      bool bookingExists=(await querySnapshot.get()).exists;


      if(bookingExists){
        if(context.mounted) ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ride is already booked. Check your rides history in your profile page for updates.'),));
        return true;
      }

      return false;
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Ride Details", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: Theme.of(context).primaryColor,
            leading: const BackButton(color: Colors.white)
        ),
        body: Center(child: Container(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: currentRoute.snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                var document = snapshot.data!;

                return ListView(
                children: [
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:[
                                Icon(Icons.location_pin, color: Theme.of(context).primaryColorLight,),
                                const SizedBox(width:5.0),
                                Text(
                                  "pickup location",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ]

                          ),
                          Text("${document['from_loc']}",
                            style: const TextStyle(
                              // color: Theme.of(context).primaryColorLight,
                              fontWeight: FontWeight.bold,
                              // backgroundColor: Colors.white,
                              fontSize: 25,
                              // fontStyle: FontStyle.italic,
                            ),
                          ),
                          const Divider(thickness:0, height: 30, color: Colors.transparent,),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:[
                                Icon(Icons.location_pin, color: Theme.of(context).primaryColorLight,),
                                const SizedBox(width:5.0),
                                Text(
                                  "destination location",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ]

                          ),
                          Text("${document['to_loc']}",
                            style: const TextStyle(
                              // color: Theme.of(context).primaryColorLight,
                              fontWeight: FontWeight.bold,
                              // backgroundColor: Colors.white,
                              fontSize: 25,
                              // fontStyle: FontStyle.italic,
                            ),
                          ),
                          const Divider(thickness:0, height: 30, color: Colors.transparent,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:[
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.time_to_leave
                                      , color: Theme.of(context).primaryColorLight,
                                    ),
                                    Text(
                                        "pickup time",
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColorLight,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                        )),
                                    Text("${document['time']}",
                                      style: const TextStyle(
                                        // color: Theme.of(context).primaryColorLight,
                                        fontWeight: FontWeight.bold,
                                        // backgroundColor: Colors.white,
                                        fontSize: 25,
                                        // fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ]
                              ),
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                color: Colors.lightGreenAccent,
                                // alignment: Alignment.center,
                                child: Text(
                                  "${document['price']} L.E.",
                                  style: const TextStyle(
                                    // color: Theme.of(context).primaryColorLight,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21,
                                    // fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),

                            ]

                          ),
                          Divider(thickness:1, height: 60, color: Theme.of(context).primaryColorLight,),
                          Row(
                            children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:[
                                    Icon(Icons.person,
                                      color: Theme.of(context).primaryColorLight,
                                    ),
                                    Text(
                                      "driver",
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColorLight,
                                        fontWeight: FontWeight.bold,
                                        // fontSize: 21,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ]

                              ),
                              const SizedBox(width:15.0),
                              Expanded(
                                child: Text(
                                  "${document['driver_name']}"
                                      "\n${document['driver_email']}",
                                
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Text("\n${document['status']}",
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.bold,
                              fontSize: 21,
                              // fontStyle: FontStyle.italic,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: ElevatedButton(
                      
                      style: ElevatedButton.styleFrom(
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                        backgroundColor: Theme.of(context).primaryColorLight,
                            ),
                      onPressed:  ()async {
                        if(await checkDisabled(document) == false) {
                        //display alert
                        bookRoute();
                        }
                      },
                      child: Text("Book",
                        style: TextStyle(
                      fontWeight: FontWeight.bold,
                            // color: Colors.white
                            color: Theme.of(context).secondaryHeaderColor
                      )),
                    
                    ),
                  ),//(
              //
              //       // style: ElevatedButton.styleFrom(
              //       //   elevation: 2.0,
              //       //   shape: RoundedRectangleBorder(
              //       //     borderRadius: BorderRadius.circular(20),
              //       //   ),
              //       //   backgroundColor: Theme.of(context).secondaryHeaderColor,
              //       // ),
              //
              //     ),
                ],
              );
              }
              else if (snapshot.hasError) return Text("${snapshot.error}");
              else return const CircularProgressIndicator();


            }
          ),
        ))
    );
  }
}