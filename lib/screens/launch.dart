import 'dart:async';
import 'package:flutter/material.dart';
import 'package:demo/screens/login.dart';


class LaunchPage extends StatefulWidget {
  @override
  _LaunchPageState createState() => _LaunchPageState();
}
class _LaunchPageState extends State<LaunchPage> {
  @override
  initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                const LoginPage()
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
          child: SizedBox(
            height:100, width:100,
            child: Image.asset("assets/handasa_logo.png"),
          )
      ),
    );
  }
}