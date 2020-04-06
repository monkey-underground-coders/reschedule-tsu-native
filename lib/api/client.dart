import 'package:http/http.dart' as http;
import 'package:reschedule/api/routes.dart';

Future<http.Response> fetchFaculties(http.Client client) async {
  return client.get(APIRoutes.getFaculties);
}

Future<http.Response> fetchFacultyGroups(http.Client client, String faculty) async {
  return client.get(APIRoutes.getFacultyGroups(faculty));
}
