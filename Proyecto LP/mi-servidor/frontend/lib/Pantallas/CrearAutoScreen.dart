import 'package:flutter/material.dart';

// Crear Autos
class CrearAutoScreen extends StatelessWidget {
  const CrearAutoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 130.0, // Altura del AppBar
          backgroundColor: const Color(0xFF0D050E),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo en el lado izquierdo
              const SizedBox(
                width: 200,
                height: 120,
                child: Image(
                  image: NetworkImage('https://i.postimg.cc/jqpcFJZj/Logo.png'),
                  fit: BoxFit.contain,
                ),
              ),

              // Texto centrado
              Text(
                'Bienvenido al creador de vehículos, usuario!',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Calibri Light',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
      body: Row(
        children: [         
          // Main content
          Expanded(
            child: Column(
              children: [
                // Sorting row
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      
                Expanded(
                  flex: 1,
                  child: Column(
                  children: [
                    Row(children: [

                    ],),


                    Row(children: [

                    ],)
                  ],
                ),
                ),

                // Atributos del Auto
              Expanded(
              flex: 1,
              child: Container(                
                color: const Color(0xFF2B193E),
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Filtros',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField(
                        decoration: const InputDecoration(
                          labelText: 'Marca',
                          labelStyle: TextStyle(
                              color: Colors.white), // Color de la etiqueta
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white), // Borde blanco
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.purple), // Borde al seleccionar
                          ),
                        ),
                        dropdownColor:
                            const Color(0xFF2B193E), // Fondo del desplegable
                        style: const TextStyle(
                            color: Colors.white), // Color del texto seleccionado
                        items: const [
                          DropdownMenuItem(
                            value: 'marca1',
                            child: Text('Marca 1',
                                style:
                                    TextStyle(color: Colors.white)), // Texto blanco
                          ),
                          DropdownMenuItem(
                            value: 'marca2',
                            child: Text('Marca 2',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField(
                        decoration: const InputDecoration(
                          labelText: 'Modelo',
                          labelStyle: TextStyle(
                              color: Colors.white), // Color de la etiqueta
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white), // Borde blanco
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.purple), // Borde al seleccionar
                          ),
                        ),
                        dropdownColor:
                            const Color(0xFF2B193E), // Fondo del desplegable
                        style: const TextStyle(
                            color: Colors.white), // Color del texto seleccionado
                        items: const [
                          DropdownMenuItem(
                            value: 'modelo1',
                            child: Text('Modelo 1',
                                style:
                                    TextStyle(color: Colors.white)), // Texto blanco
                          ),
                          DropdownMenuItem(
                            value: 'modelo2',
                            child: Text('Modelo 2',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Kilometraje Desde',
                                  labelStyle: TextStyle(color: Colors.white)),
                              style: const TextStyle(
                                  color: Colors.white), // Color del texto ingresado
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Kilometraje Hasta',
                                  labelStyle: TextStyle(color: Colors.white)),
                              style: const TextStyle(
                                  color: Colors.white), // Color del texto ingresado
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Precio Desde',
                                  labelStyle: TextStyle(color: Colors.white)),
                              style: const TextStyle(
                                  color: Colors.white), // Color del texto ingresado
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Precio Hasta',
                                  labelStyle: TextStyle(color: Colors.white)),
                              style: const TextStyle(
                                  color: Colors.white), // Color del texto ingresado
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField(
                        decoration: const InputDecoration(
                          labelText: 'Tipo de Vehículo:',
                          labelStyle: TextStyle(
                              color: Colors.white), // Color de la etiqueta
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white), // Borde blanco
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.purple), // Borde al seleccionar
                          ),
                        ),
                        dropdownColor:
                            const Color(0xFF2B193E), // Fondo del desplegable
                        style: const TextStyle(
                            color: Colors.white), // Color del texto seleccionado
                        items: const [
                          DropdownMenuItem(
                            value: 'tipo1',
                            child: Text('SUV',
                                style:
                                    TextStyle(color: Colors.white)), // Texto blanco
                          ),
                          DropdownMenuItem(
                            value: 'tipoa2',
                            child: Text('Sedán',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF9576DA), // Fondo del botón
                          foregroundColor: Colors.white, // Color del texto
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: const Text('Buscar'),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {},
                        child: const SizedBox(
                          width: 45, // Ancho de la imagen
                          height: 47, // Alto de la imagen
                          child: Image(
                            image: NetworkImage(
                                'https://i.postimg.cc/TPjtkxv9/borrarfiltro.png'),
                            fit: BoxFit
                                .contain, // Asegura que la imagen cubra el área
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ),          
              ],
            ),
          ),
        ],
      ),
      ),
      ],
    ));
  }
}