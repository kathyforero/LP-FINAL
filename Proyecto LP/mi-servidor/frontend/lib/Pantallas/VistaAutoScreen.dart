import 'package:flutter/material.dart';
import '../Enums/Ubicacion.dart';
import '../Enums/MarcaDeAuto.dart';
import '../Enums/Estado.dart';
import '../Enums/Tipo.dart';
import '../Enums/Transmision.dart';
import '../Enums/Motor.dart';
import '../Configuraciones/Usuario.dart';


// Crear Autos
class VistaAutoScreen extends StatefulWidget {
  
  final Map<String, dynamic> auto;

  const VistaAutoScreen({Key? key, required this.auto}) : super(key: key);

  @override
  State<VistaAutoScreen> createState() => _VistaAutoScreenState();
}

class _VistaAutoScreenState extends State<VistaAutoScreen> {
 
  late Map<String, dynamic> auto;
  late List<String> _fotosSeleccionadas;

  int indiceActual = 0;

  @override
  void initState() {
    super.initState();
    auto = widget.auto;
    _fotosSeleccionadas = List<String>.from(widget.auto['fotos'] ?? []);
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
                  'Bienvenido al visor de vehículos, ${Usuario.instancia.getNombre}!',
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
                              // Subido por
                              Text(
                              'Subido por: ${auto['usuario']}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 211, 208),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                              SizedBox(height: 10),

                              //Presentación de imagenes
                              SizedBox(
                                width: 650,
                                height: 576,
                                child: _fotosSeleccionadas.isNotEmpty
                                    ? Image.network(
                                      _fotosSeleccionadas[indiceActual],
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
                                    cursor: SystemMouseCursors
                                        .click, // Cambia el cursor a mano
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
                                    cursor: SystemMouseCursors
                                        .click, // Cambia el cursor a mano
                                    child: GestureDetector(
                                      onTap: () {
                                        if (indiceActual <
                                            _fotosSeleccionadas.length - 1) {
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Placa:',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(width: 40),
                                        // INFO PLACA
                                        Text(
                                          '${auto['placa']}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),

                                    // Precio ************************************************
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Precio:',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(width: 40),
                                        // INFO PRECIO
                                        Text(
                                          '${auto['precio']}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
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
                                          // INFO MARCA
                                          Text(
                                              auto['marca'] != null
                                              ? MarcaDeAutoEnum.getDisplayName(auto['marca']) ?? 'Estado desconocido'
                                              : 'Estado desconocido',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
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
                                            // INFO MODELO
                                            Text(
                                              '${auto['modelo']}',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
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
                                          // INFO TIPO
                                          Text(
                                              auto['tipo'] != null
                                                ? Tipo.getDisplayName(auto['tipo']) ?? 'Tipo desconocido'
                                                : 'Tipo desconocido',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                        ]),
                                    const SizedBox(height: 10),

                                    // Año ************************************************
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Año:',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(width: 40),
                                        // INFO AÑO
                                        Text(
                                          '${auto['anio']}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),

                                    // Kilometraje ************************************************
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Kilometraje:',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(width: 40),
                                        // INFO KILOMETRAJE
                                         Text(
                                          '${auto['kilometraje']}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
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
                                          // INFO MOTOR
                                          Text(
                                            auto['motor'] != null
                                              ? Motor.getDisplayName(auto['motor']) ?? 'Motor desconocido'
                                              : 'Motor desconocido',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
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
                                          // INFO TRANSMISIÓN
                                          Text(
                                            auto['transmision'] != null
                                              ? Transmision.getDisplayName(auto['transmision']) ?? 'Transmisión desconocida'
                                              : 'Transmisión desconocida',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ]),
                                    const SizedBox(height: 10),

                                    // Peso ************************************************
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Peso:',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(width: 40),
                                        // INFO PESO
                                        Text(
                                          '${auto['peso']}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
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
                                          // INFO UBICACIÓN
                                          Text(
                                            auto['ubicacion'] != null
                                                  ? Ubicacion.getDisplayName(auto['ubicacion']) ?? 'Ubicación desconocida'
                                                  : 'Ubicación desconocida',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
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
                                          // INFO ESTADOS
                                          Text(
                                            auto['estado'] != null
                                              ? EstadoEnum.getDisplayName(auto['estado']) ?? 'Estado desconocido'
                                              : 'Estado desconocido',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ]),
                                    const SizedBox(height: 30),                                    
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