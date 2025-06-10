import 'package:flutter/material.dart';
import 'package:vitalbreast3/screens/Sign/SignUp/authentification.dart';
import 'package:vitalbreast3/screens/view/doctor_view.dart';


class ChatBotView extends StatelessWidget {
  const ChatBotView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFCE4EC), // Very light pink at the top
              Color(0xFFF48FB1), // Darker pink at the bottom
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                // Back button
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorView(),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 25),
                
                // Title with shadow effect
                const Text(
                  'Your AI Assistant',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    shadows: [
                      Shadow(
                        blurRadius: 3.0,
                        color: Color(0x40000000),
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 5),
                
                // Subtitle
                const Text(
                  'Using This Chatbot',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF555555),
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Centered chat bot image
                Center(
                  child: SizedBox(
                    width: 280,
                    child: Image.asset(
                      'assets/7.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                
                SizedBox(height: 160),
                
                // Next button
                Center(
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    margin: const EdgeInsets.only(bottom: 30),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Authentification(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
