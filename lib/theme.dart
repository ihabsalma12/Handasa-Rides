import 'package:flutter/material.dart';

ThemeData MyTheme(){
  return ThemeData(
    useMaterial3: true,

  //     color palette:
  //     dark:(bg black)
  // #A163F5
  // #B074EE
  // #D8A1DD
  // #EFBAD3
  //
  // light:(bg white)
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
  //         // ···
          brightness: Brightness.light,
        ),

    primarySwatch: Colors.purple,
    primaryColor: Colors.purple,
    primaryColorDark: Colors.purple.shade800,
    primaryColorLight: Colors.purple.shade300,
    scaffoldBackgroundColor: Colors.white,
    // secondaryHeaderColor: Colors.purple.shade800,

    // cardColor: Colors.white70,
    // backgroundColor: Colors.white70,


    fontFamily: "SometypeMono",
    // textTheme: TextTheme()
  );
}


ButtonStyle filterButtonStyle(){
  return ElevatedButton.styleFrom(
  elevation: 2.0,
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(20),
  ),
  // backgroundColor: MyTheme().secondaryHeaderColor,
  );
}
