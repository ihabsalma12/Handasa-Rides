import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/classes/FilteredRidesProvider.dart';
import 'package:demo/classes/BottomSheetProvider.dart';
import 'package:demo/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo/classes/Ride.dart';




class RouteSelectionPage extends StatefulWidget {
  const RouteSelectionPage({super.key});

  @override
  State<RouteSelectionPage> createState() => _RouteSelectionPageState();
}

class _RouteSelectionPageState extends State<RouteSelectionPage> {





  @override
  Widget build(BuildContext context) {

    List <String> allLocations = Provider.of<BottomSheetProvider>(context).locations;
    List<String> rideTimes = Provider.of<BottomSheetProvider>(context).ridesTimes;


    List<Ride> routeList = Provider.of<FilteredRidesProvider>(context).routesList;

    Future filterRoutes() async{
      String from_loc = Provider.of<BottomSheetProvider>(context, listen: false).selectedPickupLoc;
      String to_loc = Provider.of<BottomSheetProvider>(context, listen: false).selectedDestinationLoc;
      String time = Provider.of<BottomSheetProvider>(context, listen: false).selectedTime;
      bool bypass = Provider.of<BottomSheetProvider>(context, listen: false).bypassValue;

      debugPrint("You searched for a ride: ${from_loc}, ${to_loc}, ${time}, ${bypass.toString()}");

      //cloudfirestore query
      var queryResults = FirebaseFirestore.instance.collection("routes").get()
          .then(
          (querySnapshot) {

            var res = querySnapshot.docs;

            if(from_loc != "<None>"){
              res.clear();
              for (var docSnapshot in querySnapshot.docs) {
                // debugPrint('${docSnapshot.id} => ${docSnapshot.data()}');
                if (docSnapshot.data()['from_loc'] == from_loc) {//debugPrint('YES from_loc');
                  res.add(docSnapshot);}
              }
            }

            if(to_loc != "<None>"){
              res = res.where((docSnapshot) =>
              docSnapshot.data()['to_loc'] == to_loc
              ).toList();
              // for (var docSnapshot in res) {
              //   // debugPrint('${docSnapshot.id} => ${docSnapshot.data()}');
              //   if (docSnapshot.data()['to_loc'] == to_loc) {debugPrint('YES to_loc'); //res.add(docSnapshot);
              //     }
              // }
            }

            if(time != "<None>"){
              res = res.where((docSnapshot) =>
              docSnapshot.data()['time'] == time
              ).toList();
              // for (var docSnapshot in res) {
              //   // debugPrint('${docSnapshot.id} => ${docSnapshot.data()}');
              //   if (docSnapshot.data()['time'] == time) {debugPrint('YES time'); //res.add(docSnapshot);
              //   }
              // }
            }

            if(!bypass){
              int currentHour = DateTime.now().hour;
              int currentMinute = DateTime.now().minute;

              //22,23,0to7:30
              if(currentHour==22 || currentHour==23 || (currentHour >=0 && (currentHour<=7 && currentMinute<=30))){
                //remove all rides at 7:30 am
                res = res.where((docSnapshot) {
                  return docSnapshot.data()['time'] != "7:30 am";
                }).toList();
              }

              //13to17:30
              if(currentHour>=13 && (currentHour<=17 && currentMinute<=30)){
                //remove all rides at 5:30 pm
                res = res.where((docSnapshot) {
                  return docSnapshot.data()['time'] != "5:30 pm";
                }).toList();
              }


            }

            debugPrint("SALMA!!");
            for (var docSnapshot in res) {
              debugPrint('${docSnapshot.id} => ${docSnapshot.data()}');
            }

            //Stream<List<Ride>> filter_rides can also be the output of this whole function.

            // queryResults.addAll(res);
            // Provider.of<FilteredRidesProvider>(context, listen: false).updateRouteList(queryResults);
            //res is a list of maps, where each map is a jsonQueryDocumentSnapshot instance aka a document


            List<Ride> queryResults = res.map((docSnapshot) => Ride.fromJSON(docSnapshot.id, docSnapshot.data())).toList();
            return queryResults;


          },
          onError: (e) => debugPrint("Error completing: $e"),
      );
      Provider.of<FilteredRidesProvider>(context, listen: false).updateRouteList(await queryResults);

      // debugPrint("SALMA!! ${intermediate.toString()}");

      // final suggestions = allBooks.where((book){
      //   final bookTitle = book.title.toLowercase();
      //   final input = query.toLowercase();
      //   return bookTitle.contains(input);
      //
      // }).toList();
      // setState(() {books = suggestions;});
    }

    _displayBottomSheet(BuildContext context){
      return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        // backgroundColor, barierColor, isDismissible
        builder: (context) => SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              color: Colors.purple.shade100,
              child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Where are you going?",
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize:16,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),),
                // const SizedBox(height:10),

