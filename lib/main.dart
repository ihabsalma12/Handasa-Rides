import 'package:demo/services/AuthService.dart';
import 'package:demo/helpers/BottomSheetProvider.dart';
import 'package:demo/helpers/FilteredRidesProvider.dart';
import 'package:demo/view/cart.dart';
import 'package:flutter/material.dart';
import 'package:demo/view/login.dart';
import 'package:demo/view/signup.dart';
import 'package:demo/view/route_list.dart';
import 'package:demo/view/ride_details.dart';
import 'package:demo/view/my_rides.dart';
import 'package:demo/view/launch.dart';
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
        ChangeNotifierProvider.value(value: BottomSheetProvider()),
        ChangeNotifierProvider.value(value: FilteredRidesProvider()),
      ],
      child: MaterialApp(
        theme: MyTheme(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/Launch',
        routes:{
          "/Launch": (context) => LaunchPage(),

          "/Login": (context) => const LoginPage(),
          "/SignUp": (context) => const SignUpPage(),
          "/RouteSelect": (context) => const RouteSelectionPage(),
          "/RouteDetails": (context) => const RouteDetailsPage(),
          "/UserRides": (context) => const UserRidesPage(),
          "/Cart": (context) => const CartPage()
        },
      ),
    ),


  );
}
