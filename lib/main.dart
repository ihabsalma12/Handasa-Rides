import 'package:demo/Classes.dart';
import 'package:flutter/material.dart';
import 'package:demo/screens/login.dart';
import 'package:demo/screens/signup.dart';
import 'package:demo/screens/change_pass.dart';
import 'package:demo/screens/route_list.dart';
import 'package:demo/screens/ride_details.dart';
import 'package:demo/screens/my_rides.dart';
import 'package:demo/screens/launch.dart';
import 'package:demo/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';



Future <void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
      ],
      child: MaterialApp(
        theme: MyTheme(),
        debugShowCheckedModeBanner: false,
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
    ),
  );
}