                RadioListTile(
                  activeColor: Colors.lightGreenAccent,

                  value: rideTimes[0],
                  groupValue: Provider.of<BottomSheetProvider>(context).selectedTime,
                  onChanged: (value) => Provider.of<BottomSheetProvider>(context, listen: false).toggleTime(value),

                  title: Text("7:30 am", style: TextStyle(fontSize: 16),),
                  subtitle: Text("ride to ASUENG", style: TextStyle(fontStyle: FontStyle.italic),),
                ),
                RadioListTile(
                  activeColor: Colors.lightGreenAccent,


                  value: rideTimes[1],
                  groupValue: Provider.of<BottomSheetProvider>(context).selectedTime,
                  onChanged: (value) => Provider.of<BottomSheetProvider>(context, listen: false).toggleTime(value),

                  title: Text("5:30 pm", style: TextStyle(fontSize: 16),),
                  subtitle: Text("ride to somewhere else in Cairo", style: TextStyle(fontStyle: FontStyle.italic),),
                ),
                const SizedBox(height:10),


                SizedBox(
                  // width: 100,
                  child: DropdownButtonFormField <String>(
                    //TODO make bottom sheet appear when screen inits
                    // hint:  Text("Select location"),
                    value: Provider.of<BottomSheetProvider>(context).selectedPickupLoc,
                    items: allLocations.map((loc) =>
                        DropdownMenuItem<String>(
                            value: loc,
                            child: Text(loc, style: const TextStyle(fontSize:14,),)
                        ))
                        .toList(),
                    onChanged: (loc) => Provider.of<BottomSheetProvider>(context, listen: false).changePickup(loc),
                    decoration: InputDecoration(
                        labelText: "Choose your pickup point",
                        labelStyle: TextStyle(fontSize:16,color: Theme.of(context).primaryColor)
                    ),
                  ),), // const SizedBox(height:10),
                SizedBox(
                  // width: 100,
                  child: DropdownButtonFormField <String>(
                    // hint:  Text("Select location"),
                    value: Provider.of<BottomSheetProvider>(context).selectedDestinationLoc,
                    items: allLocations.map((loc) =>
                        DropdownMenuItem<String>(
                            value: loc,
                            child: Text(loc, style: const TextStyle(fontSize:14,))
                        ))
                        .toList(),
                    onChanged: (loc) => Provider.of<BottomSheetProvider>(context, listen: false).changeDestination(loc),
                    decoration: InputDecoration(
                        labelText: "Choose your destination point",
                        labelStyle: TextStyle(fontSize:16,color: Theme.of(context).primaryColor)
                    ),
                  ),
                ),


                const SizedBox(height:20),
                Text("Bypass time constraint", style: TextStyle(fontWeight:FontWeight.bold),),
                Switch(
                  value: Provider.of<BottomSheetProvider>(context).bypassValue,
                  onChanged: (bypass) => Provider.of<BottomSheetProvider>(context, listen: false).toggleBypass(bypass),
                ),

                // const SizedBox(height:10),
                Row(
                  children: [
                    ElevatedButton(
                    onPressed: () async {
                      // debugPrint("You searched for a ride: ${Provider.of<BottomSheetProvider>(context, listen: false).selectedPickupLoc}, ${Provider.of<BottomSheetProvider>(context, listen: false).selectedDestinationLoc}, ${Provider.of<BottomSheetProvider>(context, listen: false).selectedTime}, ${Provider.of<BottomSheetProvider>(context, listen: false).bypassValue}");
                      // debugPrint("Updating provider: ");
                      // routeList.forEach((element) =>
                      //   debugPrint("${element.destination}, pickup: ${element.pickup} @ ${element.time}")
                      // );
                      filterRoutes();

                      if(context.mounted)Navigator.pop(context);

                    },
                    style: filterButtonStyle(),
                    child: Text("Filter rides", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorDark,)),
                  ),
                    SizedBox(width:10),
                    GestureDetector(
                        child: Text("Clear", style:TextStyle(color: Colors.grey.shade800, fontStyle: FontStyle.italic)),
                        onTap: (){
                          Provider.of<BottomSheetProvider>(context, listen: false).changePickup("<None>");
                          Provider.of<BottomSheetProvider>(context, listen: false).changeDestination("<None>");
                          Provider.of<BottomSheetProvider>(context, listen: false).toggleTime("<None>");
                          Provider.of<BottomSheetProvider>(context, listen: false).toggleBypass(false);
                        }
                    ),

                  ]),
              ],)
            )
        ),

      );
    }



    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120.0),
          child: AppBar(
            title: const Text("Rides near you", style: TextStyle(
          color: Colors.white, fontSize:20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
            toolbarHeight: 120.0,
            automaticallyImplyLeading: false,
            leading:  IconButton(onPressed:(){Navigator.pop(context);}, icon: const Icon(Icons.account_circle, color: Colors.white,)),
            flexibleSpace: Container(),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
            shape: const Border(
            bottom: BorderSide(width: 1, color: Colors.black12),
            ),
          ),
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.pushReplacementNamed(context, '/FilterRoutes');
        },
        child: IconButton(onPressed: (){_displayBottomSheet(context);} ,
          icon: Icon(Icons.filter_list, color: Theme.of(context).primaryColorDark),)),
      resizeToAvoidBottomInset: false,
      body:
      ListView.builder(
          itemCount: routeList.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              // padding: const EdgeInsets.all(20.0),
              color: Colors.grey.shade300,
              child: ListTile(
                onTap: () {
                  debugPrint("'doc_id' : ${routeList[index].id}");
                  Navigator.pushNamed(context, "/RouteDetails", arguments: {'doc_id' : routeList[index].id});
                },
                title: Text("${routeList[index].destination}",
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(
                    "pickup: ${routeList[index].pickup} @ ${routeList[index]
                        .time}"),
              ),
            );
          },
        ),
    );


  }


}



