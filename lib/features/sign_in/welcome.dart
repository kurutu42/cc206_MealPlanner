// ignore_for_file: must_be_immutable

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cc206_mealplanner/features/sign_in/components/my_button.dart';
import 'package:cc206_mealplanner/features/sign_in/components/my_textfield.dart';
import 'package:cc206_mealplanner/features/sign_in/components/square_tile.dart';
import 'package:cc206_mealplanner/features/sign_in/signup.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});

  // Text editing controllers
  final usernameController = TextEditingController();

  final double _sigmaX = 5; // Blur intensity for X
  final double _sigmaY = 5; // Blur intensity for Y
  final double _opacity = 0.2;
  final _formKey = GlobalKey<FormState>();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // Regex for email validation
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Full-screen background image
          Positioned.fill(
            child: Image.network(
              'https://thumbs.dreamstime.com/b/dumbells-tape-measure-healthy-food-fitness-health-over-wooden-background-view-above-47216017.jpg',
              fit: BoxFit.cover, // Ensures the image covers the entire screen
            ),
          ),

          // Main content
          SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.18),
                  const Text(
                    "Hi !",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 0, 0, 1)
                              .withOpacity(_opacity),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width * 0.85, // Adjusted width
                        child: Form(
                          key: _formKey,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Username textfield
                                MyTextField(
                                  controller: usernameController,
                                  hintText: 'Email',
                                  obscureText: false,
                                  validator: validateEmail,
                                ),
                                const SizedBox(height: 10),

                                // Sign-in button
                                MyButton(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Signup(),
                                        ),
                                      );
                                    } else {
                                      print('Form is not valid');
                                    }
                                  },
                                ),
                                const SizedBox(height: 10),

                                // Divider with text
                                Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        thickness: 0.5,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        'Or',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        thickness: 0.5,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),

                                // Social sign-in buttons
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      // Facebook button
                                      SquareTile(
                                        imagePath: 'assets/facebook.png',
                                        title: "Continue with Facebook",
                                      ),
                                      SizedBox(height: 10),

                                      // Google button
                                      SquareTile(
                                        imagePath: 'assets/google.png',
                                        title: "Continue with Google",
                                      ),
                                      SizedBox(height: 10),

                                      // Apple button
                                      SquareTile(
                                        imagePath: 'assets/apple.png',
                                        title: "Continue with Apple",
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),

                                // Sign-up and forgot password section
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Dont have an account?',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'Sign Up',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 71, 233, 133),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 71, 233, 133),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
