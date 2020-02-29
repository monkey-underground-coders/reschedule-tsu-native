import 'package:flutter/material.dart';
import 'package:flutterapp/route_generator.dart';

void main() => runApp(RTSApp());

class RTSApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Расписание ТвГУ",
      theme: ThemeData(
        primaryColor: Color.fromRGBO(50, 65, 85, 1),
        textTheme: TextTheme(headline6: TextStyle(color: Colors.white)),
      ),
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
