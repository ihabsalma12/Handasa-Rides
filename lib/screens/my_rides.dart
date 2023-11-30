import 'package:flutter/material.dart';


class UserRidesPage extends StatefulWidget {
  const UserRidesPage({super.key});

  @override
  State<UserRidesPage> createState() => _UserRidesPageState();
}

class _UserRidesPageState extends State<UserRidesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Rides"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: //todo listview of my rides....
      Row( //todo implement as my Custom ListTile
        children: [
          IconButton(
            icon: const Icon(Icons.add, size: 24,),
            onPressed: (){Navigator.pushNamed(context, "/RouteSelect");},
          ),
          const Text("Add Ride"),
        ],
      )


    );
  }
}
