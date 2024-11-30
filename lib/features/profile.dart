// ignore_for_file: prefer_const_constructors

import 'package:cc206_mealplanner/features/profiledisplay.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:device_preview/device_preview.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
  !kReleaseMode;
    (context) => MyApp();
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Planner',
       // ignore: deprecated_member_use
       useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProfilePage(),
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
  File? _profileImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      setState(() {
        try {
          _profileImage = File(pickedFile.path);
        } catch (e) {
          print("Error loading image: $e");
        }
      });
    } else {
      print("No image selected.");
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Ensure that the values being passed are not null
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileDisplayPage(
            name: _name ?? 'No Name Provided',
            weight: _weight ?? 0.0,
            height: _height ?? 0.0,
            allergies: _allergies ?? 'No allergies',
            age: _age ?? 'Not provided',
            profileImage: _profileImage ?? File('default_image_path.png'),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Form or Display Information
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey, // Pass the form key here
                child: _buildProfileForm(), // Call the form builder method
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build Profile Form
  Widget _buildProfileForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,  // Align items to the start (left)
      children: [
        // Align the profile image to the left
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: _profileImage != null
                  ? FileImage(_profileImage!)
                  : const AssetImage('assets/default1.png'), // Default image
              child: _profileImage == null
                  ? const Icon(
                      Icons.add_a_photo,
                      size: 50,
                    )
                  : null,
            ),
          ),
        ),
        const SizedBox(height: 20),
        
        // Name Field - Left aligned
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 250, // Set a fixed width for the TextFormField
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Name",
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white.withOpacity(0.8),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your name.";
                }
                return null;
              },
              onSaved: (value) {
                _name = value;
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        
        // Weight Field - Left aligned
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 250,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Weight (kg)",
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white.withOpacity(0.8),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your weight.";
                }
                return null;
              },
              onSaved: (value) {
                _weight = double.tryParse(value!);
              },
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Height Field - Left aligned
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 250,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Height (cm)",
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white.withOpacity(0.8),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your height.";
                }
                return null;
              },
              onSaved: (value) {
                _height = double.tryParse(value!);
              },
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Allergies Field - Left aligned
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 400,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Allergies",
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white.withOpacity(0.8),
              ),
              onSaved: (value) {
                _allergies = value;
              },
            ),
          ),
        ),
        const SizedBox(height: 20),

        // age Me Field - Left aligned
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 70,
            height: 200, // Reduce height to make the form more compact
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Age",
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white.withOpacity(0.8),
              ),
              onSaved: (value) {
                _age = value;
              },
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Save Button - Left aligned
        Align(
          alignment: Alignment.centerLeft,
          child: ElevatedButton(
            onPressed: _saveProfile,
            child: const Text("Save Profile"),
          ),
        ),
      ],
    );
  }
}