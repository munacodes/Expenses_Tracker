import 'package:expenses_tracker/home_screen.dart';
import 'package:expenses_tracker/screens/sign_up.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budget Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUpView(),
    );
  }
}
