import 'package:flutter/material.dart';
import 'package:miaguilatraking/routes/routes.dart';

import 'helpers/hexColor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi aguila',
      initialRoute: '/',
      routes: getApplicationsRoutes(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(
            vertical: 22,
            horizontal: 26,
          ),
          labelStyle: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        buttonColor: Colors.white,
        primaryColor: Colors.deepOrange,
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: HexColor("37474f"),
        cardColor: Colors.blueGrey[50],
        bottomAppBarColor: Color.fromRGBO(255, 213, 40, 1),
      ),
    );
  }
}
