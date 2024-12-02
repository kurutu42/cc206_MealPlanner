
import 'package:cc206_mealplanner/features/calendar.dart';
import 'package:cc206_mealplanner/features/create_meal.dart';
import 'package:cc206_mealplanner/features/homepage.dart';
import 'package:cc206_mealplanner/features/login.dart';
import 'package:cc206_mealplanner/features/profiledisplay.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart'; // For kIsWeb 

void main() {
  runApp(const CreateMealApp());
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required String userName});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static final _formKey = GlobalKey<FormState>(); // static form key shared across all instances
  static String? _name; // static name, shared across all instances
  static double? _weight;
  static double? _height;
  static String? _allergies;
  static String? _age;
  static File? _profileImage; // Static profile image, shared across all instances
  static Uint8List? _webImage; // Static web image, shared across all instances

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        final webImage = await pickedFile.readAsBytes();
        setState(() {
          _webImage = webImage;
        });
      } else {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      }
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Navigate to ProfileDisplayPage after saving the profile
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileDisplayPage(
            name: _name ?? '',
            weight: _weight ?? 0.0,
            height: _height ?? 0.0,
            allergies: _allergies ?? '',
            age: _age ?? '',
            profileImage: _profileImage ?? File('assets/default1.png'), // Default profile image
            webImage: _webImage, // Pass webImage for web platforms
          ),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
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
                  builder: (context) => const MealPlannerHomePage(userName: ''),
                ),
              );
            },
            child: const Text(
              'Home',
             
            ),
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
  child: const Text(
    'Profile',
  ),
),
          TextButton(
            onPressed: () {{Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MealPlanner(userName: ''),
                ),
              );
              };
              
              },
            child: const Text(
              'Create Meal',
             
            ),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EventCalendarScreen(userName: '',),
                ),
              );},
            child: const Text(
              'Calendar',
              
            ),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(userName: ''),
                ),
              );},
            child: const Text(
              'Logout',
              
              
            ),
          ),
          const SizedBox(width: 10),
          const CircleAvatar(backgroundImage: AssetImage('assets/img1.jpg')),
          const SizedBox(width: 30),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background2.jpg'),
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
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: _getProfileImage(),
                      child: (_profileImage == null && _webImage == null)
                          ? const Icon(
                              Icons.add_a_photo,
                              size: 50,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildInfoBox(
                          label: "Name",
                          initialValue: _name,
                          onSave: (value) => _name = value,
                          validator: (value) =>
                              value == null || value.isEmpty ? "Enter your name" : null,
                        ),
                        _buildInfoBox(
                          label: "Weight (kg)",
                          initialValue: _weight?.toString(),
                          onSave: (value) => _weight = double.tryParse(value!),
                          validator: (value) =>
                              value == null || value.isEmpty ? "Enter your weight" : null,
                        ),
                        _buildInfoBox(
                          label: "Height (cm)",
                          initialValue: _height?.toString(),
                          onSave: (value) => _height = double.tryParse(value!),
                          validator: (value) =>
                              value == null || value.isEmpty ? "Enter your height" : null,
                        ),
                        _buildInfoBox(
                          label: "Allergies",
                          initialValue: _allergies,
                          onSave: (value) => _allergies = value,
                        ),
                        _buildInfoBox(
                          label: "Age",
                          initialValue: _age,
                          onSave: (value) => _age = value,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _saveProfile,
                          child: const Text("Update Profile"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ImageProvider _getProfileImage() {
    if (kIsWeb && _webImage != null) {
      return MemoryImage(_webImage!);
    } else if (_profileImage != null) {
      return FileImage(_profileImage!);
    } else {
      return const AssetImage('assets/default1.png');
    }
  }

  Widget _buildInfoBox({
    required String label,
    required String? initialValue,
    required void Function(String?) onSave,
    String? Function(String?)? validator,
  }) {
    return Container(
      width: 450,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: TextFormField(
              initialValue: initialValue,
              decoration: const InputDecoration(border: InputBorder.none),
              onSaved: onSave,
              validator: validator,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
