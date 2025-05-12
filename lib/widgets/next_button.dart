import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_forward_ios_sharp, color: Colors.white),
          onPressed: onTap,
        ),
      ),
    );
  }
}
