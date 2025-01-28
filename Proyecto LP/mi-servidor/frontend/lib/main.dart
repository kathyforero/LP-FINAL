import 'package:flutter/material.dart';
import 'Pantallas/LoginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GuayacoCar',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 255, 226, 235),
        scaffoldBackgroundColor: const Color(0xFF0D050E),
      ),
      home: LoginScreen(),
    );
  }
}
