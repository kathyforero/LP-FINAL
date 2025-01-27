import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../Configuraciones/Usuario.dart';

// Crear Autos
class CrearAutoScreen extends StatelessWidget {  

  const CrearAutoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
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
                    image:
                        NetworkImage('https://i.postimg.cc/jqpcFJZj/Logo.png'),
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Centra verticalmente
                            crossAxisAlignment: CrossAxisAlignment
                                .center, // Centra horizontalmente
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Tachito de basura ************************************************
                                  SizedBox(
                                    width: 45, // Ancho de la imagen
                                    height: 50, // Alto de la imagen
                                    child: GestureDetector(
                                      onTap: () {
                                        print("Imagen presionada");
                                        // Lógica al presionar el botón
                                      },
                                      child: Image(
                                        image: NetworkImage(
                                            'https://i.postimg.cc/y6gjPyff/Trash.png'),
                                        fit: BoxFit
                                            .contain, // Asegura que la imagen cubra el área
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 50),

                                  // Carga tu imagen ************************************************
                                  ElevatedButton(
                                    onPressed: () async {
                                      // Abre el explorador de archivos para seleccionar un archivo
                                      FilePickerResult? result =
                                          await FilePicker.platform.pickFiles();

                                      if (result != null) {
                                        // Si el usuario selecciona un archivo
                                        String? filePath =
                                            result.files.single.path;
                                        print(
                                            "Archivo seleccionado: $filePath");
                                        // Aquí puedes usar el archivo seleccionado (por ejemplo, cargarlo o procesarlo)
                                      } else {
                                        // Si el usuario cancela la selección
                                        print(
                                            "No se seleccionó ningún archivo.");
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(
                                          0xFF9576DA), // Fondo del botón
                                      foregroundColor:
                                          Colors.white, // Color del texto
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                    ),
                                    child: const Text('Carga Tu Imagen'),
                                  ),
                                ],
                              ),

                              SizedBox(height: 10),

                              // Imagen de ejemplo ************************************************
                              SizedBox(
                                width: 650, // Ancho de la imagen
                                height: 576, // Alto de la imagen
                                child: Image(
                                  image: NetworkImage(
                                      'https://i.postimg.cc/qRYLrN7X/preview.png'),
                                  fit: BoxFit
                                      .contain, // Asegura que la imagen cubra el área
                                ),
                              ),

                              SizedBox(height: 10),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Boton izquierda ************************************************
                                  SizedBox(
                                    width: 50, // Ancho de la imagen
                                    height: 50, // Alto de la imagen
                                    child: GestureDetector(
                                      onTap: () {
                                        print("Imagen presionada");
                                        // Lógica al presionar el botón
                                      },
                                      child: Image(
                                        image: NetworkImage(
                                            'https://i.postimg.cc/bY7TFSWq/izquierda.png'),
                                        fit: BoxFit
                                            .contain, // Asegura que la imagen cubra el área
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 30),

                                  const Text(
                                    '0/0',
                                    style: TextStyle(
                                        fontFamily: 'Century Gothic',
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),

                                  SizedBox(width: 30),

                                  // Boton derecha ************************************************
                                  SizedBox(
                                    width: 50, // Ancho de la imagen
                                    height: 50, // Alto de la imagen
                                    child: GestureDetector(
                                      onTap: () {
                                        print("Imagen presionada");
                                        // Lógica al presionar el botón
                                      },
                                      child: Image(
                                        image: NetworkImage(
                                            'https://i.postimg.cc/qM2LfMHy/derecha.png'),
                                        fit: BoxFit
                                            .contain, // Asegura que la imagen cubra el área
                                      ),
                                    ),
                                  ),
                                ],
                              )
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
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Centra verticalmente
                                crossAxisAlignment: CrossAxisAlignment
                                    .center, // Centra horizontalmente
                                children: [
                                  // Elementos
                                  // Placa ************************************************
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Placa:',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(width: 40),
                                      SizedBox(
                                        width: 550,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              hintText: 'Ej.: ABC-123',
                                              hintStyle: TextStyle(
                                                  color: Colors.white54)),
                                          style: const TextStyle(
                                              color: Colors
                                                  .white), // Color del texto ingresado
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),

                                  // Precio ************************************************
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Precio:',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(width: 40),
                                      SizedBox(
                                        width: 550,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              hintText: 'Ej.: 20000.00',
                                              hintStyle: TextStyle(
                                                  color: Colors.white54)),
                                          style: const TextStyle(
                                              color: Colors
                                                  .white), // Color del texto ingresado
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),

                                  // Marca ************************************************
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Marca:',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(width: 40),
                                        SizedBox(
                                          width: 550,
                                          child: DropdownButtonFormField(
                                            decoration: const InputDecoration(
                                              hintText: 'Marca',
                                              hintStyle: TextStyle(
                                                  color: Colors
                                                      .white54), // Color de la etiqueta
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .white), // Borde blanco
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .purple), // Borde al seleccionar
                                              ),
                                            ),
                                            dropdownColor: const Color(
                                                0xFF2B193E), // Fondo del desplegable
                                            style: const TextStyle(
                                                color: Colors
                                                    .white), // Color del texto seleccionado
                                            items: const [
                                              DropdownMenuItem(
                                                value: 'marca1',
                                                child: Text('Marca 1',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white)), // Texto blanco
                                              ),
                                              DropdownMenuItem(
                                                value: 'marca2',
                                                child: Text('Marca 2',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ],
                                            onChanged: (value) {},
                                          ),
                                        )
                                      ]),
                                  const SizedBox(height: 10),

                                  // Modelo ************************************************
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Modelo:',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(width: 40),
                                        SizedBox(
                                          width: 550,
                                          child: DropdownButtonFormField(
                                            decoration: const InputDecoration(
                                              hintText: 'Modelo',
                                              hintStyle: TextStyle(
                                                  color: Colors
                                                      .white54), // Color de la etiqueta
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .white), // Borde blanco
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .purple), // Borde al seleccionar
                                              ),
                                            ),
                                            dropdownColor: const Color(
                                                0xFF2B193E), // Fondo del desplegable
                                            style: const TextStyle(
                                                color: Colors
                                                    .white), // Color del texto seleccionado
                                            items: const [
                                              DropdownMenuItem(
                                                value: 'modelo1',
                                                child: Text('Modelo 1',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white)), // Texto blanco
                                              ),
                                              DropdownMenuItem(
                                                value: 'modelo2',
                                                child: Text('Modelo 2',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ],
                                            onChanged: (value) {},
                                          ),
                                        )
                                      ]),
                                  const SizedBox(height: 10),

                                  // Tipo ************************************************
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Tipo:',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(width: 40),
                                        SizedBox(
                                          width: 550,
                                          child: DropdownButtonFormField(
                                            decoration: const InputDecoration(
                                              hintText: 'Tipo',
                                              hintStyle: TextStyle(
                                                  color: Colors
                                                      .white54), // Color de la etiqueta
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .white), // Borde blanco
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .purple), // Borde al seleccionar
                                              ),
                                            ),
                                            dropdownColor: const Color(
                                                0xFF2B193E), // Fondo del desplegable
                                            style: const TextStyle(
                                                color: Colors
                                                    .white), // Color del texto seleccionado
                                            items: const [
                                              DropdownMenuItem(
                                                value: 'tipo1',
                                                child: Text('Tipo 1',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white)), // Texto blanco
                                              ),
                                              DropdownMenuItem(
                                                value: 'tipo2',
                                                child: Text('Tipo 2',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ],
                                            onChanged: (value) {},
                                          ),
                                        )
                                      ]),
                                  const SizedBox(height: 10),

                                  // Año ************************************************
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Año:',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(width: 40),
                                      SizedBox(
                                        width: 550,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              hintText: 'Ej.: 2020',
                                              hintStyle: TextStyle(
                                                  color: Colors.white54)),
                                          style: const TextStyle(
                                              color: Colors
                                                  .white), // Color del texto ingresado
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),

                                  // Kilometraje ************************************************
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Kilometraje:',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(width: 40),
                                      SizedBox(
                                        width: 550,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              hintText: 'Ej.: 5000',
                                              hintStyle: TextStyle(
                                                  color: Colors.white54)),
                                          style: const TextStyle(
                                              color: Colors
                                                  .white), // Color del texto ingresado
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),

                                  // Motor ************************************************
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Motor:',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(width: 40),
                                        SizedBox(
                                          width: 550,
                                          child: DropdownButtonFormField(
                                            decoration: const InputDecoration(
                                              hintText: 'Motor',
                                              hintStyle: TextStyle(
                                                  color: Colors
                                                      .white54), // Color de la etiqueta
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .white), // Borde blanco
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .purple), // Borde al seleccionar
                                              ),
                                            ),
                                            dropdownColor: const Color(
                                                0xFF2B193E), // Fondo del desplegable
                                            style: const TextStyle(
                                                color: Colors
                                                    .white), // Color del texto seleccionado
                                            items: const [
                                              DropdownMenuItem(
                                                value: 'motor1',
                                                child: Text('Motor 1',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white)), // Texto blanco
                                              ),
                                              DropdownMenuItem(
                                                value: 'motor2',
                                                child: Text('Motor 2',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ],
                                            onChanged: (value) {},
                                          ),
                                        )
                                      ]),
                                  const SizedBox(height: 10),

                                  // Transmisión ************************************************
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Transmisión:',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(width: 40),
                                        SizedBox(
                                          width: 550,
                                          child: DropdownButtonFormField(
                                            decoration: const InputDecoration(
                                              hintText: 'Transmisión',
                                              hintStyle: TextStyle(
                                                  color: Colors
                                                      .white54), // Color de la etiqueta
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .white), // Borde blanco
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .purple), // Borde al seleccionar
                                              ),
                                            ),
                                            dropdownColor: const Color(
                                                0xFF2B193E), // Fondo del desplegable
                                            style: const TextStyle(
                                                color: Colors
                                                    .white), // Color del texto seleccionado
                                            items: const [
                                              DropdownMenuItem(
                                                value: 'transmision1',
                                                child: Text('Transmisión 1',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white)), // Texto blanco
                                              ),
                                              DropdownMenuItem(
                                                value: 'transmision2',
                                                child: Text('Transmisión 2',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ],
                                            onChanged: (value) {},
                                          ),
                                        )
                                      ]),
                                  const SizedBox(height: 10),

                                  // Peso ************************************************
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Peso:',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(width: 40),
                                      SizedBox(
                                        width: 550,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              hintText: 'Peso en kg',
                                              hintStyle: TextStyle(
                                                  color: Colors.white54)),
                                          style: const TextStyle(
                                              color: Colors
                                                  .white), // Color del texto ingresado
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),

                                  // Ubicación ************************************************
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Ubicación:',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(width: 40),
                                        SizedBox(
                                          width: 550,
                                          child: DropdownButtonFormField(
                                            decoration: const InputDecoration(
                                              hintText: 'Ubicación',
                                              hintStyle: TextStyle(
                                                  color: Colors
                                                      .white54), // Color de la etiqueta
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .white), // Borde blanco
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .purple), // Borde al seleccionar
                                              ),
                                            ),
                                            dropdownColor: const Color(
                                                0xFF2B193E), // Fondo del desplegable
                                            style: const TextStyle(
                                                color: Colors
                                                    .white), // Color del texto seleccionado
                                            items: const [
                                              DropdownMenuItem(
                                                value: 'ubicacion1',
                                                child: Text('Ubicación 1',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white)), // Texto blanco
                                              ),
                                              DropdownMenuItem(
                                                value: 'ubicacion2',
                                                child: Text('Ubicación 2',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ],
                                            onChanged: (value) {},
                                          ),
                                        )
                                      ]),
                                  const SizedBox(height: 10),

                                  // Estado ************************************************
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Estado:',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(width: 40),
                                        SizedBox(
                                          width: 550,
                                          child: DropdownButtonFormField(
                                            decoration: const InputDecoration(
                                              hintText: 'Estado',
                                              hintStyle: TextStyle(
                                                  color: Colors
                                                      .white54), // Color de la etiqueta
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .white), // Borde blanco
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .purple), // Borde al seleccionar
                                              ),
                                            ),
                                            dropdownColor: const Color(
                                                0xFF2B193E), // Fondo del desplegable
                                            style: const TextStyle(
                                                color: Colors
                                                    .white), // Color del texto seleccionado
                                            items: const [
                                              DropdownMenuItem(
                                                value: 'estado1',
                                                child: Text('Estado 1',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white)), // Texto blanco
                                              ),
                                              DropdownMenuItem(
                                                value: 'estado2',
                                                child: Text('Estado 2',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ],
                                            onChanged: (value) {},
                                          ),
                                        )
                                      ]),
                                  const SizedBox(height: 30),

                                  // Guardar ************************************************
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(
                                          0xFF9576DA), // Fondo del botón
                                      foregroundColor:
                                          Colors.white, // Color del texto
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                    ),
                                    child: const Text('Guardar'),
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
