import 'package:flutter/material.dart';
import 'MainScreen.dart';
import '../Configuraciones/Validaciones.dart';
import '../Configuraciones/ApiServicio.dart';
import '../Configuraciones/Usuario.dart';
import '../Widgets/SnackBarHelper.dart';



class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 600, // Ancho de la imagen
                height: 35, // Alto de la imagen
                child: Image(
                  image: NetworkImage(
                      'https://i.postimg.cc/3r491Zj6/Conduce-el-auto-de-tus.gif'),
                  fit: BoxFit.contain, // Asegura que la imagen cubra el área
                ),
              ),
              const SizedBox(height: 30),
              const SizedBox(
                width: 200, // Ancho de la imagen
                height: 120, // Alto de la imagen
                child: Image(
                  image: NetworkImage('https://i.postimg.cc/jqpcFJZj/Logo.png'),
                  fit: BoxFit.contain, // Asegura que la imagen cubra el área
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 300, // Ajusta el ancho a tu gusto
                child: TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Correo/Usuario',
                    labelStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 255, 226, 235)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 255, 226, 235)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  if (!Validaciones.valNoVacio(email)) {
                    SnackBarHelper.showSnackBar(context, 'El correo no puede estar vacío',Colors.red);
                    return;
                  }
                  if (!Validaciones.valUsuario(email)) {
                    SnackBarHelper.showSnackBar(context, 'Por favor ingresa un correo o usuario válido',Colors.red);
                    return;
                  }
                  if (!Validaciones.valNoVacio(password)) {
                    SnackBarHelper.showSnackBar(context, 'La contraseña no puede estar vacía',Colors.red);
                    return;
                  }
                  if (!Validaciones.valPassword(password)) {
                    SnackBarHelper.showSnackBar(context, 'La contraseña debe tener al menos 6 caracteres',Colors.red);
                    return;
                  }
                  try {
                    final capturedContext = context;
                    final autenticado = await ApiServicio.autenticarUsuario(email, password);
                    
                    if (autenticado) {
                      Usuario.instancia.establecerUsuario(id:email);
                      Navigator.push(
                        capturedContext,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    } else {
                        SnackBarHelper.showSnackBar(capturedContext, 'Credenciales Incorrectas', Colors.red);
                    }
                  } catch (e) {
                    print(e);
                    SnackBarHelper.showSnackBar(context, 'Error al conectar con el servidor', Colors.red);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 253, 114, 90),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'INICIAR SESIÓN',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  print('Crear cuenta presionado');
                },
                child: const MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    '¿No tienes una cuenta en GuayacoCar?\nCrear una cuenta',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 211, 208),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
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
