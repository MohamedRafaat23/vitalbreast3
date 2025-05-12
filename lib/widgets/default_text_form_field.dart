import 'package:flutter/material.dart';
 
// ignore: must_be_immutable
class DefaultTextFormField extends StatelessWidget {
  DefaultTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    
    // this.PrefixIconImageName,
   });
  TextEditingController controller;
  String hintText;
  // متغير لتمثيل الشهادة المرفوعة (قد يكون اسم الملف أو أي معلومات أخرى)
   TextEditingController certficate = TextEditingController();
  // متغير لتمثيل الشهادة المرفوعة (قد يكون اسم الملف أو أي معلومات أخرى)
  String? uploadedCertificate = "No file chosen";

  // String? PrefixIconImageName;
 
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      controller: controller,
      validator: (value) {
        if (value == "") {
          return "required";
        }
        return null;
      },
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w200,
          color: Colors.black45,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.5, color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.1, color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.1, color: Colors.red),
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder:   OutlineInputBorder(
          borderSide: BorderSide(width: .5, color: Colors.redAccent),
          borderRadius: BorderRadius.circular(20),
        ),

      
        
      ),
    );
  }
}
