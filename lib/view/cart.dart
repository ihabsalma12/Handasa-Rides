import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/services/AuthService.dart';
import 'package:demo/classes/RiderSubcollectionWidget.dart';
import 'package:demo/services/FirebaseService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  String dialogText = '';


  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    Future openPayDialog(String route_id) => showDialog(context: context, builder: (context) =>
        AlertDialog(
          title: Container(alignment: Alignment.center, child: Text("Pay Now?", style: TextStyle(fontWeight: FontWeight.bold))),
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              alignment: Alignment.center,
              child: ElevatedButton(onPressed: () async {
                FirebaseService.payRide(route_id, authService.getUserUID(), "cash");
                Navigator.of(context).pop();

              }, child: const Text("Pay by cash")),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              alignment: Alignment.center,
              child: ElevatedButton(onPressed: () async {
                FirebaseService.payRide(route_id, authService.getUserUID(), "card");
                Navigator.of(context).pop();

              }, child: const Text("Pay by card")),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              alignment: Alignment.center,
              child: TextButton(
                onPressed: (){
                  Navigator.of(context).pop();

                }, child: const Text("Cancel"),
              ),
            )
          ],
        ),
    );


    return Scaffold(
      appBar: AppBar(title: Text("My Cart", style: TextStyle(fontWeight: FontWeight.bold)),),
      body: Column(
        children: [
          Container(
            child: StreamBuilder(
              stream: FirebaseService.getRiderCart(authService.getUserUID()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<DocumentSnapshot> approvedRoutes = snapshot.data!;
                  double total = 0.0;

                  for (DocumentSnapshot snapshot in approvedRoutes) {
                    if (snapshot.exists) {
                      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
                      if (data != null && data.containsKey('price')) {
                        total += double.parse(data['price']);
                        debugPrint("SALMA SUM is $total");
                      }
                    }
                  }

                  return Text("Total credit due: ${total}");
                }
                else if (snapshot.hasError) {
                  return Text('Internal Error: ${snapshot.error}');
                }
                else {
                  return const CircularProgressIndicator();
                }
              }
              // child:Text("Total credit due: ${FirebaseService.getTotalCreditDue(authService.getUserUID())}")
            ),
          ),
          Container(
            color: Theme.of(context).secondaryHeaderColor,
            child: StreamBuilder(
              stream: FirebaseService.getRiderCart(authService.getUserUID()),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  List<DocumentSnapshot<Object?>> approvedRoutes = snapshot.data!;

                  return ListView.builder(
                    itemCount: approvedRoutes.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.white70,
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Wrap(
                            // alignment: WrapAlignment.center,
                            children: [
                              Text("${approvedRoutes[index]['from_loc']}",
                                  style: const TextStyle(fontWeight: FontWeight.bold,)),
                              const Text(" to "),
                              Text("${approvedRoutes[index]['to_loc']}",
                                  style: const TextStyle(fontWeight: FontWeight.bold,)),

                            ],
                          ),
                          subtitle: Wrap(
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${approvedRoutes[index]['time']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                                    Text("driver ${approvedRoutes[index]['status']} "),
                                    Text("my status: ",
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple.shade800),),
                                    RiderSubcollectionWidget(
                                        route_id: approvedRoutes[index].id, rider_uid: authService.getUserUID()),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(5.0),
                                            color:Colors.purple.shade100,
                                            child: Text("${approvedRoutes[index]['price']} L.E.")),
                                        const SizedBox(width:10),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: ElevatedButton(
                                              onPressed: (){
                                                openPayDialog(approvedRoutes[index].id);
                                              },
                                              child: const Text("Pay Now")
                                          ),
                                        ),
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
                else if (snapshot.hasError) {
                  return Text('Internal Error: ${snapshot.error}');
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
