// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class FilterRoutesPage extends StatefulWidget {
//   const FilterRoutesPage({super.key});
//
//   @override
//   State<FilterRoutesPage> createState() => _FilterRoutesPageState();
// }
//
// class _FilterRoutesPageState extends State<FilterRoutesPage> {
//   @override
//   Widget build(BuildContext context) {
//
//     final pickupContr = TextEditingController();
//     final destinationContr = TextEditingController();
//
//
//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.all(20),
//             color: Theme.of(context).primaryColorDark,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//               Text(
//                 "Where are you going?",
//                 style: TextStyle(
//                     color: Theme.of(context).secondaryHeaderColor,
//                     fontSize:21,
//                     fontWeight: FontWeight.bold,
//                     fontStyle: FontStyle.italic),),
//               SizedBox(height:10),
//               SizedBox(
//                 width: 250,
//                 child: TextFormField(
//                   controller: pickupContr,
//                   decoration: InputDecoration(
//                       labelText: "Choose your pickup point",
//                       labelStyle: TextStyle(fontSize:14,color: Theme.of(context).secondaryHeaderColor)
//                   ),
//                   validator: (value){if (value == null || value.isEmpty){}}
//                 ),
//               ),
//               SizedBox(height:10),
//               SizedBox(
//                 width: 250,
//                 child: TextFormField(
//                     controller: destinationContr,
//                     maxLength: 20,
//                     decoration: InputDecoration(
//                         labelText: "Choose your destination point",
//                         labelStyle: TextStyle(fontSize:14,color: Theme.of(context).secondaryHeaderColor)
//                     ),
//                     validator: (value){if (value == null || value.isEmpty){}}
//                 ),
//               ),
//
//
//               SizedBox(height:20),
//               ElevatedButton(
//                 onPressed: () {
//                 Navigator.pushReplacementNamed(context, '/RouteSelect');
//                 },
//                 style: ElevatedButton.styleFrom(
//                     elevation: 2.0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     backgroundColor: Theme.of(context).secondaryHeaderColor,
//                 ),
//                 child: Text("Filter rides", style: TextStyle(fontWeight: FontWeight.bold,
//                   color: Theme.of(context).primaryColorDark,)),
//               ),
//             ],)
//           ),
//         )
//       )
//     );
//   }
// }
