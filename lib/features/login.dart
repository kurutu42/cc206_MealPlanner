import 'package:cc206_mealplanner/features/signup.dart'; // Make sure this import is correct
import 'package:flutter/material.dart';
import 'package:cc206_mealplanner/features/homepage.dart';  // Make sure this import is correct

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required String userName});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;

  // Static fixed user credentials
  static const String fixedUsername = "Kean Janaban";
  static const String fixedPassword = "123456";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background4.jpg'), // Use the asset image
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
                  _signup(context),
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
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome Back",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          SizedBox(height: 5.0),
          Text(
            "Enter your credentials to login",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ],
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
                  fillColor: Colors.white24.withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.person),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Username is required" : null,
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
                  fillColor: Colors.white.withOpacity(0.1),
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
                    // Validate static credentials
                    if (_usernameController.text == LoginPageState.fixedUsername &&
                        _passwordController.text == LoginPageState.fixedPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Login successful!")),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MealPlannerHomePage(
                              userName: _usernameController.text),
                        ),
                      );
                    } else {
                      // Show error message if credentials are incorrect
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Invalid username or password")),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.teal,
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? ", style: TextStyle(color: Colors.green)),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignupPage()),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.teal),
          ),
        ),
      ],
    );
  }
}

