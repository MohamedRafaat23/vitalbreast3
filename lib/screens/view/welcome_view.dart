import 'package:flutter/material.dart';
import 'package:vitalbreast3/screens/view/story_view.dart';
import 'package:vitalbreast3/widgets/context_navigation_extansions.dart';
import 'package:vitalbreast3/widgets/next_button.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color(0xFFF8BBD0), // لون وردي فاتح
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
               
              children: [
                
                 Center(
                  child: SizedBox(
                    width: 280,
                    child: Image.asset(
                      'assets/1.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 1),
                const Text(
                  'Vital Breast',
                  style: TextStyle(
                    color: Color(0xFFF24699),
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            
                const Spacer(),
            
                //button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: NextButton(
                      onTap: () {
                        context.pushReplacement(StoryView());
                      },
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
