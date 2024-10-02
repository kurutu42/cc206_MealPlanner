import 'package:cc206_mealplanner/features/login.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.cyan.shade100,
              Colors.green.shade500,
            ],
          ),
        ),
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _header(context),
            _inputField(context),
            _login(context),
          ],
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Image.network(
          "https://scontent.fceb6-1.fna.fbcdn.net/v/t1.15752-9/461218601_515279471213388_6743303864073392043_n.png?_nc_cat=109&ccb=1-7&_nc_sid=9f807c&_nc_eui2=AeHbfnsQA0p5ADwrOnsQPcHmTiOUuP-KZyBOI5S4_4pnILL46m_Z6jOIphVsb3FpMoah3ig-pC30qbOlEa2LyZ9d&_nc_ohc=ac02w-JnOZ8Q7kNvgEDZcrf&_nc_ht=scontent.fceb6-1.fna&oh=03_Q7cD1QHprQ0mErdgerT_IQvXBDad7oGXhjCkaeNjXGkwpVPMKw&oe=6724D19C",
          width: 100,
          height: 100,
        ),
        const Text(
          "Create Account",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        const Text("Enter your credential to signup"),
      ],
    );
  }

  _inputField(context) {
    return Center(
      child: Container(
        width: 300, // set the width you want
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: "Username",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: Colors.white24.withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.person)),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none),
                fillColor: Colors.white.withOpacity(0.1),
                filled: true,
                prefixIcon: const Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none),
                fillColor: Colors.white.withOpacity(0.1),
                filled: true,
                prefixIcon: const Icon(Icons.password),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.teal,
              ),
              child: const Text(
                "Sign Up",
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }

  _login(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account? "),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
          child: const Text(
            "Login",
            style: TextStyle(color: Colors.teal),
          ),
        )
      ],
    );
  }
}