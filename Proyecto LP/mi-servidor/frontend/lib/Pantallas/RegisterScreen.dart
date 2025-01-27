import 'package:flutter/material.dart';
import '../Widgets/PasswordField.dart';
import '../Widgets/CustomCheckBox.dart';
import 'MainScreen.dart';
import 'LoginScreen.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmarController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Expanded(
              flex: 1,
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 120, // Ancho de la imagen
                height: 200, // Alto de la imagen
                child: Image(
                  image: NetworkImage('https://i.postimg.cc/jqpcFJZj/Logo.png'),
                  fit: BoxFit.contain, // Asegura que la imagen cubra el área
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 300, // Ajusta el ancho a tu gusto
                child: TextField(
                  controller: _nombreController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Nombre',
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
                width: 300, // Ajusta el ancho a tu gusto
                child: TextField(
                  controller: _apellidoController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Apellido',
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
                width: 300, // Ajusta el ancho a tu gusto
                child: TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Correo',
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
              
              PasswordField(controller: _passwordController),

              const SizedBox(height: 20),
              
              PasswordField(controller: _passwordConfirmarController),

              const SizedBox(height: 40),

              CustomCheckbox(text: 'Acepto los términos y condiciones.'),

              const SizedBox(height: 10),  

              CustomCheckbox(text: 'Deseo recibir notificaciones sobre autos. (Opcional)'),

              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Navegar a la nueva ventana
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
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
                  'CREAR CUENTA',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                  print('Iniciar sesión presionado');
                },
                child: const MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    '¿Ya tienes una cuenta en GuayacoCar?\nIniciar Sesión',
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
          )),
          Expanded(
            flex: 1,
            child: Column(
            children: [
              SizedBox(
                width: 800,
                height: 122, 
                child: Image(
                  image: NetworkImage('https://i.postimg.cc/d0pxJs4F/Encuentra-tu-auto-ideal-con-no.gif'),
                  fit: BoxFit.contain, // Asegura que la imagen cubra el área
                )),                
                SizedBox(
                  width: 534,
                  height: 800,
                  child: Image(
                  image: NetworkImage('https://i.postimg.cc/VvBG9j1s/auto.gif'),
                  fit: BoxFit.contain, // Asegura que la imagen cubra el área
                )),
            ],
          )),
          ]),
        ),
      ),
    );
  }
}
