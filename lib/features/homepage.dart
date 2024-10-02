import 'package:flutter/material.dart';

class MealPlannerHomePage extends StatefulWidget {
  final String userName;

  const MealPlannerHomePage({super.key, required this.userName});

  @override
  _MealPlannerHomePageState createState() => _MealPlannerHomePageState();
}

class _MealPlannerHomePageState extends State<MealPlannerHomePage> {
  // Initialize meal plans for each day of the week
  final Map<String, Map<String, String>> _weeklyMealPlan = {
    'Monday': {'Breakfast': '', 'Lunch': '', 'Dinner': ''},
    'Tuesday': {'Breakfast': '', 'Lunch': '', 'Dinner': ''},
    'Wednesday': {'Breakfast': '', 'Lunch': '', 'Dinner': ''},
    'Thursday': {'Breakfast': '', 'Lunch': '', 'Dinner': ''},
    'Friday': {'Breakfast': '', 'Lunch': '', 'Dinner': ''},
    'Saturday': {'Breakfast': '', 'Lunch': '', 'Dinner': ''},
    'Sunday': {'Breakfast': '', 'Lunch': '', 'Dinner': ''},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meal Planner',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 211, 244, 212),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Message with the User's Name
            Text(
              'Welcome, ${widget.userName}',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            const SizedBox(height: 20),

            // Section title for weekly meal plan
            Text(
              'This Week\'s Meal Plan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.green[700],
              ),
            ),
            const SizedBox(height: 10),

            // Display meal plan cards in a grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                  childAspectRatio: 1.5,
                ),
                itemCount: 7,
                itemBuilder: (context, index) {
                  String day = _getDayOfWeek(index);
                  return MealCard(
                    day: day,
                    mealPlan: _weeklyMealPlan[day]!,
                    onMealPlanChanged: (newMealPlan) {
                      setState(() {
                        _weeklyMealPlan[day] = newMealPlan;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDayOfWeek(int index) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return days[index];
  }
}

class MealCard extends StatefulWidget {
  final String day;
  final Map<String, String> mealPlan;
  final ValueChanged<Map<String, String>> onMealPlanChanged;

  const MealCard({
    super.key,
    required this.day,
    required this.mealPlan,
    required this.onMealPlanChanged,
  });

  @override
  _MealCardState createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  // Create TextEditingControllers for each meal type
  late TextEditingController _breakfastController;
  late TextEditingController _lunchController;
  late TextEditingController _dinnerController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current meal plan values
    _breakfastController =
        TextEditingController(text: widget.mealPlan['Breakfast']);
    _lunchController = TextEditingController(text: widget.mealPlan['Lunch']);
    _dinnerController = TextEditingController(text: widget.mealPlan['Dinner']);
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is removed from the widget tree
    _breakfastController.dispose();
    _lunchController.dispose();
    _dinnerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display day name in bold and larger font
            Text(
              widget.day,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            const SizedBox(height: 25),

            // Input fields for Breakfast, Lunch, and Dinner
            _buildMealInput(context, 'Breakfast', _breakfastController),
            const SizedBox(height: 25),
            _buildMealInput(context, 'Lunch', _lunchController),
            const SizedBox(height: 25),
            _buildMealInput(context, 'Dinner', _dinnerController),
          ],
        ),
      ),
    );
  }

  // Helper method to build meal input fields
  Widget _buildMealInput(
      BuildContext context, String mealType, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Meal type label (Breakfast, Lunch, Dinner)
        Text(
          mealType,
          style: TextStyle(fontSize: 18, color: Colors.green[700]),
        ),
        // TextField for meal input
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter $mealType',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.green[700]!),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          onChanged: (value) {
            // Update the meal plan and notify the parent widget of the change
            widget.mealPlan[mealType] = value;
            widget.onMealPlanChanged(widget.mealPlan);
          },
        ),
      ],
    );
  }
}
