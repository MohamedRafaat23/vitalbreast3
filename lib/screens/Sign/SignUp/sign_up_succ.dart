
import 'package:flutter/material.dart';
import 'package:vitalbreast3/screens/home/stories_screen.dart';
import 'package:vitalbreast3/widgets/context_navigation_extansions.dart';
import 'package:vitalbreast3/widgets/custom_elevated_button.dart';


class SignUPSuccess extends StatelessWidget {
  const SignUPSuccess({super.key});

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
              Colors.white,
              Color(0xFFF48FB1), // لون وردي فاتح
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 80), // رفع كل المحتوى شوي لتحت
            Image.asset('assets/Vector.png', height: 150, width: 250),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Congratulation',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  fontFamily: "Inter",
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Sign Up Successful',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                fontFamily: "Inter",
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40),
            CustomElevatedButton(text: "Let's Explore",
              onTap: () {
                context.push(StoriesScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
