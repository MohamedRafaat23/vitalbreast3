import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vitalbreast3/screens/Sign/SignUp/sign_up_succ.dart';
import 'package:vitalbreast3/screens/Sign/SignUp/sign_up_view.dart';
import 'package:vitalbreast3/widgets/back_button.dart';
import 'package:vitalbreast3/widgets/custom_elevated_button.dart';
import 'package:vitalbreast3/widgets/default_text_form_field.dart';

import '../../../core/data/local/cashe_helper.dart';
import '../../../core/data/remote/dio_helper.dart';
import '../../../core/models/user.dart';
import '../../../core/network/api_constant.dart';

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
  TextEditingController citycontroller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Add GET request method
  Future<void> getData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await DioHelper.dio.get(
        ApiConstant.signup,
        options: Options(
          headers: {
            'Authorization': 'Token ${CasheHelper.getData(key: 'token')}',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Handle successful response
        print('Data received: ${response.data}');
        // You can parse the response data here
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred while fetching data';
      if (e.response?.data != null && e.response?.data['message'] != null) {
        errorMessage = e.response?.data['message'];
      }
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
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

  // Add POST request method for sign up
  Future<void> signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final form = FormData.fromMap({
        'name': namecontroller.text.trim(),
        'email': emailcontroller.text.trim(),
        'password': passwordcontroller.text.trim(),
        'phone': mobilenumbercontroller.text.trim(),
        'date_of_birth': dateofbirthcontroller.text.trim(),
        'city': citycontroller.text.trim(),
        'role': 'patient',
      });

      final response = await DioHelper.dio.post(ApiConstant.signup, data: form);

      if (response.statusCode == 201) {
        user = User.fromJson(response.data);
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignUPSuccess()),
          );
        }
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred during sign up';
      if (e.response?.data != null && e.response?.data['message'] != null) {
        errorMessage = e.response?.data['message'];
      }
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFF48FB1)],
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
                              builder: (context) => const SignUpView(),
                            ),
                          ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Create Your Account',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        DefaultTextFormField(
                          controller: namecontroller,
                          hintText: 'Name',
                        ),
                        const SizedBox(height: 15),
                        DefaultTextFormField(
                          controller: emailcontroller,
                          hintText: 'Email',
                        ),
                        const SizedBox(height: 15),
                        DefaultTextFormField(
                          controller: passwordcontroller,
                          hintText: 'Password',
                        ),
                        const SizedBox(height: 15),
                        DefaultTextFormField(
                          controller: mobilenumbercontroller,
                          hintText: 'Mobile Number',
                        ),
                        const SizedBox(height: 15),
                        DefaultTextFormField(
                          controller: dateofbirthcontroller,
                          hintText: 'Date Of Birth',
                        ),
                        const SizedBox(height: 15),
                        DefaultTextFormField(
                          controller: citycontroller,
                          hintText: 'city',
                        ),
                        const SizedBox(height: 30),
                        CustomElevatedButton(
                          text: _isLoading ? "Signing up..." : "Sign Up",
                          onTap: _isLoading ? null : signUp,
                        ),
                        const SizedBox(height: 50),
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

  @override
  void dispose() {
    emailcontroller.dispose();
    namecontroller.dispose();
    passwordcontroller.dispose();
    mobilenumbercontroller.dispose();
    dateofbirthcontroller.dispose();
    citycontroller.dispose();
    super.dispose();
  }
}
