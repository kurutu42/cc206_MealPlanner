import 'package:cc206_mealplanner/features/homepage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data'; // For Uint8List support (Web)

class ProfileDisplayPage extends StatelessWidget {
  final String name;
  final double weight;
  final double height;
  final String allergies;
  final String age;
  final File? profileImage; // Image file for non-web platforms
  final Uint8List? webImage; // Image for web platforms

  const ProfileDisplayPage({
    super.key,
    required this.name,
    required this.weight,
    required this.height,
    required this.allergies,
    required this.age,
    this.profileImage, // Image for non-web platforms
    this.webImage, // Image for web platforms
  });

  // Static method for AppBar button actions (for example)
  static void navigateToHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MealPlannerHomePage(userName: ''),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Information'),
        actions: [
          // Using static method for navigation
          TextButton(
            onPressed: () => ProfileDisplayPage.navigateToHomePage(context),
            child: const Text('Home'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Profile'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Create Meal'),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {},
            child: const Text('Calendar'),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {},
            child: const Text('Logout'),
          ),
          const SizedBox(width: 10),
          const CircleAvatar(backgroundImage: AssetImage('assets/img1.jpg')),
          const SizedBox(width: 30),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background2.jpg'), // Background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Image Display
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: _getProfileImageStatic(profileImage, webImage),
                    child: (profileImage == null && webImage == null)
                        ? const Icon(
                            Icons.account_circle,
                            size: 50,
                            color: Colors.white,
                          )
                        : null,
                  ),
                  const SizedBox(height: 20),

                  // Info Boxes
                  _buildInfoBox("Name", name.isNotEmpty ? name : "No Name Provided"),
                  _buildInfoBox("Weight", "${weight.toStringAsFixed(1)} kg"),
                  _buildInfoBox("Height", "${height.toStringAsFixed(1)} cm"),
                  _buildInfoBox("Allergies", allergies.isNotEmpty ? allergies : "No allergies"),
                  _buildInfoBox("Age", age.isNotEmpty ? age : "Not provided"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Static helper method to get the correct image for profileImage or webImage.
  static ImageProvider _getProfileImageStatic(File? profileImage, Uint8List? webImage) {
    if (webImage != null) {
      return MemoryImage(webImage); // Use web image for web platform
    } else if (profileImage != null) {
      return FileImage(profileImage); // Use file for non-web platforms
    } else {
      return const AssetImage('assets/default1.png'); // Default image if no profile image
    }
  }

  // Helper method to create a display box for profile information.
  Widget _buildInfoBox(String label, String value) {
    return Container(
      width: 450, // Set a fixed width for the boxes
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8), // Semi-transparent background
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            offset: Offset(2, 2), // Shadow position
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Take minimum space
        mainAxisAlignment: MainAxisAlignment.center, // Center content
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 18, color: Colors.black),
              textAlign: TextAlign.center, // Center text
            ),
          ),
        ],
      ),
    );
  }
}

