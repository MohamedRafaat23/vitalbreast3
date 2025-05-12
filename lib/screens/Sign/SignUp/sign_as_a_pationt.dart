
import 'package:flutter/material.dart';
import 'package:vitalbreast3/screens/Sign/SignUp/sign_up_succ.dart';
import 'package:vitalbreast3/screens/Sign/SignUp/sign_up_view.dart';
import 'package:vitalbreast3/widgets/context_navigation_extansions.dart';
import 'package:vitalbreast3/widgets/custom_elevated_button.dart';
import 'package:vitalbreast3/widgets/default_text_form_field.dart';

import 'package:vitalbreast3/widgets/back_button.dart';

class PationCreation extends StatefulWidget {
  const PationCreation({super.key});

  @override
  State<PationCreation> createState() => _PationCreationState();
}

class _PationCreationState extends State<PationCreation> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController mobilenumbercontroller = TextEditingController();
  TextEditingController dateofbirthcontroller = TextEditingController();
  
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: BackButtonn(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpView(),
                        ),
                      ),
                    ),
                  ),
                   SizedBox(height: 30),
                  Text('Create Your Account',style: TextStyle(fontSize: 20),),
                  SizedBox(height: 30),
                
                  
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        DefaultTextFormField(
                          controller: namecontroller,
                          hintText: 'Name',
                          // PrefixIconImageName: 'email',
                       
                        ),
                        SizedBox(height: 15),
                        DefaultTextFormField(
                          controller: emailcontroller,
                          hintText: 'Email',
                        
                        ),
                        SizedBox(height: 15),
                        DefaultTextFormField(
                          controller: passwordcontroller,
                          hintText: 'Password',
                        
                        ),
                        SizedBox(height: 15),
                        DefaultTextFormField(
                          controller: mobilenumbercontroller,
                          hintText: 'Mobile Number',
                         
                        ),
                        SizedBox(height: 15),
                        DefaultTextFormField(
                          controller: dateofbirthcontroller,
                          hintText: 'Date Of Birth',
                        
                        ),
                        SizedBox(height: 30),
                      
                      
                        CustomElevatedButton(
                          text: "Sign Up",
                          onTap: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              _formKey.currentState?.save();
                               context.push(SignUPSuccess());
                              // Call your API for Sign Up
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
