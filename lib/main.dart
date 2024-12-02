
import 'package:cc206_mealplanner/features/homepage.dart';
import 'package:cc206_mealplanner/features/login.dart';
import 'package:flutter/material.dart';
 
 

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
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginPage(userName: '',), // Set LoginPage as the starting screen
      // Define the routes here
      routes: {
        '/homepage': (context) => const MealPlannerHomePage(userName: 'John Doe',), 
        '/about': (context) => const LoginPage(userName: '',), 
        
        
      }
    );
  }
}
