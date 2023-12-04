
List <Ride> rides = [
  Ride("Gate 3", "Maadi", "5:30 pm"),
  Ride("Nasr City", "Gate 3", "7:30 am"),
  Ride("Gate 4", "New Cairo", "5:30 pm"),
  Ride("Gate 3", "Dokki", "5:30 pm"),
  Ride("Gate 4", "6th October", "5:30 pm"),
  Ride("Madinaty", "Gate 3", "7:30 am"),
  Ride("Gate 4", "Korba", "5:30 pm"),
  Ride("Gate 4", "Al Azhar", "5:30 pm"),
  Ride("Gate 3", "Sayeda Aisha", "5:30 pm"),
  Ride("Shoubra ElKheima", "Gate 3", "7:30 am"),
  Ride("Gate 3", "Saqr Qureish", "5:30 pm"),
  Ride("Gate 3", "Zamalek", "5:30 pm"),
]; //fetch from db



class Ride {
  String? id;
  String? pickup;
  String? destination;
  String? time;
  String? price;
  String? driver;
  int? distance;
  String? status;

  Ride(String this.pickup, String this.destination, String this.time);

  static Ride fromJSON(Map<String, dynamic> json) => Ride(
    //TODO fix this so we can fetch all data then create a class with ALL that info
    //id : json['id'],
    json['from_loc'],
    json ['to_loc'],
    json['time']
  );


}

class Student {
  final String uid;
  final String? fullName;
  final String? email;
  final String? password;

  Student(this.uid, this.fullName, this.email, this.password);

}

class Driver extends Student{
  Driver(super.uid, super.fullName, super.email, super.password);

}

class Rider extends Student{
  Rider(super.uid, super.fullName, super.email, super.password);
}






//TODO move to a separate assets file
// class MyTextField extends StatelessWidget {
//
//   final TextEditingController controller;
//   final String fieldName;
//   MyTextField({super.key, required this.controller, required this.fieldName});
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: this.controller,
//       textAlign: TextAlign.center,
//       style: TextStyle(
//         color: Color(0xFF393939),
//         fontSize: 13,
//         fontFamily: 'Poppins',
//         fontWeight: FontWeight.w400,
//       ),
//       decoration: InputDecoration(
//         labelText: this.fieldName,
//         labelStyle: TextStyle(
//           color: Color(0xFF755DC1),
//           fontSize: 15,
//           fontFamily: 'Poppins',
//           fontWeight: FontWeight.w600,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10)),
//           borderSide: BorderSide(
//             width: 1,
//             color: Color(0xFF837E93),
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10)),
//           borderSide: BorderSide(
//             width: 1,
//             color: Color(0xFF9F7BFF),
//           ),
//         ),
//       ),
//     );
//   }
// }