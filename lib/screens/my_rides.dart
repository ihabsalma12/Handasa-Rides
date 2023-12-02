import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Classes.dart';


class UserRidesPage extends StatefulWidget {
  const UserRidesPage({super.key});

  @override
  State<UserRidesPage> createState() => _UserRidesPageState();
}

class _UserRidesPageState extends State<UserRidesPage> {
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Rides"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: //todo listview of my rides....
      // TODO sidebar/topbar for profile info
      Row( //todo implement as my Custom ListTile
        children: [
          IconButton(
            icon: const Icon(Icons.add, size: 24,),
            onPressed: (){Navigator.pushNamed(context, "/RouteSelect");},
          ),
          const Text("Add Ride"),
          ElevatedButton(onPressed: () async {
            await authService.signOut();
            debugPrint("Signing you out!");
            Navigator.pushReplacementNamed(context, "/Login");
          },
              child: Text("Sign out")),
        ],
      )


    );
  }
}
