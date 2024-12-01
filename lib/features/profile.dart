import 'package:cc206_mealplanner/features/homepage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart'; // For kIsWeb

// Import your ProfileDisplay page
import 'package:cc206_mealplanner/features/profiledisplay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SmartPlates'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MealPlannerHomePage(userName: '',),
                  ),
                );
              },
              child: const Text('Home'),
            ),

            
             const SizedBox(width: 10),
            TextButton(onPressed: () {}, child: const Text('Profile')),
            const SizedBox(width: 10),
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
        body: const ProfilePage(),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  double? _weight;
  double? _height;
  String? _allergies;
  String? _age;
  File? _profileImage; // For non-web platforms
  Uint8List? _webImage; // For web platforms

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        // For web, use Uint8List
        final webImage = await pickedFile.readAsBytes();
        setState(() {
          _webImage = webImage;
        });
      } else {
        // For non-web, use File
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      }
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Navigate to the profile display page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileDisplayPage(
            name: _name ?? 'No Name Provided',
            weight: _weight ?? 0.0,
            height: _height ?? 0.0,
            allergies: _allergies ?? 'No allergies',
            age: _age ?? 'Not provided',
            profileImage: _profileImage, // Pass the File for non-web
            webImage: _webImage, // Pass the Uint8List for Web platforms
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
                child: Column(
                  children: [
                    // Profile Card
                    _buildProfileCard(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20), // Smaller padding
        child: Column(
          children: [
            // Profile Image
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50, // Smaller avatar size
                backgroundImage: _getProfileImage(),
                child: (_profileImage == null && _webImage == null)
                    ? const Icon(
                        Icons.add_a_photo,
                        size: 35, // Smaller icon
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 15), // Reduced height
            // Form Fields
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(
                    label: "Name",
                    onSave: (value) => _name = value,
                    validator: (value) =>
                        value == null || value.isEmpty ? "Enter your name" : null,
                  ),
                  const SizedBox(height: 12), // Reduced space between fields
                  _buildTextField(
                    label: "Weight (kg)",
                    keyboardType: TextInputType.number,
                    onSave: (value) => _weight = double.tryParse(value!),
                    validator: (value) =>
                        value == null || value.isEmpty ? "Enter your weight" : null,
                  ),
                  const SizedBox(height: 12), // Reduced space between fields
                  _buildTextField(
                    label: "Height (cm)",
                    keyboardType: TextInputType.number,
                    onSave: (value) => _height = double.tryParse(value!),
                    validator: (value) =>
                        value == null || value.isEmpty ? "Enter your height" : null,
                  ),
                  const SizedBox(height: 12), // Reduced space between fields
                  _buildTextField(
                    label: "Allergies",
                    onSave: (value) => _allergies = value,
                  ),
                  const SizedBox(height: 12), // Reduced space between fields
                  _buildTextField(
                    label: "Age",
                    keyboardType: TextInputType.number,
                    onSave: (value) => _age = value,
                  ),
                  const SizedBox(height: 20), // Reduced space before button
                  ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 12), // Smaller padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Update Profile",
                      style: TextStyle(fontSize: 16), // Smaller text size
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

  ImageProvider _getProfileImage() {
    if (kIsWeb && _webImage != null) {
      return MemoryImage(_webImage!); // Use web image for web platform
    } else if (_profileImage != null) {
      return FileImage(_profileImage!); // Use file for other platforms
    } else {
      return const AssetImage('assets/default1.png'); // Default image
    }
  }

  Widget _buildTextField({
    required String label,
    TextInputType keyboardType = TextInputType.text,
    required void Function(String?) onSave,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[100]?.withOpacity(0.9),
      ),
      keyboardType: keyboardType,
      onSaved: onSave,
      validator: validator,
    );
  }
}
