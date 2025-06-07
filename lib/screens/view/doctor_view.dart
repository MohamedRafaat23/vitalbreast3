import 'package:flutter/material.dart';
import 'package:vitalbreast3/screens/ChatBot/chat_bot_view.dart';
import 'package:vitalbreast3/screens/view/story_view.dart';
import 'package:vitalbreast3/widgets/back_button.dart';
import 'package:vitalbreast3/widgets/context_navigation_extansions.dart';
import 'package:vitalbreast3/widgets/custom_elevated_button.dart';

class DoctorView extends StatelessWidget {
  const DoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.pink[50]!, Colors.pink[100]!, Colors.pink[200]!],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),

                      //back button
                      child: BackButtonn(
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StoryView(),
                              ),
                            ),
                      ),
                    ),

                    // Logo
                  ],
                ),

                const SizedBox(height: 40),

                // Title
                const Text(
                  'Inspiring Stories From\nThose Who Contracted\nThe Disease And\nRecovered',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 20),

                // Profile images
                const Spacer(),

                // Circular profile images
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Main profile image (center)
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                        ),
                        child: const CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(
                            'assets/4.png',
                          ), // Replace with your main profile image
                        ),
                      ),

                      // Positioned profile images
                      Positioned(
                        bottom: -10,
                        left: 20,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: const CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(
                              'assets/4.png',
                            ), // Replace with your image
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: -10,
                        right: 20,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: const CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(
                              'assets/profile4.png',
                            ), // Replace with your image
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Next button
                CustomElevatedButton(
                  text: 'Next',
                  onTap: () {
                    context.push(ChatBotView());
                  },
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
