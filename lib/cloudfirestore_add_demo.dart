
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:demo/view/login.dart';
import 'package:demo/view/signup.dart';
import 'package:demo/view/change_pass.dart';
import 'package:demo/view/route_list.dart';
import 'package:demo/view/ride_details.dart';
import 'package:demo/view/my_rides.dart';
import 'package:demo/view/launch.dart';
import 'package:demo/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controller.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';



Future <void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(


      MaterialApp(
        home: MyAddFirestore(),
      )

  );
}


class MyAddFirestore extends StatefulWidget {
  const MyAddFirestore({super.key});

  @override
  State<MyAddFirestore> createState() => _MyAddFirestoreState();
}

class _MyAddFirestoreState extends State<MyAddFirestore> {
  @override
  Widget build(BuildContext context) {

    final from_locController = TextEditingController();
    final to_locController = TextEditingController();
    final timeController = TextEditingController();
    final priceController = TextEditingController();
    final driverController = TextEditingController();

    Future createDocument(String from_loc, String to_loc, String time, String price, String driver) async{

      final docRoute = FirebaseFirestore.instance.collection('routes').add(
          {
            "from_loc" : from_loc,
            "to_loc" : to_loc,
            "time" : time,
            "price" : price,
            "driver" : driver
          }
      ).then((DocumentReference doc) =>
          debugPrint('DocumentSnapshot added with ID: ${doc.id}'));



    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Add ride"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () { createDocument(from_locController.text, to_locController.text, timeController.text, priceController.text, driverController.text); },
          child: Icon(Icons.add),
        ),
        body: ListView(
            children:
            [
              TextField(controller: from_locController,),
              TextField(controller: to_locController),
              TextField(controller: timeController,),
              TextField(controller: priceController,),
              TextField(controller: driverController,),
            ]
        )
    );
  }
}

