import 'package:flutter/material.dart';
import 'package:flutterapp/constants.dart';
import 'package:flutterapp/route_generator.dart';

void main() => runApp(RTSApp());

class RTSApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Расписание ТвГУ",
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primaryColor: backgroundColor,
        textTheme: TextTheme(
          caption: TextStyle(color: backgroundColor),
        ),
      ),
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
