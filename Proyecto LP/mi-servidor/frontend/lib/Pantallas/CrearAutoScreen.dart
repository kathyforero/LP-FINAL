import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../Configuraciones/Usuario.dart';
import '../Configuraciones/FirebaseStorageService.dart';


// Crear Autos
class CrearAutoScreen extends StatefulWidget {  
  const CrearAutoScreen({super.key});

  

  @override
  State<CrearAutoScreen> createState() => _CrearAutoScreenState();
  }

  class _CrearAutoScreenState extends State<CrearAutoScreen> {
    final TextEditingController placaController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  final TextEditingController anioController = TextEditingController();
  final TextEditingController kilometrajeController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();

  // Variables para los valores seleccionados de los DropdownButton
  String? marcaSeleccionada;
  String? modeloSeleccionado;
  String? tipoSeleccionado;
  String? motorSeleccionado;
  String? transmisionSeleccionada;
  String? ubicacionSeleccionada;
  String? estadoSeleccionado;
    final List<Uint8List> _fotosSeleccionadas = [];
     int indiceActual = 0;
  
  @override
  void initState() {
    super.initState();
  }

  Future<void> seleccionarFotos() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _fotosSeleccionadas.add(result.files.single.bytes!);
        if (_fotosSeleccionadas.length == 1) {
          indiceActual = 0;
        }
      });
    }
  }

    	

  void imagenAnterior() {
    setState(() {
      if (indiceActual > 0) {
        indiceActual--;
      }
    });
  }

  void imagenSiguiente() {
    setState(() {
      if (indiceActual < _fotosSeleccionadas.length - 1) {
        indiceActual++;
      }
    });
  }
  

  Future<void> guardarAuto() async {
    if (_fotosSeleccionadas.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor selecciona al menos una imagen.')),
      );
      return;
    }

    FirebaseStorageService storageService = FirebaseStorageService();
    List<String> urls = await storageService.subirFotos(_fotosSeleccionadas);

    if (urls.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al subir imágenes.')),
      );
      return;
    }

    // Capturar valores desde los controladores y Dropdown
    String placa = placaController.text.trim();
    double? precio = double.tryParse(precioController.text.trim());
    String? marca = marcaSeleccionada;
    String? modelo = modeloSeleccionado;
    String? tipo = tipoSeleccionado;
    int? anio = int.tryParse(anioController.text.trim());
    int? kilometraje = int.tryParse(kilometrajeController.text.trim());
    String? motor = motorSeleccionado;
    String? transmision = transmisionSeleccionada;
    double? peso = double.tryParse(pesoController.text.trim());
    String? ubicacion = ubicacionSeleccionada;
    String? estado = estadoSeleccionado;
    String? usuario = Usuario.instancia.getCorreo;

    if (placa.isEmpty ||
        precio == null ||
        marca == null ||
        modelo == null ||
        tipo == null ||
        anio == null ||
        kilometraje == null ||
        motor == null ||
        transmision == null ||
        peso == null ||
        ubicacion == null ||
        estado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos.')),
      );
      return;
    }

    // Crear el JSON para enviar al backend
    Map<String, dynamic> autoData = {
      'placa': placa,
      'precio': precio,
      'marca': marca,
      'modelo': modelo,
      'tipo': tipo,
      'anio': anio,
      'kilometraje': kilometraje,
      'motor': motor,
      'transmision': transmision,
      'peso': peso,
      'ubicacion': ubicacion,
      'estado': estado,
      'usuario': usuario,
      'fotos': urls,
    };

    try {
      // Aquí puedes realizar el envío del auto al backend
      // Ejemplo usando HTTP
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/autos'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(autoData),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Auto guardado exitosamente.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al guardar el auto.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }


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
                  'Bienvenido al creador de vehículos, ${Usuario.instancia.getNombre}!',
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
                                    onPressed: seleccionarFotos,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF9576DA), // Fondo del botón
                                      foregroundColor: Colors.white, // Color del texto
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    ),
                                    child: const Text('Carga Tu Imagen'),
                                  ),
                                ],  
                              ),

                              SizedBox(height: 10),
                              
                              //Presentación de imagenes
                              SizedBox(
                                width: 650,
                                height: 576,
                                child: _fotosSeleccionadas.isNotEmpty
                                    ? Image.memory(
                                        _fotosSeleccionadas[indiceActual], // Muestra la imagen actual desde los bytes
                                        fit: BoxFit.contain,
                                      )
                                    : const Image(
                                        image: NetworkImage(
                                            'https://i.postimg.cc/qRYLrN7X/preview.png'), // Placeholder
                                        fit: BoxFit.contain,
                                      ),
                              ),



                              SizedBox(height: 10),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Boton izquierda ************************************************
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click, // Cambia el cursor a mano
                                    child: GestureDetector(
                                      onTap: () {
                                        if (indiceActual > 0) {
                                          imagenAnterior();
                                        }
                                      },
                                      child: Image(
                                        width: 50,
                                        height: 50,
                                        image: NetworkImage(
                                            'https://i.postimg.cc/bY7TFSWq/izquierda.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 30),

                                  
                                    Text(
                                      _fotosSeleccionadas.isNotEmpty
                                          ? '${indiceActual + 1} / ${_fotosSeleccionadas.length}'
                                          : '0/0',
                                      style: const TextStyle(
                                        fontFamily: 'Century Gothic',
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),

                                  SizedBox(width: 30),

                                  // Boton derecha ************************************************
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click, // Cambia el cursor a mano
                                    child: GestureDetector(
                                      onTap: () {
                                        if (indiceActual < _fotosSeleccionadas.length - 1) {
                                          imagenSiguiente();
                                        }
                                      },
                                      child: Image(
                                        width: 50,
                                        height: 50,
                                        image: NetworkImage(
                                            'https://i.postimg.cc/qM2LfMHy/derecha.png'),
                                        fit: BoxFit.contain,
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
                            child: SingleChildScrollView(
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
                                    onPressed: guardarAuto,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF9576DA),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    ),
                                    child: const Text('Guardar'),
                                  ),
                                ],
                              ),
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

