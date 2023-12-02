import 'package:flutter/material.dart';
import '../Classes.dart';




class RouteSelectionPage extends StatefulWidget {
  const RouteSelectionPage({super.key});

  @override
  State<RouteSelectionPage> createState() => _RouteSelectionPageState();
}

class _RouteSelectionPageState extends State<RouteSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Route List Page"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: rides.length,
          itemBuilder: (context, index){
            return ListTile(
              onTap: (){
                Navigator.pushNamed(context, "/RouteDetails");
              },
              // show map details and pricing
              title: Text(rides[index].destination.toString()),
              subtitle: Text("pickup: ${rides[index].pickup} @ ${rides[index].time}" ),
            );
          })
    );
  }
}


