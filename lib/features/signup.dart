import 'package:flutter/material.dart';
import 'package:cc206_mealplanner/features/login.dart'; 

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background1.png'), // Use the asset image
              fit: BoxFit.cover, // Make sure the image covers the entire screen
            ),
          ),
          margin: const EdgeInsets.all(24),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8), // Light background to improve readability
                borderRadius: BorderRadius.circular(20), // Rounded corners for the container
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 8,
                  ),
                ], // Adds shadow to the container
              ),
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 400, maxHeight: 550), // Limit width for aesthetic layout
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _header(),
                  _inputField(),
                  _login(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

 Widget _header() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 45.0), // Adjust the vertical padding as needed
    child: Align(
      alignment: Alignment.topCenter, // Aligns the content to the top center
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Center the text horizontally
        children: [
          Text(
            "Create Account",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          SizedBox(height: 5.0), // Adjust the height as needed for spacing
          Text(
            "Enter your credentials to Sign Up",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ],
      ),
    ),
  );
}

  Widget _inputField() {
    return Center(
      child: Container(
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: "Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.white.withOpacity(0.7),
                  filled: true,
                  prefixIcon: const Icon(Icons.person),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Username is required" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.white.withOpacity(0.7),
                  filled: true,
                  prefixIcon: const Icon(Icons.email),
                ),
                validator: (value) {
                  if (value!.isEmpty) return "Email is required";
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.white.withOpacity(0.7),
                  filled: true,
                  prefixIcon: const Icon(Icons.password),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                validator: (value) =>
                    value!.length < 6 ? "Password must be at least 6 characters" : null,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // After signup, redirect to LoginPage
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Account created successfully!")),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage(userName: '',)),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.teal,
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _login(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account? ", style: TextStyle(color: Colors.green)),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage(userName: '',)),
            );
          },
          child: const Text(
            "Login",
            style: TextStyle(color: Colors.teal),
          ),
        ),
      ],
    );
  }
}
