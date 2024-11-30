import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'dart:io';


void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MyApp(), // Wrap your app
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ignore: deprecated_member_use
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
  }
}

class ProfileDisplayPage extends StatelessWidget {
  final String name;
  final double weight;
  final double height;
  final String allergies;
  final String age;
  final File? profileImage;

  const ProfileDisplayPage({
    super.key,
    required this.name,
    required this.weight,
    required this.height,
    required this.allergies,
    required this.age,
    this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Information'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background2.jpg'), // Set your background image here
            fit: BoxFit.cover, // Cover the entire screen
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
                    radius: 50,
                    backgroundImage: profileImage != null ? FileImage(profileImage!) : const AssetImage('assets/default1.png'), // Default image
                    child: profileImage == null ? const Icon(Icons.account_circle, size: 50) : null,
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

  /// Helper method to create a display box for profile information.
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
        mainAxisSize: MainAxisSize.min, // Make the row take minimum space
        mainAxisAlignment: MainAxisAlignment.center, // Center the content horizontally
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black), // Change text color for visibility
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 18, color: Colors.black), // Change text color for visibility
              textAlign: TextAlign.center, // Center the text
            ),
          ),
        ],
      ),
    );
  }
}