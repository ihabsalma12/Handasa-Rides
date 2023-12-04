import 'package:flutter/material.dart';

class RouteDetailsPage extends StatefulWidget {
  const RouteDetailsPage({super.key});


  @override
  State<RouteDetailsPage> createState() => _RouteDetailsPageState();
}

class _RouteDetailsPageState extends State<RouteDetailsPage> {

  //Map received_data = {};
  @override
  Widget build(BuildContext context) {

    //received_data = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Route Details Page"),
          backgroundColor: Theme.of(context).primaryColor,

        ),
        body: Center(child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            ""
            //TODO pass data
            // "${received_data['name']} time is currently ${received_data['time']}.",
            "Route details here...",
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ))
    );
  }
}