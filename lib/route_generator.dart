import 'package:flutter/material.dart';
import 'package:reschedule/screens/profile.dart';
import 'package:reschedule/screens/initial.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => InitialPage());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());
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
