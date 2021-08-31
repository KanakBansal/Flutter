import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_expense_manager/screens/SplachScreen.dart';
import 'package:firebase_core/firebase_core.dart';

//String usesCleartextTraffic="true";

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  runApp(MaterialApp(
      title: "Expense Manager",
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.light(),
      //darkTheme: ThemeData.dark(),
      themeMode:ThemeMode.system,
      home: Splash()),
  );
}