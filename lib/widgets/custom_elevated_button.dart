import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, this.onTap, required this.text,  this.backgroundColor, this.tetxtColor});
  final void Function()? onTap;
  final String text;
  final Color? backgroundColor,tetxtColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor?? Colors.pinkAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            elevation: 3,
            shadowColor: Colors.black26,
            minimumSize: Size(double.infinity, 0),
          ),
          
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17, color: tetxtColor?? Colors.white),
          ),
        ),
      ),
    );
  }
}
