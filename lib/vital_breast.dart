import 'package:flutter/material.dart';
import 'package:vitalbreast3/core/doctors/top_doctor_screen.dart';

import 'package:vitalbreast3/screens/view/welcome_view.dart';


class VitalBreast extends StatelessWidget {
  const VitalBreast({super.key});

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.white
        ),
        fontFamily: "Inter"
      ),
      home: WelcomeView(),
      routes: {
        LayoutMainScreen.routeName: (context) => const LayoutMainScreen(),
      },
    );
  }
}
