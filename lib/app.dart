import 'package:flutter/material.dart';
import 'package:reschedule/constants.dart';
import 'package:reschedule/route_generator.dart';

class App extends StatelessWidget {
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
