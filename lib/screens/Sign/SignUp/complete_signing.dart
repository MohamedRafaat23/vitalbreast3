import 'package:flutter/material.dart';
import 'package:vitalbreast3/screens/Sign/SignUp/sign_as_doctor.dart';
import 'package:vitalbreast3/screens/Sign/SignUp/sign_up_succ.dart';
import 'package:vitalbreast3/widgets/back_button.dart';
import 'package:vitalbreast3/widgets/context_navigation_extansions.dart';
import 'package:vitalbreast3/widgets/custom_elevated_button.dart';
import 'package:vitalbreast3/widgets/default_text_form_field.dart';

class DoctorInformation extends StatefulWidget {
  const DoctorInformation({super.key});

  @override
  State<DoctorInformation> createState() => _DoctorInformationState();
}

class _DoctorInformationState extends State<DoctorInformation> {
  TextEditingController cliniclocation = TextEditingController();
  TextEditingController mobilenumberofclinic= TextEditingController();
  TextEditingController clinicworkinghoure = TextEditingController();
  TextEditingController certficate = TextEditingController();

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
                          builder: (context) => DoctorCreation(),
                        ),
                      ),
                    ),
                  ),
                   SizedBox(height: 30),
                  Text('Complete The account egistration',style: TextStyle(fontSize: 25),),
                  SizedBox(height: 30),
                
                  
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        DefaultTextFormField(
                          controller: cliniclocation,
                          hintText: 'City',
                          // PrefixIconImageName: 'email',
                       
                        ),
                        SizedBox(height: 15),

                        DefaultTextFormField(
                          controller: mobilenumberofclinic,
                          hintText: '01093358752',
                        
                        ),
                        SizedBox(height: 15),
                        DefaultTextFormField(
                          controller: clinicworkinghoure,
                          hintText: '10:00 AM - 5:00 PM',
                        
                        ),
                        
                        
                        SizedBox(height: 30),
                        DefaultTextFormField(
                          controller: certficate,
                          hintText: 'Certificate',
                          
                          
                          
                          
                        
                        ),
                        SizedBox(height: 35),
                      
                      
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