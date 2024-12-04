import 'package:flutter/material.dart';

class ViewMeal extends StatelessWidget {
  final Map<String, dynamic> meal;

  ViewMeal({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.55,
        //height: MediaQuery.of(context).size.height * 0.95,  // Make the pop-up responsive
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Close button
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side: Meal image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      meal['image'],
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.width * 0.2,
                      //height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  // Right side: Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Meal Name
                        Text(
                          meal['name'],
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        // Cuisine Tags
                        Wrap( 
                          spacing: 8.0, 
                          runSpacing: 4.0, 
                          children: [ 
                            Chip( 
                              label: Text(meal['cuisine']), 
                              backgroundColor: _getTagColor(meal['cuisine']), 
                              ), 
                              ...meal['tags'].map<Widget>((tag) { 
                                return Chip( label: Text(tag), 
                                backgroundColor: _getTagColor(tag), 
                                ); 
                                }).toList(), 
                                ], 
                                ), 
                                SizedBox(height: 16),
                        // Ingredients
                        Text(
                          'Ingredients',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        ...meal['ingredients'].map<Widget>((ingredient) {
                          return Text('• $ingredient', style: TextStyle(fontSize: 16));
                        }).toList(),
                        SizedBox(height: 16),
                        // Calories and Meal Type
                        Text(
                          'Calories: ${meal['calories']}',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Meal Type: ${meal['mealType']}',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Instructions
              Text(
                'Instructions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align instructions to the right
                  children: meal['instructions'].map<Widget>((instruction) {
                    return Text('• $instruction', style: TextStyle(fontSize: 16));
                  }).toList(),
                ),
              ),
              SizedBox(height: 16),
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //TextButton(
                   // onPressed: () => Navigator.pop(context),
                   // child: Text('Close'),
                 // ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Add meal to the user's plan
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Meal added to your plan!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('+ Add Meal'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to assign colors to tags
  Color _getTagColor(String tag) {
    switch (tag.toLowerCase()) {
      case 'asian':
        return Colors.red;
      case 'mediterranean':
        return Colors.orange;
      case 'pakistani':
        return Colors.purple;
      case 'italian':
        return Colors.green;
      case 'mexican':
        return Colors.amber;
      case 'american':
        return Colors.blue;
      case 'japanese':
        return Colors.teal;
      case 'moroccan':
        return Colors.indigo;
      case 'greek':
        return Colors.cyan;
      case 'korean':
        return Colors.pink;
      case 'thai':
        return Colors.yellow;
      case 'indian':
        return Colors.lightGreen;
      case 'turkish':
        return Colors.deepOrange;
      case 'russian':
        return Colors.deepPurple;
      case 'lebanese':
        return Colors.limeAccent;
      case 'brazilian':
        return Colors.lightGreenAccent;
      default:
        return Colors.grey;
    }
  }
}
