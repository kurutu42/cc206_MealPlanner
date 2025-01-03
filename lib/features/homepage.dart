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
   final String userName; 
  const MealPlannerHomePage({super.key, required this.userName});

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
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
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

  //API
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
        //Navigation Bar
          TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MealPlannerHomePage(userName: ""), 
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
      //Cover Image
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
                const Positioned.fill(
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
            //Meal Cards
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
                  const SizedBox(height: 40),
                  sectionTitle('Meals for the Week'),
                  mealCardRow(List.generate(
                      7,
                      (index) => mealCard('Day ${index + 1}',
                          'mealType','mealCategory'))),
                  const SizedBox(height: 55),
                  //Half-Image, Half-Text
                  Row(
                    children: [
                      Expanded(child: Image.asset('assets/img1.jpg')),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Text(
                            'A good meal is not just food, it’s an experience.',
                            style: TextStyle(
                                fontSize: 50, fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Meal Recommendation using API
                  const SizedBox(height: 50),
                  sectionTitle('Meal Recommendations'),
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: recipesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text('Failed to load recommendations'));
                      } else {
                        return recommendationCardRow(snapshot.data!
                            .map((meal) => recommendationCard(context, meal))
                            .toList());
                      }
                    },
                  ),
                  //Footer
                  const SizedBox(height: 200),
                  if (_showFooter)
                    Container(
                      color: Colors.grey[200],
                      height: 100,
                      child: const Center(
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
  //Section Titles
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
//Meal Cards
  Widget mealCardRow(List<Widget> cards) {
    final ScrollController _cardScrollController = ScrollController();
    return Container(
      height: 350,
      child: Center(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                _cardScrollController.animateTo(
                  _cardScrollController.offset - 500,
                  duration: const Duration(milliseconds: 300),
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
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                _cardScrollController.animateTo(
                  _cardScrollController.offset + 500,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

//Meal Card Recommendation
  Widget recommendationCardRow(List<Widget> cards) {
    final ScrollController _recommendationScrollController =
        ScrollController();
    return Container(
      height: 350,
      child: Center(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                _recommendationScrollController.animateTo(
                  _recommendationScrollController.offset - 500,
                  duration: const Duration(milliseconds: 300),
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
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                _recommendationScrollController.animateTo(
                  _recommendationScrollController.offset + 500,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
//Meal Card
  Widget mealCard(String mealType, String mealCategory, String dishName) { 
    return Container( 
      width: 350, 
      child: Card( 
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8), 
        child: Padding( 
          padding: const EdgeInsets.all(8.0), 
          child: Column( 
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [ 
              Text( 
                mealType, 
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), 
                ), 
                Text(mealCategory, overflow: TextOverflow.ellipsis), 
                Text(dishName, overflow: TextOverflow.ellipsis), 
                const Align( alignment: Alignment.centerRight, 
                ), 
              ], 
            ),
        ), 
      ), 
   );
  }
// Meal Card Recommendation
  Widget recommendationCard(BuildContext context, Map<String, dynamic> meal) { 
    return Container( 
      width: 350, 
      child: Card( 
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8), 
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
              child: const Icon(Icons.broken_image, size: 40), 
              ), 
            ) 
              : Container( 
                color: Colors.grey[300], 
                width: 350, 
                height: 200, 
                child: const Icon(Icons.fastfood, size: 40), 
                ), 
          Padding( 
            padding: const EdgeInsets.all(8.0), 
            child: Column( 
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [ 
                Text( 
                  meal['name'] ?? 'Unknown Meal', 
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), 
                  maxLines: 1, 
                  overflow: TextOverflow.ellipsis, 
                  ), 
                  const SizedBox(height: 4),
                  
                   Text( meal['cuisine'] ?? 'Cuisine: Not Specified', 
                   overflow: TextOverflow.ellipsis, 
                   style: TextStyle(color: Colors.grey[700]), 
                   ), 
                   const SizedBox(height: 4),
                    Text( 'Tags: ${meal['tags']?.join(", ") ?? "None"}', 
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]), 
                    overflow: TextOverflow.ellipsis, 
                    ), 
                    //Recommendation Card, View Meal Pop-up
                    const SizedBox(height: 8),
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
                        child: const Text('View Meal'), 
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
