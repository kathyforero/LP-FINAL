import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Pantallas/LoginScreen.dart';

// 🔹 Importa la configuración para Firebase Web
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // 🔹 Carga opciones correctas para cada plataforma
  );

  runApp(const MyApp());
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
