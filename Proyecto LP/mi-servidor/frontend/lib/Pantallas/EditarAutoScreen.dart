import 'dart:convert';
import 'dart:typed_data';
import 'package:frontend/Pantallas/MainScreen.dart';
import 'package:frontend/Pantallas/MisAutosScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../Configuraciones/Usuario.dart';
import '../Configuraciones/ApiServicio.dart';
import '../Configuraciones/FirebaseStorageService.dart';
import '../Configuraciones/VerificacionesHelper.dart';
import 'package:frontend/Widgets/SnackBarHelper.dart';

import '../Enums/Estado.dart';
import "../Enums/MarcaDeAuto.dart";
import '../Enums/Tipo.dart';
import "../Enums/Motor.dart";
import '../Enums/Transmision.dart';
import "../Enums/Ubicacion.dart";

// Editar Autos
class EditarAutoScreen extends StatefulWidget {
  final Map<String, dynamic> auto;

  const EditarAutoScreen({Key? key, required this.auto}) : super(key: key);

  @override
  State<EditarAutoScreen> createState() => _EditarAutoScreenState();
}

class _EditarAutoScreenState extends State<EditarAutoScreen> {
  late Map<String, dynamic> auto;
  late List<String> _fotosSeleccionadas;

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
  List<Uint8List> _fotosSeleccionadas1 = [];
  int indiceActual = 0;

  List<String>? marcas;
  List<String>? modelos;
  List<String>? tipos;
  List<String>? motor;
  List<String>? transmision;
  List<String>? ubicacion;
  List<String>? estados;

  bool isCargandoMarcas = true;
  bool isCargandoModelos = false;
  bool isCargandoTipos = true;
  bool isCargandoMotor = true;
  bool isCargandoTransmision = true;
  bool isCargandoUbicacion = true;
  bool isCargandoEstados = true;

  @override
  void initState() {
    super.initState();
    // Inicializar auto correctamente
    auto = widget.auto;

    placaController.text = auto['placa'] ?? '';
    precioController.text = auto['precio']?.toString() ?? '';
    anioController.text = auto['anio']?.toString() ?? '';
    kilometrajeController.text = auto['kilometraje']?.toString() ?? '';
    pesoController.text = auto['peso']?.toString() ?? '';

    cargarMarcas();
    cargarModelos(auto['marca']);
    cargarTipos();
    cargarMotor();
    cargarTransmision();
    cargarUbicacion();
    cargarEstados();

    _fotosSeleccionadas = List<String>.from(widget.auto['fotos'] ?? []);
  }

  List<dynamic> getListaCombinada() {
    return [..._fotosSeleccionadas, ..._fotosSeleccionadas1];
  }

  Future<void> cargarMarcas() async {
    try {
      final listaMarcas = await ApiServicio.obtenerMarcas();
      setState(() {
        marcas = listaMarcas.toSet().toList(); // Elimina duplicados
        isCargandoMarcas = false;

        // Convertir a minúsculas para comparación
        String marcaAuto = auto['marca']?.toLowerCase() ?? '';

        // Buscar la marca en la lista (también en minúsculas)
        marcaSeleccionada = marcas?.firstWhere(
            (marca) => marca.toLowerCase() == marcaAuto,
            orElse: () => marcas!.isNotEmpty
                ? marcas!.first
                : '' // Si no se encuentra, selecciona la primera marca
            );
      });
    } catch (e) {
      print('Error al cargar marcas: $e');
      setState(() => isCargandoMarcas = false);
    }
  }

  Future<void> cargarModelos(String marca) async {
    try {
      final listaModelos = await ApiServicio.obtenerModelos(marca);
      setState(() {
        modelos = listaModelos.toSet().toList(); // Elimina duplicados
        isCargandoModelos = false;

        // Convertir a minúsculas para comparación
        String modeloAuto = auto['modelo']?.toLowerCase() ?? '';

        modeloSeleccionado = modelos?.firstWhere(
            (modelo) => modelo.toLowerCase() == modeloAuto,
            orElse: () => modelos!.isNotEmpty ? modelos!.first : '');
      });
    } catch (e) {
      print('Error al cargar modelos: $e');
      setState(() => isCargandoModelos = false);
    }
  }

