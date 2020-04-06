import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:reschedule/repository/faculty_entity.dart';
import 'package:reschedule/repository/faculty_group_entity.dart';

class HiveBoxes {
  static final String userPrefs = 'userPrefs';
}

class HiveHelper {
  open() async {
    await Hive.initFlutter();
    Hive.registerAdapter(FacultyEntityAdapter());
    Hive.registerAdapter(FacultyGroupEntityAdapter());
    await Hive.openBox(HiveBoxes.userPrefs);
  }

  close() {
    Hive.close();
  }
}
