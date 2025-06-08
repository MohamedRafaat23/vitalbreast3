import 'package:flutter/material.dart';
import 'package:vitalbreast3/screens/view/doctor_view.dart';
import 'package:vitalbreast3/widgets/back_button.dart';
import 'package:vitalbreast3/widgets/context_navigation_extansions.dart';
import 'package:vitalbreast3/widgets/custom_elevated_button.dart';

class StoryView extends StatefulWidget {
  const StoryView({super.key});

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.pink[50]!, Colors.pink[100]!, Colors.pink[200]!],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
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

                const SizedBox(height: 20),

                // Title
                const Text(
                  'Inspiring Stories From Those Who Contracted\nThe Disease And\nRecovered',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1.2,

                  ),
                ),

                const SizedBox(height: 50),

                // Profile images
                SizedBox(
                  height: 140,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Left image
                      Positioned(
                        left: 40,
                        bottom: 0,
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 42,
                            backgroundImage: AssetImage('assets/4.png'),
                          ),
                        ),
                      ),
                      // Right image
                      Positioned(
                        right: 40,
                        bottom: 0,
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 42,
                            backgroundImage: AssetImage('assets/4.png'),
                          ),
                        ),
                      ),
                      // Center image (on top)
                      Positioned(
                        top: 0,
                        child: CircleAvatar(
                          radius: 48,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 44,
                            backgroundImage: AssetImage('assets/3.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

               SizedBox(height: 140),

                // Next button
                CustomElevatedButton(
                  text: 'Next',
                  onTap: () {
                    context.push(DoctorView());
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