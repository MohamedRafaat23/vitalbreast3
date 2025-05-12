import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  //! Navigation
  Future<dynamic> push(Widget screen, {Object? arguments}) {
    return Navigator.push(
      this,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
   Future<dynamic> pushReplacement(Widget screen, {Object? arguments}) {
    return Navigator.push(
      this,
      MaterialPageRoute(builder: (context) => screen),
    );
  }


 

  void pop() => Navigator.of(this).maybePop();



}
