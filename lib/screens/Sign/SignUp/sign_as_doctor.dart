import 'package:flutter/material.dart';
import 'package:vitalbreast3/screens/Sign/SignUp/complete_signing.dart';
import 'package:vitalbreast3/screens/Sign/SignUp/sign_up_view.dart';
import 'package:vitalbreast3/widgets/context_navigation_extansions.dart';
import 'package:vitalbreast3/widgets/custom_elevated_button.dart';
import 'package:vitalbreast3/widgets/default_text_form_field.dart';

import 'package:vitalbreast3/widgets/back_button.dart';

class DoctorCreation extends StatefulWidget {
  const DoctorCreation({super.key});

  @override
  State<DoctorCreation> createState() => _DoctorCreationState();
}

class _DoctorCreationState extends State<DoctorCreation> {
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),

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
                              builder: (context) => SignUpView(),
                            ),
                          ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text('Create Your Account', style: TextStyle(fontSize: 25)),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          DefaultTextFormField(
                            controller: namecontroller,
                            hintText: 'Name',

                            // PrefixIconImageName: 'email',
                          ),
                          SizedBox(height: 20),
                          DefaultTextFormField(
                            controller: emailcontroller,
                            hintText: 'Email',

                            // PrefixIconImageName: 'email',
                          ),
                          SizedBox(height: 20),
                          DefaultTextFormField(
                            controller: passwordcontroller,
                            hintText: 'Password',

                            // PrefixIconImageName: 'email',
                          ),
                          SizedBox(height: 20),
                          DefaultTextFormField(
                            controller: mobilenumbercontroller,
                            hintText: 'Mobile Number',

                            // PrefixIconImageName: 'email',
                          ),
                          SizedBox(height: 20),
                          DefaultTextFormField(
                            controller: dateofbirthcontroller,
                            hintText: 'Date Of Birth',

                            // PrefixIconImageName: 'email',
                          ),

                          SizedBox(height: 20),
                          CustomElevatedButton(
                            text: ("Next "),
                            onTap: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                _formKey.currentState?.save();
                                context.push(DoctorInformation());
                                // connect with api
                              }
                            },
                          ),
                          SizedBox(height: 50),
                        ],
                      ),
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
