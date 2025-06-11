import 'package:flutter/material.dart';
import 'package:vitalbreast3/widgets/context_navigation_extansions.dart';
import 'package:vitalbreast3/screens/Sign/SignUp/login_view.dart';
import 'package:vitalbreast3/screens/Sign/SignUp/sign_up_view.dart';


class Authentification extends StatelessWidget {
  const Authentification({super.key});
  static String id = 'Authentification';
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFCE4EC), // Lighter pink at top
                Color(0xFFF48FB1), // Original pink at bottom
              ],
            ),
          ),
          child: Column(
           
            children: [
              // Healthcare image with doctor and patient
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                child: Image.asset('assets/5.png', height: 220, width: 350),
              ),
              const SizedBox(height: 20),
              
              // Main text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Grow your insight with inspiring news',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter",
                    color: Colors.black,  // Darker text for better readability
                  ),
                ),
              ),
              const SizedBox(height: 50),
              
              // Login button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: () {
                    context.push(LoginView());
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xFFEC407A),
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 3,
                    shadowColor: Colors.black26,
                    minimumSize: Size(double.infinity, 0),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Sign Up button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: () {
                    context.push(SignUpView());
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFFEC407A),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 3,
                    shadowColor: Colors.black26,
                    minimumSize: Size(double.infinity, 0),
                  ),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}