// List <Ride> rides = [
//   Ride("Gate 3", "Maadi", "5:30 pm"),
//   Ride("Nasr City", "Gate 3", "7:30 am"),
//   Ride("Gate 4", "New Cairo", "5:30 pm"),
//   Ride("Gate 3", "Dokki", "5:30 pm"),
//   Ride("Gate 4", "6th October", "5:30 pm"),
//   Ride("Madinaty", "Gate 3", "7:30 am"),
//   Ride("Gate 4", "Korba", "5:30 pm"),
//   Ride("Gate 4", "Al Azhar", "5:30 pm"),
//   Ride("Gate 3", "Sayeda Aisha", "5:30 pm"),
//   Ride("Shoubra ElKheima", "Gate 3", "7:30 am"),
//   Ride("Gate 3", "Saqr Qureish", "5:30 pm"),
//   Ride("Gate 3", "Zamalek", "5:30 pm"),
// ]; //fetch from db



class Ride {
  String id;
  String driver_email;
  String driver_name;
  String pickup;
  String destination;
  String time;
  String price;
  String status;

  // List<String> stops = [];

  Ride(String this.id, String this.driver_email, String this.driver_name, this.pickup, String this.destination,
      String this.time, String this.price, String this.status);

  static Ride fromJSON(String id, Map<String, dynamic> json) => Ride(
    id,
    json['driver_email'],
    json['driver_name'],
    json['from_loc'],
    json ['to_loc'],
    json['time'],
    json['price'],
    json['status']



  );


}