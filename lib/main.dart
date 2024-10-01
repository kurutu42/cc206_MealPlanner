import 'package:flutter/material.dart';
import 'package:cc206_mealplanner/features/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity, 
      ),
      home: const SignUpPage(), // Use SignUpPage here
    );
  }
}
