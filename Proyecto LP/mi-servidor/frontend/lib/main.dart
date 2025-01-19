import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GuayacoCar',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 255, 226, 235),
        scaffoldBackgroundColor: Color(0xFF0D050E),
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 600, // Ancho de la imagen
                height: 35, // Alto de la imagen
                child: Image.network(
                  'https://i.postimg.cc/3r491Zj6/Conduce-el-auto-de-tus.gif', // Reemplaza con el link a tu imagen
                  fit: BoxFit.contain, // Asegura que la imagen cubra el área
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: 200, // Ancho de la imagen
                height: 120, // Alto de la imagen
                child: Image.network(
                  'https://i.postimg.cc/jqpcFJZj/Logo.png', // Reemplaza con el link a tu imagen
                  fit: BoxFit.contain, // Asegura que la imagen cubra el área
                ),
              ),
              SizedBox(height: 30),
              // Campo de texto para correo/usuario
              SizedBox(
                width: 300, // Ajusta el ancho a tu gusto
                child: TextField(
                  controller: _emailController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Correo/Usuario',
                    labelStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color.fromARGB(255, 255, 226, 235)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Campo de texto para contraseña
              SizedBox(
                width: 300, // Ajusta el ancho a tu gusto
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color.fromARGB(255, 255, 226, 235)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Botón para iniciar sesión
              ElevatedButton(
                onPressed: () {
                  print('Iniciar sesión presionado');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 253, 114, 90),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'INICIAR SESIÓN',
                  style: TextStyle(fontSize: 16,
                  color: Colors.white),                  
                ),
              ),
              SizedBox(height: 20),
              // Enlace para crear una cuenta
              GestureDetector(
                onTap: () {
                  print('Crear cuenta presionado');
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click, // Cambiar el cursor a mano
                  child: Text(
                    '¿No tienes una cuenta en GuayacoCar?\nCrear una cuenta',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 255, 211, 208),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline, // Subrayado
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}