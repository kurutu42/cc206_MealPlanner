
import 'package:flutter/material.dart';
import 'package:cc206_mealplanner/features/login.dart';  

 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Planner App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginPage(), // Set WelcomePage as the starting screen
      // Define the routes here
      routes: {
        '/about': (context) => const LoginPage(), 
        
        
      }
    );
  }
}