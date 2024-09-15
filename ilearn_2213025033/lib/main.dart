import 'package:flutter/material.dart';
import 'login.dart'; // Importing the login page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(), // Launching the login page
    );
  }
}
