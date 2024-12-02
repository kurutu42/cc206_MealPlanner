// shared_data.dart

import 'package:flutter/material.dart';

// Shared data for meals
class SharedData {
  static final Map<String, List<Map<String, String>>> meals = {
    'Breakfast': [],
    'Lunch': [],
    'Dinner': [],
  };

  static void addMeal(String mealType, String dishName, String dishType) {
    // Ensure the list for the given meal type exists
    meals.putIfAbsent(mealType, () => []);

    // Check if the mealType has fewer than 10 meals
    if (meals[mealType]!.length < 10) {
      meals[mealType]!.add({'name': dishName, 'type': dishType});
    } else {
      debugPrint('Cannot add more than 10 meals for $mealType');
    }
  }

  // Remove a meal from the specified meal type
  static void removeMeal(String mealType, String dishName) {
    meals[mealType]?.removeWhere((dish) => dish['name'] == dishName);
  }

  // Get meals for a specified meal type
  static List<Map<String, String>> getMeals(String mealType) {
    return meals[mealType] ?? [];
  }

  // Clear all meals
  static void clearAllMeals() {
    meals.forEach((key, value) => value.clear());
  }
}
