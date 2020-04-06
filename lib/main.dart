import 'package:flutter/material.dart';
import 'package:reschedule/app.dart';
import 'package:reschedule/hive.dart';

void main() async {
  HiveHelper _hive = new HiveHelper();
  await _hive.open();

  runApp(App());
}
