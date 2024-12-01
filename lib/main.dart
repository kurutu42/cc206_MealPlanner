import 'package:cc206_mealplanner/features/sign_in/welcome.dart';
import 'package:flutter/material.dart';
import 'package:cc206_mealplanner/features/sign_in/login.dart';  
import 'package:cc206_mealplanner/features/homepage.dart';    
 

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
      home: WelcomePage(), // Set LoginPage as the starting screen
      // Define the routes here
      routes: {
        '/homepage': (context) => const MealPlannerHomePage(userName: 'John Doe',), 
        '/about': (context) => LoginPage(), 
        
        
      }
    );
  }
}
