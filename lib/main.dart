import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:reschedule/app.dart';

const mainHiveBox = 'studentPrefs';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(mainHiveBox);

  runApp(App());
}