  Future<void> cargarTipos() async {
    setState(() => isCargandoTipos = true);
    try {
      final listaTipos = await ApiServicio.obtenerTipos();
      setState(() {
        tipos = listaTipos.toSet().toList(); // Elimina duplicados
        isCargandoTipos = false;

        // Convertir a minúsculas para comparación
        String tipoAuto = auto['tipo']?.toLowerCase() ?? '';

        tipoSeleccionado = tipos?.firstWhere(
            (tipo) => tipo.toLowerCase() == tipoAuto,
            orElse: () => tipos!.isNotEmpty ? tipos!.first : '');
      });
    } catch (e) {
      print('Error al cargar tipos: $e');
      setState(() => isCargandoTipos = false);
    }
  }

  Future<void> cargarMotor() async {
    setState(() => isCargandoMotor = true);
    try {
      final listaMotor = await ApiServicio.obtenerMotor();
      setState(() {
        motor = listaMotor.toSet().toList(); // Elimina duplicados
        isCargandoMotor = false;

        // Convertir a minúsculas para comparación
        String motorAuto = auto['motor']?.toLowerCase() ?? '';

        motorSeleccionado = motor?.firstWhere(
            (motor) => motor.toLowerCase() == motorAuto,
            orElse: () => motor!.isNotEmpty ? motor!.first : '');
      });
    } catch (e) {
      print('Error al cargar motores: $e');
      setState(() => isCargandoMotor = false);
    }
  }

  Future<void> cargarTransmision() async {
    setState(() => isCargandoTransmision = true);
    try {
      final listaTransmision = await ApiServicio.obtenerTransmision();
      setState(() {
        transmision = listaTransmision.toSet().toList(); // Elimina duplicados
        isCargandoTransmision = false;

        // Convertir a minúsculas para comparación
        String transmisionAuto = auto['transmision']?.toLowerCase() ?? '';

        transmisionSeleccionada = transmision?.firstWhere(
            (transmision) => transmision.toLowerCase() == transmisionAuto,
            orElse: () => transmision!.isNotEmpty ? transmision!.first : '');
      });
    } catch (e) {
      print('Error al cargar transmisiones: $e');
      setState(() => isCargandoTransmision = false);
    }
  }

  Future<void> cargarUbicacion() async {
    setState(() => isCargandoUbicacion = true);
    try {
      final listaUbicacion = await ApiServicio.obtenerUbicacion();
      setState(() {
        ubicacion = listaUbicacion.toSet().toList(); // Elimina duplicados
        isCargandoUbicacion = false;

        // Convertir a minúsculas para comparación
        String ubicacionAuto = auto['ubicacion']?.toLowerCase() ?? '';

        ubicacionSeleccionada = ubicacion?.firstWhere(
            (ubicacion) => ubicacion.toLowerCase() == ubicacionAuto,
            orElse: () => ubicacion!.isNotEmpty ? ubicacion!.first : '');
      });
    } catch (e) {
      print('Error al cargar ubicaciones: $e');
      setState(() => isCargandoUbicacion = false);
    }
  }

  Future<void> cargarEstados() async {
    setState(() => isCargandoEstados = true);
    try {
      final listaEstados = await ApiServicio.obtenerEstados();
      setState(() {
        estados = listaEstados.toSet().toList(); // Elimina duplicados
        isCargandoEstados = false;

        // Convertir a minúsculas para comparación
        String estadoAuto = auto['estado']?.toLowerCase() ?? '';

        estadoSeleccionado = estados?.firstWhere(
            (estado) => estado.toLowerCase() == estadoAuto,
            orElse: () => estados!.isNotEmpty ? estados!.first : '');
      });
    } catch (e) {
      print('Error al cargar estados: $e');
      setState(() => isCargandoEstados = false);
    }
  }

