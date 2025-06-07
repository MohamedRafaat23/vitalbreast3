import 'package:flutter/material.dart';
import 'package:vitalbreast3/vital_breast.dart';

import 'core/data/local/cashe_helper.dart';
import 'core/data/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CasheHelper.init();
  DioHelper.init();
  runApp(const VitalBreast());
  // JGDSABFJKBVSVBD
}
