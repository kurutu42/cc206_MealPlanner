import 'package:create_meal/features/create_meal.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Plates',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 184, 255, 175),
      ),
      home: const EventCalendarScreen(),
      routes: {
        '/calendar': (context) => const EventCalendarScreen(),
      },
    );
  }
}

// Event class to store meal information
class Event {
   final String mealType; // breakfast, lunch, or dinner
   final String dishName;

  Event({required this.mealType, required this.dishName});
}

class EventCalendarScreen extends StatefulWidget {
  const EventCalendarScreen({super.key});

  @override
  _EventCalendarScreenState createState() => _EventCalendarScreenState();
}

class _EventCalendarScreenState extends State<EventCalendarScreen> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Use a map to store events by date and meal type
  final Map<DateTime, Map<String, List<String>>> _events = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents =
        ValueNotifier<List<Event>>(_getEventsForDay(_selectedDay!));

    // Add initial meals to the selected day if not already present
    _initializeMealsForDifferentDays();

    _selectedEvents.value = _getEventsForDay(_selectedDay!);
  }

  // Method to initialize different meals for different dates
  void _initializeMealsForDifferentDays() {
  final date1 = DateTime.utc(2024, 12, 1); // Dec 1, 2024
  final date2 = DateTime.utc(2024, 12, 2); // Dec 2, 2024
  final date3 = DateTime.utc(2024, 12, 3); // Dec 3, 2024
  final date4 = DateTime.utc(2024, 12, 4); // Dec 4, 2024
  final date5 = DateTime.utc(2024, 12, 5); // Dec 5, 2024
  final date6 = DateTime.utc(2024, 12, 6); // Dec 6, 2024
  final date7 = DateTime.utc(2024, 12, 7); // Dec 7, 2024
  final date8 = DateTime.utc(2024, 12, 8); // Dec 8, 2024
  final date9 = DateTime.utc(2024, 12, 9); // Dec 9, 2024
  final date10 = DateTime.utc(2024, 12, 10); // Dec 10, 2024
  final date11 = DateTime.utc(2024, 12, 11); // Dec 11, 2024
  final date12 = DateTime.utc(2024, 12, 12); // Dec 12, 2024
  final date13 = DateTime.utc(2024, 12, 13); // Dec 13, 2024
  final date14 = DateTime.utc(2024, 12, 14); // Dec 14, 2024
  final date15 = DateTime.utc(2024, 12, 15); // Dec 15, 2024
  final date16 = DateTime.utc(2024, 12, 16); // Dec 16, 2024
  final date17 = DateTime.utc(2024, 12, 17); // Dec 17, 2024
  final date18 = DateTime.utc(2024, 12, 18); // Dec 18, 2024
  final date19 = DateTime.utc(2024, 12, 19); // Dec 19, 2024
  final date20 = DateTime.utc(2024, 12, 20); // Dec 20, 2024
  final date21 = DateTime.utc(2024, 12, 21); // Dec 21, 2024
  final date22 = DateTime.utc(2024, 12, 22); // Dec 22, 2024
  final date23 = DateTime.utc(2024, 12, 23); // Dec 23, 2024
  final date24 = DateTime.utc(2024, 12, 24); // Dec 24, 2024
  final date25 = DateTime.utc(2024, 12, 25); // Dec 25, 2024
  final date26 = DateTime.utc(2024, 12, 26); // Dec 26, 2024
  final date27 = DateTime.utc(2024, 12, 27); // Dec 27, 2024
  final date28 = DateTime.utc(2024, 12, 28); // Dec 28, 2024
  final date29 = DateTime.utc(2024, 12, 29); // Dec 29, 2024
  final date30 = DateTime.utc(2024, 12, 30); // Dec 30, 2024
  final date31 = DateTime.utc(2024, 12, 31); // Dec 31, 2024

  _events[date1] = {
    'Breakfast': ['Pancakes', 'Omelette'],
    'Lunch': ['Chicken Salad', 'Grilled Sandwich'],
    'Dinner': ['Spaghetti', 'Grilled Chicken'],
  };
  _events[date2] = {
    'Breakfast': ['Bagel', 'Avocado Toast'],
    'Lunch': ['Veggie Burger', 'Quinoa Salad'],
    'Dinner': ['Sushi', 'Ramen'],
  };
  _events[date3] = {
    'Breakfast': ['French Toast', 'Scrambled Eggs'],
    'Lunch': ['Caesar Salad', 'Tuna Sandwich'],
    'Dinner': ['Pizza', 'Garlic Bread'],
  };
  _events[date4] = {
    'Breakfast': ['Croissant', 'Fruit Salad'],
    'Lunch': ['Grilled Cheese', 'Tomato Soup'],
    'Dinner': ['Chicken Alfredo', 'Steamed Vegetables'],
  };
  _events[date5] = {
    'Breakfast': ['Cereal', 'Yogurt with Granola'],
    'Lunch': ['Chicken Wrap', 'Vegetable Stir-Fry'],
    'Dinner': ['Steak', 'Baked Potatoes'],
  };
  _events[date6] = {
    'Breakfast': ['Smoothie Bowl', 'Toast with Jam'],
    'Lunch': ['Pasta Salad', 'Chicken Sandwich'],
    'Dinner': ['Salmon', 'Asparagus'],
  };
  _events[date7] = {
    'Breakfast': ['Oatmeal', 'Poached Eggs'],
    'Lunch': ['BLT Sandwich', 'Greek Salad'],
    'Dinner': ['Beef Stir Fry', 'Rice'],
  };
  _events[date8] = {
    'Breakfast': ['Pancakes with Syrup', 'Bacon'],
    'Lunch': ['Grilled Shrimp', 'Avocado Salad'],
    'Dinner': ['Lasagna', 'Garlic Bread'],
  };
  _events[date9] = {
    'Breakfast': ['Breakfast Burrito', 'Scrambled Tofu'],
    'Lunch': ['Veggie Wrap', 'Chickpea Salad'],
    'Dinner': ['Vegetable Curry', 'Rice'],
  };
  _events[date10] = {
    'Breakfast': ['Waffles', 'Smoothie'],
    'Lunch': ['Chicken Caesar Salad', 'Quiche'],
    'Dinner': ['Fish Tacos', 'Coleslaw'],
  };
  _events[date11] = {
    'Breakfast': ['Toast with Peanut Butter', 'Banana Smoothie'],
    'Lunch': ['Chicken Soup', 'Grilled Cheese'],
    'Dinner': ['Pork Chops', 'Mashed Potatoes'],
  };
  _events[date12] = {
    'Breakfast': ['Egg Sandwich', 'Fruit Smoothie'],
    'Lunch': ['Beef Tacos', 'Rice and Beans'],
    'Dinner': ['Chicken Parmesan', 'Pasta'],
  };
  _events[date13] = {
    'Breakfast': ['Scrambled Eggs with Spinach', 'Toast'],
    'Lunch': ['Hummus and Pita', 'Greek Salad'],
    'Dinner': ['Mushroom Risotto', 'Green Beans'],
  };
  _events[date14] = {
    'Breakfast': ['Pancakes', 'Fruit Salad'],
    'Lunch': ['Chicken Salad', 'Avocado Toast'],
    'Dinner': ['Steak', 'Baked Potatoes'],
  };
  _events[date15] = {
    'Breakfast': ['Bagel with Cream Cheese', 'Fruit Parfait'],
    'Lunch': ['Turkey Sandwich', 'Coleslaw'],
    'Dinner': ['Pasta Primavera', 'Garlic Bread'],
  };
  _events[date16] = {
    'Breakfast': ['Yogurt with Berries', 'Toast with Avocado'],
    'Lunch': ['Grilled Chicken', 'Caesar Salad'],
    'Dinner': ['Beef Stew', 'Mashed Potatoes'],
  };
  _events[date17] = {
    'Breakfast': ['Omelette', 'Hash Browns'],
    'Lunch': ['Pasta Salad', 'Vegetable Wrap'],
    'Dinner': ['Grilled Fish', 'Roasted Vegetables'],
  };
  _events[date18] = {
    'Breakfast': ['Fruit Smoothie', 'Toast with Jam'],
    'Lunch': ['Chicken Quesadilla', 'Guacamole'],
    'Dinner': ['Baked Ziti', 'Garlic Bread'],
  };
  _events[date19] = {
    'Breakfast': ['Muffins', 'Coffee'],
    'Lunch': ['Caprese Salad', 'Tomato Soup'],
    'Dinner': ['Grilled Shrimp', 'Steamed Rice'],
  };
  _events[date20] = {
    'Breakfast': ['French Toast', 'Cappuccino'],
    'Lunch': ['Tuna Salad', 'Bagel'],
    'Dinner': ['Chicken Stir Fry', 'Rice'],
  };
  _events[date21] = {
    'Breakfast': ['Avocado Toast', 'Poached Eggs'],
    'Lunch': ['Chicken Wrap', 'Greek Salad'],
    'Dinner': ['Vegetable Stir Fry', 'Rice'],
  };
  _events[date22] = {
    'Breakfast': ['Eggs Benedict', 'Hash Browns'],
    'Lunch': ['Chicken Quesadilla', 'Corn Salad'],
    'Dinner': ['Beef Wellington', 'Roasted Vegetables'],
  };
  _events[date23] = {
    'Breakfast': ['Cereal', 'Fruit Smoothie'],
    'Lunch': ['Chicken Burger', 'Sweet Potato Fries'],
    'Dinner': ['Lamb Chops', 'Steamed Broccoli'],
  };
  _events[date24] = {
    'Breakfast': ['Pancakes', 'Cinnamon Rolls'],
    'Lunch': ['Vegetable Soup', 'Grilled Cheese'],
    'Dinner': ['Turkey', 'Stuffing'],
  };
  _events[date25] = {
    'Breakfast': ['Eggs and Bacon', 'Toast'],
    'Lunch': ['Roast Beef', 'Mashed Potatoes'],
    'Dinner': ['Chicken and Rice', 'Salad'],
  };
  _events[date26] = {
    'Breakfast': ['Cereal', 'Oatmeal'],
    'Lunch': ['Pasta Salad', 'Tomato Sandwich'],
    'Dinner': ['Grilled Chicken', 'Steamed Vegetables'],
  };
  _events[date27] = {
    'Breakfast': ['Pancakes', 'Fruit Salad'],
    'Lunch': ['Vegetable Wrap', 'Hummus'],
    'Dinner': ['Salmon', 'Asparagus'],
  };
  _events[date28] = {
    'Breakfast': ['Toast with Avocado', 'Yogurt'],
    'Lunch': ['Vegetarian Pizza', 'Side Salad'],
    'Dinner': ['Beef Stir Fry', 'Rice'],
  };
  _events[date29] = {
    'Breakfast': ['Egg Muffins', 'Smoothie'],
    'Lunch': ['Chicken Caesar Salad', 'Tomato Soup'],
    'Dinner': ['Baked Ziti', 'Garlic Bread'],
  };
  _events[date30] = {
    'Breakfast': ['Oatmeal', 'Fresh Fruit'],
    'Lunch': ['BLT Sandwich', 'Cucumber Salad'],
    'Dinner': ['Chicken Tacos', 'Rice'],
  };
  _events[date31] = {
    'Breakfast': ['Waffles', 'Fruit Parfait'],
    'Lunch': ['Vegetable Wrap', 'Lentil Soup'],
    'Dinner': ['Steak', 'Grilled Vegetables'],
  };
}


  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    List<Event> eventsForDay = [];
    if (_events[day] != null) {
      _events[day]!.forEach((mealType, dishes) {
        for (var dish in dishes) {
          eventsForDay.add(Event(mealType: mealType, dishName: dish));
        }
      });
    }
    return eventsForDay;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _addEvent(String mealType, String dishName) {
    if (_selectedDay == null || dishName.isEmpty || mealType.isEmpty) return;

    setState(() {
      // Ensure the selected day exists in the _events map
      if (!_events.containsKey(_selectedDay!)) {
        _events[_selectedDay!] = {
          'Breakfast': [],
          'Lunch': [],
          'Dinner': [],
        };
      }

      // Ensure the meal type exists, and then add the dish name to the corresponding meal list
      if (_events[_selectedDay!]?[mealType] == null) {
        _events[_selectedDay!]?[mealType] = [];
      }

      _events[_selectedDay!]?[mealType]?.add(dishName);

      // Update the selected events for the day
      _selectedEvents.value = _getEventsForDay(_selectedDay!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Calendar'),
        actions: [
          TextButton(onPressed: () {}, child: const Text('Home')),
          const SizedBox(width: 10),
          TextButton(onPressed: () {}, child: const Text('Profile')),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MealPlanner()),
              ).then((result) {
                if (result != null) {
                  final mealType = result['mealType'];
                  final dishName = result['dishName'];
                  _addEvent(mealType, dishName);
                }
              });
            },
            child: const Text('Create Meal'),
          ),
          TextButton(onPressed: () {}, child: const Text('Calendar')),
          const SizedBox(width: 10),
          TextButton(onPressed: () {}, child: const Text('Logout')),
          const SizedBox(width: 10),
          const CircleAvatar(
              backgroundImage: AssetImage('lib/assets/img1.jpg')),
          const SizedBox(width: 30),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/calendar.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: Colors.white10, width: 1.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(2, 2),
                      blurRadius: 8.0,
                    ),
                  ],
                ),
                child: TableCalendar(
                  firstDay: DateTime.utc(2000, 1, 1),
                  lastDay: DateTime.utc(2100, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: _onDaySelected,
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    todayDecoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.red[300],
                      shape: BoxShape.circle,
                    ),
                  ),
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _mealPlanBox("Breakfast"),
                    _mealPlanBox("Lunch"),
                    _mealPlanBox("Dinner"),
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MealPlanner()),
                        );
                      },
                      child: const Icon(Icons.add),
                      backgroundColor: Colors.red[200],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mealPlanBox(String label) {
    return Expanded(
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 200,
          maxHeight: 225,
        ),
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.white10, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(2, 2),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.red[200],
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, events, _) {
                  final mealsForDay = events
                      .where((event) => event.mealType == label)
                      .map((event) => event.dishName)
                      .join(', ');
                  return Text(mealsForDay.isEmpty ? 'No meals' : mealsForDay);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
