import 'package:flutter/material.dart';
import 'package:vitalbreast3/screens/view/doctor_view.dart';
import 'package:vitalbreast3/screens/view/welcome_view.dart';
import 'package:vitalbreast3/widgets/back_button.dart';

class StoryView extends StatelessWidget {
  const StoryView({super.key});

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
                Colors.white,
                Color(0xFFF8BBD0), // لون وردي فاتح
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40), // مسافة من الأعلى
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Align(
                  alignment: Alignment.topLeft,

                  child: BackButtonn(
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WelcomeView(),
                          ),
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Inspiring Stories From Those Who Contracted The Disease And Recovered',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      fontFamily: "Inter",

                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 40,
                      right: 35,
                      child: CircleAvatar(
                        radius: 33,
                        backgroundImage: AssetImage('assets/3.png'),
                      ),
                    ),
                    Positioned(
                      left: 98,
                      bottom: 50,
                      top: 1,
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage('assets/4.png'),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 60,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/3.jpg'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              Center(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 55,
                  margin: const EdgeInsets.only(bottom: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DoctorView()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
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

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
