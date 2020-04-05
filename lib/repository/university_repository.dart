import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:core';

import 'package:reschedule/repository/faculty_group_entity.dart';
import 'faculty_entity.dart';

/// A class that loads and persists faculties
/// The data layer of the app
class UniversityRepository {
  // Loads faculties first from the API
  Future<List<FacultyEntity>> loadFaculties() async {
    final response = await http.get('https://rts.a6raywa1cher.com/reschedule-tsu-spring/faculties');
    if (response.statusCode == 200) {
      // handle response here
    }
  }

  // Loads faculty groups from the API
  Future<List<FacultyGroupEntity>> loadGroups() {}
}
