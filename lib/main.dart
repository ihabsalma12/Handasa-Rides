import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:demo/screens/login.dart';
import 'package:demo/screens/signup.dart';
import 'package:demo/screens/change_pass.dart';
import 'package:demo/screens/route_list.dart';
import 'package:demo/screens/ride_details.dart';
import 'package:demo/screens/my_rides.dart';
import 'package:demo/screens/launch.dart';
import 'package:demo/theme.dart';




void main() //async
{

  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(
    MaterialApp(
      title: "MyApp",

      // theme: ThemeData(
      //   useMaterial3: true,
      //
      //   // Define the default brightness and colors.
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: Colors.purple,
      //     // ···
      //     brightness: Brightness.dark,
      //   ),
      //
      //   //Define the default `TextTheme`. Use this to specify the default
      //   //text styling for headlines, titles, bodies of text, and more.
      //   // textTheme: TextTheme(
      //   //   displayLarge: const TextStyle(
      //   //     fontSize: 72,
      //   //     fontWeight: FontWeight.bold,
      //   //   ),
      //   //   // ···
      //   //   titleLarge: GoogleFonts.oswald(
      //   //     fontSize: 30,
      //   //     fontStyle: FontStyle.italic,
      //   //   ),
      //   //   bodyMedium: GoogleFonts.merriweather(),
      //   //   displaySmall: GoogleFonts.pacifico(),
      //   // ),
      // ),

      theme: MyTheme(),
      // darkTheme: ThemeData.dark(), // standard dark theme
      // themeMode: ThemeMode.system, // device controls theme

      debugShowCheckedModeBanner: false,
      //home: const LaunchPage(),
      initialRoute: '/Launch',
      routes:{
        "/Launch": (context) => LaunchPage(),

        "/Login": (context) => const LoginPage(),
        "/SignUp": (context) => const SignUpPage(),
        "/ChangePass": (context) => const ChangePassPage(),
        "/RouteSelect": (context) => const RouteSelectionPage(),
        "/RouteDetails": (context) => const RouteDetailsPage(),
        "/UserRides": (context) => const UserRidesPage(),
      },
    ),
  );
}










