import 'package:flutter/material.dart';
import 'package:help/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:help/Login.dart';
import 'package:help/SignUp.dart';
import 'package:help/Start.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.orange),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        "Login": (BuildContext context) => Login(),
        "SignUp": (BuildContext context) => SignUp(),
        "Start": (BuildContext context) => Start(),
      },
    );
  }
}