//alternative appBar

// appBar: PreferredSize(
//   preferredSize: Size.fromHeight(100),
//   child: Stack(
//     fit: StackFit.expand,
//     children: [
//       Container(color: Theme.of(context).primaryColor,
//         padding: EdgeInsets.all(5),
//         alignment: Alignment.bottomCenter, child: const Text("Rides near you", style: TextStyle(
//           color: Colors.white, fontSize:21, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),),
//       // Positioned.fill(
//       //   child: Align(
//       //     alignment: Alignment.bottomLeft,
//       //     child: IconButton(icon: Icon(Icons.filter_list), onPressed: () {},),
//       //   ),
//       // ),
//     ],
//   ),
// ),




//alternative bodys

// body: ListView.builder(
//     itemCount: rides.length,
//     itemBuilder: (context, index){
//       // return Container(
//       //   //color: Color(0xFFFFA726),
//       //   margin: EdgeInsetsDirectional.symmetric(vertical:10.0, horizontal:20.0),
//       //   decoration: BoxDecoration(
//       //       color: Color(0xFFABCDEF),
//       //     border: Border(top:BorderSide(width:2)),
//       //   ),
//       //   child: ListTile(
//       //     onTap: (){
//       //       Navigator.pushNamed(context, "/RouteDetails");
//       //     },
//       //     // show map details and pricing
//       //     title: Text(rides[index].destination.toString()),
//       //     subtitle: Text("pickup: ${rides[index].pickup} @ ${rides[index].time}" ),
//       //   ),
//       // );
//       return Card(
//           // child: Container(
//             // decoration: BoxDecoration(
//             //   color: Color(0xFFABCDEF),
//             //   // border: Border(
//             //   //   top: BorderSide(width:2),
//             //   //   bottom: BorderSide(width:2),
//             //   //   left: BorderSide(width:2),
//             //   //   right: BorderSide(width:2),
//             //   // ),
//             // ),
//             //margin: EdgeInsets.all(8.0),
//             //padding: const EdgeInsets.all(20.0),
//             child: ListTile(
//               onTap: (){
//                 Navigator.pushNamed(context, "/RouteDetails");
//               },
//               // show map details and pricing
//               title: Text("${rides[index].destination}", style: TextStyle(fontWeight: FontWeight.w600)),
//               subtitle: Text("pickup: ${rides[index].pickup} @ ${rides[index].time}" ),
//             ),
//         color: Colors.deepPurple.shade100,
//         //shape: RoundedRectangleBorder(side:BorderSide(width:2)),
//         elevation: null,
//       );
//     })

// body: Column(children: [
//     // search bar
//   Container(
//     // Add padding around the search bar
//     padding: const EdgeInsets.all(16.0),
//     // Use a Material design search bar
//     child: TextField(
//       //onChanged: searchRides(),
//       controller: searchController,
//       decoration: InputDecoration(
//         hintText: 'Search rides',
//         // Add a clear button to the search bar
//         suffixIcon: IconButton(
//           icon: Icon(Icons.clear),
//           onPressed: () => searchController.clear(),
//         ),
//         // Add a search icon or button to the search bar
//         prefixIcon: IconButton(
//           icon: Icon(Icons.search),
//           onPressed: () {
//             // Perform the search here
//           },
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//       ),
//     ),
//   ),
//
//
//   Expanded(
//       child: rides.isNotEmpty != 0 ? ListView.builder(
//         itemCount: rides.length,
//         itemBuilder: (context, index) {
//           return Card(
//             child: ListTile(
//               onTap: (){
//                 Navigator.pushNamed(context, "/RouteDetails");
//               },
//               // show map details and pricing
//               title: Text(rides[index].destination.toString()),
//               subtitle: Text("pickup: ${rides[index].pickup} @ ${rides[index].time}" ),
//               tileColor: Color(0xFFFFFFBB),
//             ),
//           );
//         },
//       )
//           : Center(
//         child: Text('Search'),
//       ),
//     ),
//
// ]),