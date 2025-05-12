import 'package:flutter/material.dart';
import 'package:vitalbreast3/screens/Sign/SignUp/authentification.dart';
import 'package:vitalbreast3/widgets/context_navigation_extansions.dart';
import 'package:vitalbreast3/widgets/custom_elevated_button.dart';

import 'package:vitalbreast3/screens/Sign/SignUp/sign_as_a_pationt.dart';
import 'package:vitalbreast3/screens/Sign/SignUp/sign_as_doctor.dart';
import 'package:vitalbreast3/widgets/back_button.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        width: double.infinity,
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 20),

            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: BackButtonn(
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Authentification(),
                          ),
                        ),
                  ),
                ),

                Image.asset('assets/6.png', height: 300, width: 300),
                Text(
                  'Grow your insight with inspiring news',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 30),
                CustomElevatedButton(
                  text: ('Sign As Doctor'),
                
                onTap: (){
                  context.push(DoctorCreation());
                },
                
                ),
                SizedBox(height: 15,),
                CustomElevatedButton(
                  text: ('Sign As Patient'),
                  onTap:(){
                    context.push(PationCreation());
                  } ,
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
