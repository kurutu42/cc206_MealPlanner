import 'package:cc206_mealplanner/features/calendar.dart';
import 'package:cc206_mealplanner/features/homepage.dart';
import 'package:cc206_mealplanner/features/login.dart';
import 'package:cc206_mealplanner/features/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

void main() {
  runApp(const CreateMealApp());
}

class CreateMealApp extends StatelessWidget {
  const CreateMealApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Plates',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 184, 255, 175),
      ),
      home: const MealPlanner(userName: ''),
      routes: {
        '/create_meal': (context) => const MealPlanner(userName: ''),
        '/calendar': (context) => const EventCalendarScreen(userName: '',),
      },
    );
  }
}

class MealPlanner extends StatefulWidget {
  const MealPlanner({super.key, required String userName});

  @override
  _MealPlannerState createState() => _MealPlannerState();
}

class _MealPlannerState extends State<MealPlanner> {
  static final List<Map<String, String>> breakfastItems = [];
  static final List<Map<String, String>> lunchItems = [];
  static final List<Map<String, String>> dinnerItems = [];

  static final TextEditingController _dishController = TextEditingController();
  String _selectedMealType = 'Main';
  String _selectedMeal = 'Breakfast';

  void _addDish(String dishName, String dishType) {
    if (dishName.trim().isEmpty) {
      _showErrorDialog('Please enter a dish name');
      return;
    }

    if (_isDishLimitReached()) {
      _showErrorDialog('The limit of 10 dishes has been reached for $_selectedMeal');
      return;
    }

    setState(() {
      if (_selectedMeal == 'Breakfast') {
        breakfastItems.add({'name': dishName, 'type': dishType});
      } else if (_selectedMeal == 'Lunch') {
        lunchItems.add({'name': dishName, 'type': dishType});
      } else if (_selectedMeal == 'Dinner') {
        dinnerItems.add({'name': dishName, 'type': dishType});
      }
    });

    _dishController.clear();
  }

  bool _isDishLimitReached() {
    if (_selectedMeal == 'Breakfast' && breakfastItems.length >= 10) {
      return true;
    } else if (_selectedMeal == 'Lunch' && lunchItems.length >= 10) {
      return true;
    } else if (_selectedMeal == 'Dinner' && dinnerItems.length >= 10) {
      return true;
    }
    return false;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('E, MMM d').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Meal'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MealPlannerHomePage(userName: ''),
                ),
              );
            },
            child: const Text('Home'),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(userName: '',),
                ),
              );
            },
            child: const Text('Profile'),
          ),
          const SizedBox(width: 10),
          TextButton(onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MealPlanner(userName: '',),
                ),
              );}, child: const Text('Create Meal')),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EventCalendarScreen(userName: '',),
                ),
              );
            },
            child: const Text('Calendar'),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(userName: ''),
                ),
              );
            },
            child: const Text('Logout'),
          ),
          const SizedBox(width: 10),
          const CircleAvatar(
            backgroundImage: AssetImage('assets/img1.jpg'),
          ),
          const SizedBox(width: 30),
        ],
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/food1.jpg', // Ensure this path matches your image asset
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity, // Make the container take up the full width
              constraints: BoxConstraints(
                maxWidth: 900, // Adjust the max width of the container
                maxHeight: MediaQuery.of(context).size.height * 0.9, // Use 90% of screen height
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container for the date
                  Container(
                    height: 30, // Adjust this height as needed
                    alignment: Alignment.center,
                    child: Text(
                      formattedDate,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, // Make the date bold
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Container for the "Breakfast, Lunch, Dinner" buttons
                  Container(
                    height: 50, // Adjust this height as needed
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildMealButton('Breakfast', _selectedMeal == 'Breakfast'),
                        _buildMealButton('Lunch', _selectedMeal == 'Lunch'),
                        _buildMealButton('Dinner', _selectedMeal == 'Dinner'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Dish list container
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        // Center content within the container
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Center the "Dishes" title
                            const Text(
                              'Dishes',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center, // Center-align the text
                            ),
                            const SizedBox(height: 10),
                            if (_getCurrentMealItems().isEmpty)
                              // Center the "There is no menu" message
                              const Text(
                                'There is no menu',
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                            if (_getCurrentMealItems().isNotEmpty)
                              Expanded(
                                child: ListView.builder(
                                  itemCount: _getCurrentMealItems().length,
                                  itemBuilder: (context, index) {
                                    return _buildMealItems(_getCurrentMealItems())[index];
                                  },
                                  physics: const AlwaysScrollableScrollPhysics(), // Make the list scrollable
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Add dish controls
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: ['Staple', 'Main', 'Side', 'Soup', 'Other']
                              .map((String value) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _selectedMealType == value
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _selectedMealType = value;
                                  });
                                },
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                        ),
                        TextField(
                          controller: _dishController,
                          decoration: const InputDecoration(
                            labelText: 'Enter dish name',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _addDish(_dishController.text, _selectedMealType);
                          },
                          child: const Text('Add Dish'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, String>> _getCurrentMealItems() {
    if (_selectedMeal == 'Breakfast') {
      return breakfastItems;
    } else if (_selectedMeal == 'Lunch') {
      return lunchItems;
    } else if (_selectedMeal == 'Dinner') {
      return dinnerItems;
    }
    return [];
  }

  List<Widget> _buildMealItems(List<Map<String, String>> items) {
    return items.map((item) {
      return ListTile(
        title: Text(item['name']!),
        subtitle: Text(item['type']!),
      );
    }).toList();
  }

  Widget _buildMealButton(String mealType, bool isSelected) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedMeal = mealType;
        });
      },
      child: Text(
        mealType,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.green : Colors.grey,
      ),
    );
  }
}
