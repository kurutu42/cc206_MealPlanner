import 'package:cc206_mealplanner/features/calendar.dart';
import 'package:cc206_mealplanner/features/create_meal.dart';
import 'package:cc206_mealplanner/features/login.dart';
import 'package:flutter/material.dart';
import 'package:cc206_mealplanner/features/profile.dart';
import 'package:cc206_mealplanner/features/viewmeal.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MealPlannerHomePage extends StatefulWidget {
   final String userName; // Add userName field
  const MealPlannerHomePage({Key? key, required this.userName}) : super(key: key); // Add constructor

  @override
  _MealPlannerHomePageState createState() => _MealPlannerHomePageState();
}

class _MealPlannerHomePageState extends State<MealPlannerHomePage> {
  int _currentIndex = 0;
  final List<String> _coverImages = [
    'assets/img1.jpg',
    'assets/img2.jpg',
    'assets/img3.jpg',
  ];
  bool _showFooter = false;
  final ScrollController _scrollController = ScrollController();
  late Future<List<Map<String, dynamic>>> recipesFuture;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _coverImages.length;
      });
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _showFooter = true;
        });
      } else {
        setState(() {
          _showFooter = false;
        });
      }
    });

    recipesFuture = fetchRecipes();
  }

  Future<List<Map<String, dynamic>>> fetchRecipes() async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/recipes'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['recipes']
          .map<Map<String, dynamic>>(
              (json) => json as Map<String, dynamic>)
          .toList();
    } else {
      throw Exception('Failed to fetch recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartPlates'),
        actions: [
        
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
                    builder: (context) => const ProfilePage(userName: '',),
                  ),
                );
              },
              child: const Text('Profile'),
            ),
          TextButton(onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MealPlanner(userName: '',),
                ),
              );}, child: const Text('Create Meal')),
          const SizedBox(width: 10),
          TextButton(onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EventCalendarScreen(userName: '',),
                ),
              );}, child: const Text('Calendar')),
          const SizedBox(width: 10),
          TextButton(onPressed: () {
            Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(userName: '',),
                  ),
                );

          }, child: const Text('Logout')),
          const SizedBox(width: 10),
          const CircleAvatar(backgroundImage: AssetImage('assets/img1.jpg')),
          const SizedBox(width: 30),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  _coverImages[_currentIndex],
                  width: double.infinity,
                  height: 400,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: double.infinity,
                  height: 400,
                  color: Colors.black.withOpacity(0.5),
                ),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      'MEAL PLANNER',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 52,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionTitle('Meals for the Day'),
                  mealCardRow([
                    mealCard('Breakfast', 'Main', 'Pancakes with strawberries'),
                    mealCard('Lunch', 'Staple', 'Burger'),
                    mealCard('Dinner', 'Main', 'Grilled Fish'),
                    mealCard('Dinner', 'Other', 'Cake'),
                  ]),
                  SizedBox(height: 40),
                  sectionTitle('Meals for the Week'),
                  mealCardRow(List.generate(
                      7,
                      (index) => mealCard('Day ${index + 1}',
                          'mealType','mealCategory'))),
                  SizedBox(height: 55),
                  Row(
                    children: [
                      Expanded(child: Image.asset('assets/img1.jpg')),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text(
                            'A good meal is not just food, it’s an experience.',
                            style: TextStyle(
                                fontSize: 50, fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  sectionTitle('Meal Recommendations'),
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: recipesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text('Failed to load recommendations'));
                      } else {
                        return recommendationCardRow(snapshot.data!
                            .map((meal) => recommendationCard(context, meal))
                            .toList());
                      }
                    },
                  ),
                  SizedBox(height: 200),
                  if (_showFooter)
                    Container(
                      color: Colors.grey[200],
                      height: 100,
                      child: Center(
                        child: Text(
                            '2024 SmartPlates. Artaba, Casamorin, Del Rio, Fadrigo, Janaban.'),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget mealCardRow(List<Widget> cards) {
    final ScrollController _cardScrollController = ScrollController();
    return Container(
      height: 350,
      child: Center(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _cardScrollController.animateTo(
                  _cardScrollController.offset - 500,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: _cardScrollController,
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return cards[index];
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                _cardScrollController.animateTo(
                  _cardScrollController.offset + 500,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget recommendationCardRow(List<Widget> cards) {
    final ScrollController _recommendationScrollController =
        ScrollController();
    return Container(
      height: 350,
      child: Center(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _recommendationScrollController.animateTo(
                  _recommendationScrollController.offset - 500,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: _recommendationScrollController,
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return cards[index];
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                _recommendationScrollController.animateTo(
                  _recommendationScrollController.offset + 500,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget mealCard(String mealType, String mealCategory, String dishName) { 
    return Container( 
      width: 350, 
      child: Card( 
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8), 
        child: Padding( 
          padding: const EdgeInsets.all(8.0), 
          child: Column( 
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [ 
              Text( 
                mealType, 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), 
                ), 
                Text(mealCategory, overflow: TextOverflow.ellipsis), 
                Text(dishName, overflow: TextOverflow.ellipsis), 
                Align( alignment: Alignment.centerRight, 
                ), 
              ], 
            ),
        ), 
      ), 
   );
  }

  Widget recommendationCard(BuildContext context, Map<String, dynamic> meal) { 
    return Container( 
      width: 350, 
      child: Card( 
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8), 
        child: Column( crossAxisAlignment: CrossAxisAlignment.center, 
        children: [
           meal['image'] != null 
           ? Image.network( 
            meal['image'], 
            width: 350, 
            height: 200, 
            fit: BoxFit.cover, 
            errorBuilder: (context, error, stackTrace) => Container( 
              color: Colors.grey[300], 
              width: 350, 
              height: 200, 
              child: Icon(Icons.broken_image, size: 40), 
              ), 
              ) 
              : Container( 
                color: Colors.grey[300], 
                width: 350, 
                height: 200, 
                child: Icon(Icons.fastfood, size: 40), 
                ), 
          Padding( 
            padding: const EdgeInsets.all(8.0), 
            child: Column( 
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [ 
                Text( 
                  meal['name'] ?? 'Unknown Meal', 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), 
                  maxLines: 1, 
                  overflow: TextOverflow.ellipsis, 
                  ), 
                  SizedBox(height: 4),
                  
                   Text( meal['cuisine'] ?? 'Cuisine: Not Specified', 
                   overflow: TextOverflow.ellipsis, 
                   style: TextStyle(color: Colors.grey[700]), 
                   ), 
                   SizedBox(height: 4),
                    Text( 'Tags: ${meal['tags']?.join(", ") ?? "None"}', 
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]), 
                    overflow: TextOverflow.ellipsis, 
                    ), 
                    SizedBox(height: 8),
                     Align( 
                      alignment: Alignment.centerRight, 
                      child: ElevatedButton( 
                        onPressed: () { 
                          showDialog( context: context, 
                          builder: (BuildContext context) { 
                            return ViewMeal(meal: meal); 
                            }, 
                          ); 
                        }, 
                        child: Text('View Meal'), 
                      ), 
                    ), 
                  ], 
                ), 
              ), 
            ], 
          ), 
        ), 
    );                        
  }


}
