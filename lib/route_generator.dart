import 'package:flutter/material.dart';
import './screens/initial.dart';
import './screens/faculty.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => InitialPage());
      case '/faculty':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => FacultyPage(facultyTitle: args),
          );
        }

        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text("ERROR MOTHERFUCKER!"),
        ),
      );
    });
  }
}
