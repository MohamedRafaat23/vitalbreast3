
import 'package:flutter/material.dart';
import 'package:vitalbreast3/core/doctors/top_doctor_screen.dart';
import 'package:vitalbreast3/widgets/custom_elevated_button.dart';
import 'package:vitalbreast3/widgets/default_text_form_field.dart';
import 'package:vitalbreast3/screens/ChatBot/chat_bot_view.dart';
import 'package:vitalbreast3/widgets/back_button.dart';
import 'package:vitalbreast3/widgets/navigateion.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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

            child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: BackButtonn(
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatBotView(),
                              ),
                            ),
                      ),
                    ),
        
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 35),
                        child: Text(
                          'Welcome Back!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            fontFamily: "Inter",
        
                            color: Colors.black,
                          ),
                        ),
                        
                      ),
                      
                    ),

                    Image.asset('assets/1.png', height: 200, width: 200),
                    Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 30),
        
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          DefaultTextFormField(
                            controller: emailcontroller,
                            hintText: 'Email',
        
                            // PrefixIconImageName: 'email',
                          ),
                          SizedBox(height: 6),
                          DefaultTextFormField(
                            controller: passwordcontroller,
                            hintText: 'Password',
        
                            // PrefixIconImageName: 'password',
                          ),
                          SizedBox(height: 20),
                          CustomElevatedButton(
                            text: ("Sign In "),
                            onTap: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                _formKey.currentState?.save();
                                context.pushNamedAndRemoveUntil(LayoutMainScreen.routeName);
                                // connect with api           
                              }
                            },
                          ),
                          SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          
        ),
      ),
    );
  }
}
