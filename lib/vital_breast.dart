import 'package:flutter/material.dart';
import 'package:vitalbreast3/core/data/local/cashe_helper.dart';
import 'package:vitalbreast3/navbar/top_doctor_screen.dart';
import 'package:vitalbreast3/screens/Sign/SignUp/authentification.dart';

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
      home:
CasheHelper.getData(key: "token") != null
    ? LayoutMainScreen()
    :  WelcomeView(),
      routes: {
        LayoutMainScreen.routeName: (context) => const LayoutMainScreen(),
        Authentification.id : (context) => const Authentification(),
      },
    );
  }
}
