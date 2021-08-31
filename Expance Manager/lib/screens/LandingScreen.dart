import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_expense_manager/screens/DashboardScreen.dart';

import 'signup_screen.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.connectionState == ConnectionState.active ){
          final user = snapshot.data;
          if(user == null){
            return SignUpScreen(auth : _auth);
          }
          return DashboardScreen(auth : _auth);
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
