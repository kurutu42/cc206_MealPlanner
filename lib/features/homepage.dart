import 'package:flutter/material.dart';
import 'package:cc206_mealplanner/features/profile.dart';

void main() {
  runApp(const MyApp());
}

class MealPlannerHomePage extends StatefulWidget {
  final String userName;

  const MealPlannerHomePage({super.key, required this.userName});

  @override
  _MealPlannerHomePageState createState() => _MealPlannerHomePageState();
}

class _MealPlannerHomePageState extends State<MealPlannerHomePage> {
  final Map<String, Map<String, String>> _weeklyMealPlan = {
    'Monday': {'Breakfast': '', 'Lunch': '', 'Dinner': ''},
    'Tuesday': {'Breakfast': '', 'Lunch': '', 'Dinner': ''},
    'Wednesday': {'Breakfast': '', 'Lunch': '', 'Dinner': ''},
    'Thursday': {'Breakfast': '', 'Lunch': '', 'Dinner': ''},
    'Friday': {'Breakfast': '', 'Lunch': '', 'Dinner': ''},
    'Saturday': {'Breakfast': '', 'Lunch': '', 'Dinner': ''},
    'Sunday': {'Breakfast': '', 'Lunch': '', 'Dinner': ''},
  };

  final List<String> _images = [
    'mealPlanner1.png',
    'mealPlanner2.png'
  ];

  int _currentImageIndex = 0;

  void _changeImage() {
    setState(() {
      _currentImageIndex = (_currentImageIndex + 1) % _images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartPlates'),
        actions: [
          TextButton(onPressed: () {}, child: const Text('Home')),
          const SizedBox(width: 10),
          TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        // ignore: prefer_const_constructors
        builder: (context) => MealPlannerHomePage(userName: ""), // Pass the required userName
      ),
    );
  },
  child: const Text('Home'),
),

          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              child: const Text('Profile'),
            ),
          TextButton(onPressed: () {}, child: const Text('Create Meal')),
          const SizedBox(width: 10),
          TextButton(onPressed: () {}, child: const Text('Calendar')),
          const SizedBox(width: 10),
          TextButton(onPressed: () {}, child: const Text('Logout')),
          const SizedBox(width: 10),
          const CircleAvatar(backgroundImage: AssetImage('assets/img1.jpg')),
          const SizedBox(width: 30),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, ${widget.userName}',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'This Week\'s Meal Plan',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.green[700],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      _images[_currentImageIndex],
                      width: 1500,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _changeImage,
                      child: const Text("Change Image"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
            ],
          ),
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
  late TextEditingController _breakfastController;
  late TextEditingController _lunchController;
  late TextEditingController _dinnerController;

  @override
  void initState() {
    super.initState();

    _breakfastController =
        TextEditingController(text: widget.mealPlan['Breakfast']);
    _lunchController = TextEditingController(text: widget.mealPlan['Lunch']);
    _dinnerController = TextEditingController(text: widget.mealPlan['Dinner']);
  }

  @override
  void dispose() {
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
            Text(
              widget.day,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            const SizedBox(height: 25),
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

  Widget _buildMealInput(
      BuildContext context, String mealType, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mealType,
          style: TextStyle(fontSize: 18, color: Colors.green[700]),
        ),
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
            widget.mealPlan[mealType] = value;
            widget.onMealPlanChanged(widget.mealPlan);
          },
        ),
      ],
    );
  }
}
