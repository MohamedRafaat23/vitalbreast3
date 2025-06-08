import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:vitalbreast3/core/doctors/top_doctor_screen.dart';
import 'package:vitalbreast3/widgets/custom_elevated_button.dart';
import 'package:vitalbreast3/widgets/default_text_form_field.dart';
import 'package:vitalbreast3/screens/view/chat_bot_view.dart';
import 'package:vitalbreast3/widgets/back_button.dart';
import 'package:vitalbreast3/widgets/navigateion.dart';
import 'package:vitalbreast3/core/data/remote/dio_helper.dart';
import 'package:vitalbreast3/core/network/api_constant.dart';
import 'package:vitalbreast3/core/data/local/cashe_helper.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await DioHelper.dio.post(
        ApiConstant.login,
        data: {
          'email': emailcontroller.text.trim(),
          'password': passwordcontroller.text.trim(),
        },
      );

      if (response.statusCode == 200) {
        // Save the token
        await CasheHelper.saveData(
          key: 'token',
          value: response.data['auth_token'],
        );
        
        if (mounted) {
          context.pushNamedAndRemoveUntil(LayoutMainScreen.routeName);
        }
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred during login';
      if (e.response?.data != null && e.response?.data['message'] != null) {
        errorMessage = e.response?.data['message'];
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An unexpected error occurred')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
                      onTap: () => Navigator.push(
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 6),
                        DefaultTextFormField(
                          controller: passwordcontroller,
                          hintText: 'Password',
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        CustomElevatedButton(
                          text: _isLoading ? "Loading..." : "Sign In",
                          onTap: _isLoading ? null : login,
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