  Future<void> seleccionarFotos() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image, // Asegura que solo seleccione imágenes
      );

      if (result != null &&
          result.files.isNotEmpty &&
          result.files.single.bytes != null) {
        print(getListaCombinada().length);
        setState(() {
          _fotosSeleccionadas1 = List.from(_fotosSeleccionadas1)
            ..add(result.files.single.bytes!);
        });

        print("Imagen añadida correctamente.");

        print(getListaCombinada().length);
      } else {
        print("No se seleccionó ninguna imagen.");
      }
    } catch (e) {
      print("Error al seleccionar la imagen: $e");
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
      if (indiceActual < getListaCombinada().length - 1) {
        indiceActual++;
      }
    });
  }

  void eliminarImagenActual() {
    setState(() {
      int totalImagenes =
          _fotosSeleccionadas.length + _fotosSeleccionadas1.length;
      if (indiceActual >= _fotosSeleccionadas.length) {
        _fotosSeleccionadas1
            .removeAt(indiceActual - _fotosSeleccionadas.length);
      } else if (indiceActual < _fotosSeleccionadas.length) {
        _fotosSeleccionadas.removeAt(indiceActual);
      } else {
        SnackBarHelper.showSnackBar(
            context, "¡No hay imagenes que borrar!", Colors.grey);
      }
      // Ajustar el índice si es necesario
      if (indiceActual >= totalImagenes - 1 && indiceActual > 0) {
        indiceActual--;
      }
    });
  }

  bool validarYVerificar(BuildContext context, String placa, String precioTxt,
      String anioTxt, String kilometrajeTxt, String pesoTxt) {
    double? precio = double.tryParse(precioTxt);
    int? anio = int.tryParse(anioTxt);
    int? kilometraje = int.tryParse(kilometrajeTxt);
    double? peso = double.tryParse(pesoTxt);

    if (precio == null || anio == null || kilometraje == null || peso == null) {
      SnackBarHelper.showSnackBar(context,
          "Todos los valores numéricos deben ser números válidos.", Colors.red);
    }

    bool datosValidos = VerificacionesHelper.verificarDatos(
        context, placa, precio, anio, kilometraje, peso);
    if (datosValidos) {
      print("✅ Datos válidos, proceder con el proceso.");
      return true;
    }

    return false;
  }

  Future<void> actualizarAuto() async {
    // Capturar valores desde los controladores y Dropdown
    String placa = placaController.text.trim().toUpperCase();
    double? precio = double.tryParse(precioController.text.trim());
    String? marca = MarcaDeAutoEnum.getBackendValue(marcaSeleccionada);
    String? modelo = modeloSeleccionado;
    String? tipo = Tipo.getBackendValue(tipoSeleccionado);
    int? anio = int.tryParse(anioController.text.trim());
    int? kilometraje = int.tryParse(kilometrajeController.text.trim());
    String? motor = Motor.getBackendValue(motorSeleccionado);
    String? transmision = Transmision.getBackendValue(transmisionSeleccionada);
    double? peso = double.tryParse(pesoController.text.trim());
    String? ubicacion = Ubicacion.getBackendValue(ubicacionSeleccionada);
    String? estado = EstadoEnum.getBackendValue(estadoSeleccionado);
    String? usuario = Usuario.instancia.getCorreo;

    if (marca == null ||
        modelo == null ||
        tipo == null ||
        motor == null ||
        transmision == null ||
        ubicacion == null ||
        estado == null) {
      SnackBarHelper.showSnackBar(
          context, 'Por favor completa todos los campos.', Colors.blueGrey);
      return;
    }

    if (estado.toLowerCase() == 'nuevo' && kilometraje! > 1000) {
      SnackBarHelper.showSnackBar(
          context,
          'El kilometraje no puede ser mayor 1000 si el auto es nuevo!',
          Colors.red);
      return;
    }

    if (getListaCombinada().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Por favor selecciona al menos una imagen.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Por favor espere"),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 4),
      ),
    );

    FirebaseStorageService storageService = FirebaseStorageService();
    List<String> urls = await storageService.subirFotos(_fotosSeleccionadas1);
    if (_fotosSeleccionadas1.isNotEmpty) {
      if (urls.isEmpty) {
        SnackBarHelper.showSnackBar(
            context, 'Error al subir imágenes.', Colors.red);
        return;
      }
    }

    if (auto['placa'] != placa) {
      SnackBarHelper.showSnackBar(
          context,
          'No puedes cambiarle la placa a un auto. Para ello, crea uno nuevo!',
          Colors.red);
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
      'fotos': _fotosSeleccionadas + urls,
    };

    bool exito = await ApiServicio.actualizarAuto(autoData);

    if (exito) {
      SnackBarHelper.showSnackBar(
          context, 'Auto actualizado exitosamente.', Colors.green);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MisAutosScreen()),
      );
    } else {
      SnackBarHelper.showSnackBar(
          context, 'Error al actualizar el auto.', Colors.red);
    }
  }

  Future<void> eliminarAuto() async {
    String placa = placaController.text.trim().toUpperCase();

    if (auto['placa'] != placa) {
      SnackBarHelper.showSnackBar(
          context,
          'No puedes cambiarle la placa a un auto. Para ello, crea uno nuevo!',
          Colors.red);
      return;
    }

    bool exito = await ApiServicio.eliminarAuto(placa);

    if (exito) {
      SnackBarHelper.showSnackBar(
          context, 'Auto eliminado exitosamente.', Colors.green);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else {
      SnackBarHelper.showSnackBar(
          context, 'Error al eliminar el auto.', Colors.red);
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
                  'Bienvenido al editor de vehículos, ${Usuario.instancia.getNombre}!',
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
            Flexible(
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
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap:
                                            eliminarImagenActual, // Llama al método modular
                                        child: Image.network(
                                          'https://i.postimg.cc/y6gjPyff/Trash.png',
                                          fit: BoxFit
                                              .contain, // Ajusta la imagen dentro del área
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 50),

                                  // Carga tu imagen ************************************************
                                  ElevatedButton(
                                    onPressed: seleccionarFotos,
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

                              //Presentación de imagenes
                              Stack(children: [
                                SizedBox(
                                  width: 650,
                                  height: 576,
                                  child: getListaCombinada().isNotEmpty
                                      ? getListaCombinada()[indiceActual]
                                              is String
                                          ? Image.network(
                                              getListaCombinada()[
                                                  indiceActual], // URL
                                              fit: BoxFit.contain,
                                            )
                                          : Image.memory(
                                              getListaCombinada()[
                                                  indiceActual], // Uint8List (foto nueva)
                                              fit: BoxFit.contain,
                                            )
                                      : const Image(
                                          image: NetworkImage(
                                              'https://i.postimg.cc/qRYLrN7X/preview.png'), // Placeholder
                                          fit: BoxFit.contain,
                                        ),
                                ),
                              ]),

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
                                    getListaCombinada().isNotEmpty
                                        ? '${indiceActual + 1} / ${getListaCombinada().length}'
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
                                            getListaCombinada().length - 1) {
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
                                        SizedBox(
                                          width: 550,
                                          child: TextFormField(
                                            controller: placaController,
                                            decoration: const InputDecoration(
                                                hintText: 'Ej.: ABC123',
                                                hintStyle: TextStyle(
                                                    color: Colors.white54)),
                                            style: const TextStyle(
                                                color: Colors
                                                    .white), // Color del texto ingresado
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),

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
                                        SizedBox(
                                          width: 550,
                                          child: TextFormField(
                                            controller: precioController,
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
                                    const SizedBox(height: 5),

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
                                          isCargandoMarcas
                                              ? const CircularProgressIndicator()
                                              : SizedBox(
                                                  width: 550,
                                                  child:
                                                      DropdownButtonFormField<
                                                          String>(
                                                    value: marcaSeleccionada,
                                                    items: marcas?.map((marca) {
                                                      return DropdownMenuItem(
                                                        value: marca,
                                                        child: Text(
                                                          marca,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white), // Pone el texto en blanco
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        marcaSeleccionada =
                                                            value;
                                                        cargarModelos(
                                                            marcaSeleccionada!);
                                                      });
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: "Marca",
                                                      labelStyle: TextStyle(
                                                          color: Colors
                                                              .white), // Color de la etiqueta
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .white), // Borde blanco
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .purple), // Borde al seleccionar
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white), // Color del texto seleccionado
                                                    dropdownColor: const Color(
                                                        0xFF2B193E), // Fondo del desplegable
                                                  ),
                                                ),
                                        ]),
                                    const SizedBox(height: 5),

                                    // Modelo ************************************************
                                    if (marcaSeleccionada != null)
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
                                            isCargandoModelos
                                                ? const CircularProgressIndicator()
                                                : SizedBox(
                                                    width: 550,
                                                    child:
                                                        DropdownButtonFormField<
                                                            String>(
                                                      value: modeloSeleccionado,
                                                      items: modelos
                                                          ?.map((modelo) {
                                                        return DropdownMenuItem(
                                                          value: modelo,
                                                          child: Text(
                                                            modelo,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white), // Pone el texto en blanco
                                                          ),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          modeloSeleccionado =
                                                              value;
                                                        });
                                                      },
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText: "Modelo",
                                                        labelStyle: TextStyle(
                                                            color: Colors
                                                                .white), // Etiqueta blanca
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .white), // Borde blanco
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .purple), // Borde al seleccionar
                                                        ),
                                                      ),
                                                      style: TextStyle(
                                                          color: Colors
                                                              .white), // Texto en blanco
                                                      dropdownColor: const Color(
                                                          0xFF2B193E), // Fondo del desplegable
                                                    ),
                                                  ),
                                          ]),
                                    const SizedBox(height: 5),

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
                                          isCargandoTipos
                                              ? const CircularProgressIndicator()
                                              : SizedBox(
                                                  width: 550,
                                                  child:
                                                      DropdownButtonFormField<
                                                          String>(
                                                    value: tipoSeleccionado,
                                                    items: tipos?.map((tipo) {
                                                      return DropdownMenuItem(
                                                        value: tipo,
                                                        child: Text(
                                                          tipo,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white), // Texto blanco
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        tipoSeleccionado =
                                                            value;
                                                      });
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: "Tipo",
                                                      labelStyle: TextStyle(
                                                          color: Colors
                                                              .white), // Etiqueta blanca
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .white), // Borde blanco
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .purple), // Borde al seleccionar
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white), // Texto en blanco
                                                    dropdownColor: const Color(
                                                        0xFF2B193E), // Fondo del desplegable
                                                  ),
                                                ),
                                        ]),
                                    const SizedBox(height: 5),

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
                                        SizedBox(
                                          width: 550,
                                          child: TextFormField(
                                            controller: anioController,
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
                                    const SizedBox(height: 5),

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
                                        SizedBox(
                                          width: 550,
                                          child: TextFormField(
                                            controller: kilometrajeController,
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
                                    const SizedBox(height: 5),

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
                                          isCargandoMotor
                                              ? const CircularProgressIndicator()
                                              : SizedBox(
                                                  width: 550,
                                                  child:
                                                      DropdownButtonFormField<
                                                          String>(
                                                    value: motorSeleccionado,
                                                    items: motor?.map((m) {
                                                      return DropdownMenuItem(
                                                        value: m,
                                                        child: Text(
                                                          m,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white), // Texto blanco
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        motorSeleccionado =
                                                            value;
                                                      });
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: "Motor",
                                                      labelStyle: TextStyle(
                                                          color: Colors
                                                              .white), // Etiqueta blanca
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .white), // Borde blanco
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .purple), // Borde al seleccionar
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white), // Texto en blanco
                                                    dropdownColor: const Color(
                                                        0xFF2B193E), // Fondo del desplegable
                                                  ),
                                                ),
                                        ]),
                                    const SizedBox(height: 5),

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
                                          isCargandoTransmision
                                              ? const CircularProgressIndicator()
                                              : SizedBox(
                                                  width: 550,
                                                  child:
                                                      DropdownButtonFormField<
                                                          String>(
                                                    value:
                                                        transmisionSeleccionada,
                                                    items:
                                                        transmision?.map((t) {
                                                      return DropdownMenuItem(
                                                        value: t,
                                                        child: Text(
                                                          t,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white), // Texto blanco
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        transmisionSeleccionada =
                                                            value;
                                                      });
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: "Transmisión",
                                                      labelStyle: TextStyle(
                                                          color: Colors
                                                              .white), // Etiqueta blanca
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .white), // Borde blanco
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .purple), // Borde al seleccionar
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white), // Texto en blanco
                                                    dropdownColor: const Color(
                                                        0xFF2B193E), // Fondo del desplegable
                                                  ),
                                                ),
                                        ]),
                                    const SizedBox(height: 5),

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
                                        SizedBox(
                                          width: 550,
                                          child: TextFormField(
                                            controller: pesoController,
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
                                    const SizedBox(height: 5),

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
                                          isCargandoUbicacion
                                              ? const CircularProgressIndicator()
                                              : SizedBox(
                                                  width: 550,
                                                  child:
                                                      DropdownButtonFormField<
                                                          String>(
                                                    value:
                                                        ubicacionSeleccionada,
                                                    items: ubicacion?.map((u) {
                                                      return DropdownMenuItem(
                                                        value: u,
                                                        child: Text(
                                                          u,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white), // Texto blanco
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        ubicacionSeleccionada =
                                                            value;
                                                      });
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: "Ubicación",
                                                      labelStyle: TextStyle(
                                                          color: Colors
                                                              .white), // Etiqueta blanca
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .white), // Borde blanco
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .purple), // Borde al seleccionar
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white), // Texto en blanco
                                                    dropdownColor: const Color(
                                                        0xFF2B193E), // Fondo del desplegable
                                                  ),
                                                ),
                                        ]),
                                    const SizedBox(height: 5),

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
                                          isCargandoEstados
                                              ? const CircularProgressIndicator()
                                              : SizedBox(
                                                  width: 550,
                                                  child:
                                                      DropdownButtonFormField<
                                                          String>(
                                                    value: estadoSeleccionado,
                                                    items: estados?.map((e) {
                                                      return DropdownMenuItem(
                                                        value: e,
                                                        child: Text(
                                                          e,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white), // Texto blanco
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        estadoSeleccionado =
                                                            value;
                                                      });
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: "Estado",
                                                      labelStyle: TextStyle(
                                                          color: Colors
                                                              .white), // Etiqueta blanca
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .white), // Borde blanco
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .purple), // Borde al seleccionar
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white), // Texto en blanco
                                                    dropdownColor: const Color(
                                                        0xFF2B193E), // Fondo del desplegable
                                                  ),
                                                ),
                                        ]),
                                    const SizedBox(height: 10),

                                    // Guardar ************************************************
                                    ElevatedButton(
                                      onPressed: () {
                                        bool datosValidos = validarYVerificar(
                                          context,
                                          placaController.text,
                                          precioController.text,
                                          anioController.text,
                                          kilometrajeController.text,
                                          pesoController.text,
                                        );

                                        if (datosValidos) {
                                          actualizarAuto(); // Solo se ejecuta si los datos son válidos
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF9576DA),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                      ),
                                      child: const Text('Guardar'),
                                    ),
                                    const SizedBox(height: 5),
                                    // ELIMINAR AUTO ************************************************
                                    ElevatedButton(
                                      onPressed: eliminarAuto,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF9576DA),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                      ),
                                      child: const Text('Eliminar Auto'),
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
