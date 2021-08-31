import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_expense_manager/screens/LandingScreen.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 2),
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LandingScreen())));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            'Expanse Manager App',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}