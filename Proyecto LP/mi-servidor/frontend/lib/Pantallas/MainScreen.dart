import 'package:flutter/material.dart';
import '../Configuraciones/Usuario.dart';
import 'CrearAutoScreen.dart';
import 'VistaAutoScreen.dart';
import '../Widgets/MyPopUpMenu.dart';
import '../Configuraciones/ApiServicio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import "../Enums/Ubicacion.dart";
import "../Enums/MarcaDeAuto.dart";

// Pantalla principal (nueva)
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? _marcaSeleccionada;
  String? _modeloSeleccionado;
  String? _tipoSeleccionado;

  final TextEditingController _controladorKmDesde = TextEditingController();
  final TextEditingController _controladorKmHasta = TextEditingController();
  final TextEditingController _controladorPrecioDesde = TextEditingController();
  final TextEditingController _controladorPrecioHasta = TextEditingController();

  bool isLoading = true; // Bandera para verificar si está cargando
  String? nombreUsuario;

  List<String>? marcas;
  Map<String, List<String>> modelosPorMarca = {};
  List<String>? tipos;

  bool isCargandoMarcas = true;
  bool isCargandoModelos = false;
  bool isCargandoTipos = true;

  @override
  void initState() {
    super.initState();
    cargarUsuario();
    cargarMarcas();
    cargarTipos();
  }

  Future<void> cargarUsuario() async {
    // Simula tiempo de carga o espera a datos válidos
    await Future.delayed(const Duration(seconds: 1));
    final nombre = Usuario.instancia.getNombre;

    if (mounted) {
      setState(() {
        nombreUsuario = nombre ?? "Invitado"; // Si es null, muestra "Invitado"
        isLoading = false; // Indica que la carga ha terminado
      });
    }
  }

  Future<void> cargarMarcas() async {
    try {
      final listaMarcas = await ApiServicio.obtenerMarcas();
      setState(() {
        marcas = listaMarcas;
        isCargandoMarcas = false;
      });
    } catch (e) {
      print('Error al cargar marcas: $e');
      setState(() => isCargandoMarcas = false);
    }
  }

  Future<void> cargarModelos(String marca) async {
    if (modelosPorMarca.containsKey(marca))
      return; // Si ya existen, no volver a cargar
    setState(() => isCargandoModelos = true);
    try {
      final listaModelos = await ApiServicio.obtenerModelos(marca);
      setState(() {
        modelosPorMarca[marca] = listaModelos;
        isCargandoModelos = false;
      });
    } catch (e) {
      print('Error al cargar modelos para $marca: $e');
      setState(() => isCargandoModelos = false);
    }
  }

  Future<void> cargarTipos() async {
    setState(() => isCargandoTipos = true);
    try {
      final listaTipos = await ApiServicio.obtenerTipos();
      setState(() {
        tipos = listaTipos;
        isCargandoTipos = false;
      });
    } catch (e) {
      print('Error al cargar tipos: $e');
      setState(() => isCargandoTipos = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
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
              isLoading
                  ? const Text(
                      'Cargando...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Calibri Light',
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Text(
                      'Bienvenido, $nombreUsuario!',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Calibri Light',
                        fontWeight: FontWeight.bold,
                      ),
                    ),

              // Botones en el lado derecho
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Aquí navegas a la pantalla NuevaPantalla
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CrearAutoScreen()), // Reemplaza NuevaPantalla con tu clase de pantalla
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF9576DA), // Fondo del botón
                      foregroundColor: Colors.white, // Color del texto
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    child: const Text('Vende tu vehículo'),
                  ),
                  const SizedBox(width: 10),
                  MyPopupMenu(),
                ],
              )
            ],
          )),
      body: Row(
        children: [
          // Left filter panel
          Container(
            width: 250,
            color: const Color(0xFF2B193E),
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centra verticalmente
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Centra horizontalmente
                children: [
                  const Text(
                    'Filtros',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  isCargandoMarcas
                      ? const CircularProgressIndicator()
                      : DropdownButtonFormField<String>(
                          value: _marcaSeleccionada,
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
                              _marcaSeleccionada = value;
                              cargarModelos(value!);
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: "Marca",
                            labelStyle: TextStyle(
                                color: Colors.white), // Color de la etiqueta
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white), // Borde blanco
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.purple), // Borde al seleccionar
                            ),
                          ),
                          style: TextStyle(
                              color:
                                  Colors.white), // Color del texto seleccionado
                          dropdownColor:
                              const Color(0xFF2B193E), // Fondo del desplegable
                        ),
                  const SizedBox(height: 10),
                  if (_marcaSeleccionada != null)
                    isCargandoModelos
                        ? const CircularProgressIndicator()
                        : DropdownButtonFormField<String>(
                            value: _modeloSeleccionado,
                            items: (_marcaSeleccionada != null &&
                                    modelosPorMarca
                                        .containsKey(_marcaSeleccionada))
                                ? modelosPorMarca[_marcaSeleccionada]!
                                    .map((modelo) {
                                    return DropdownMenuItem(
                                      value: modelo,
                                      child: Text(
                                        modelo,
                                        style: TextStyle(
                                            color:
                                                Colors.white), // Texto blanco
                                      ),
                                    );
                                  }).toList()
                                : [],
                            onChanged: (value) {
                              setState(() {
                                _modeloSeleccionado = value;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: "Modelo",
                              labelStyle: TextStyle(
                                  color: Colors.white), // Etiqueta blanca
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white), // Borde blanco
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Colors.purple), // Borde al seleccionar
                              ),
                            ),
                            style: TextStyle(
                                color: Colors.white), // Texto en blanco
                            dropdownColor: const Color(
                                0xFF2B193E), // Fondo del desplegable
                          ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: _controladorKmDesde,
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
                          controller: _controladorKmHasta,
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
                          controller: _controladorPrecioDesde,
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
                          controller: _controladorPrecioHasta,
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
                  isCargandoTipos
                      ? const CircularProgressIndicator()
                      : DropdownButtonFormField<String>(
                          value: _tipoSeleccionado,
                          items: tipos?.map((tipo) {
                            return DropdownMenuItem(
                              value: tipo,
                              child: Text(
                                tipo,
                                style: TextStyle(
                                    color: Colors.white), // Texto blanco
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _tipoSeleccionado = value;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: "Tipo",
                            labelStyle: TextStyle(
                                color: Colors.white), // Etiqueta blanca
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white), // Borde blanco
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.purple), // Borde al seleccionar
                            ),
                          ),
                          style:
                              TextStyle(color: Colors.white), // Texto en blanco
                          dropdownColor:
                              const Color(0xFF2B193E), // Fondo del desplegable
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
                  MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            setState(() {
                              _marcaSeleccionada =
                                  null; // Restablecer marca seleccionada
                              _modeloSeleccionado = null;
                              _tipoSeleccionado =
                                  null; // Restablecer modelo seleccionado
                              _controladorKmDesde.clear();
                              _controladorKmHasta.clear();
                              _controladorPrecioDesde.clear();
                              _controladorPrecioHasta
                                  .clear(); // Limpiar el TextFormField
                            });
                          });
                        },
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
                      )),
                ],
              ),
            ),
          ),

          // Main content
          Expanded(
            child: Column(
              children: [
                // Sorting row
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: SizedBox(
                          width: 200,
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                              labelText: 'Ordenar por:',
                              labelStyle: TextStyle(
                                  color: Colors.white), // Color de la etiqueta
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white), // Borde blanco
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Colors.purple), // Borde al seleccionar
                              ),
                            ),
                            dropdownColor: const Color(
                                0xFF2B193E), // Fondo del desplegable
                            style: const TextStyle(
                                color: Colors
                                    .white), // Color del texto seleccionado
                            items: const [
                              DropdownMenuItem(
                                value: 'criterio1',
                                child: Text('Precio',
                                    style: TextStyle(
                                        color: Colors.white)), // Texto blanco
                              ),
                              DropdownMenuItem(
                                value: 'criterio2',
                                child: Text('Kilometraje',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Aplicar'),
                      ),
                    ],
                  ),
                ),

                // Vehicle grid
                FutureBuilder<List<Map<String, dynamic>>?>(
                  future: ApiServicio.obtenerTodosLosAutos(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError || snapshot.data == null) {
                      return const Center(
                          child: Text("Error al cargar los autos"));
                    }

                    final autos = snapshot.data!;

                    return Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          const double itemWidth = 200;
                          const double itemHeight = 300;
                          int crossAxisCount =
                              (constraints.maxWidth / itemWidth).floor();

                          return GridView.builder(
                            padding: const EdgeInsets.all(16.0),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: itemWidth / itemHeight,
                            ),
                            itemCount: autos.length,
                            itemBuilder: (context, index) {
                              final auto = autos[index];

                              return MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          VistaAutoScreen(auto: auto),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  height: itemHeight,
                                  child: Card(
                                    color: const Color(0xFF2B193E),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                    top: Radius.circular(12)),
                                            child: SizedBox(
                                                height: 120,
                                                width: double.infinity,
                                                child: Image.network(
                                                  '${auto['fotos'][0]}',
                                                  fit: BoxFit.contain,
                                                  loadingBuilder: (context, child, loadingProgress) {
                                                    if (loadingProgress == null) return child;
                                                    return Center(child: CircularProgressIndicator());
                                                  },
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Icon(Icons.error, size: 50, color: Colors.red);
                                                  },
                                                ),)),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                auto['marca'] != null
                                                ? MarcaDeAutoEnum.getDisplayName(auto['marca']) != null
                                                    ? "${MarcaDeAutoEnum.getDisplayName(auto['marca'])} ${auto['modelo']}"
                                                    : 'Marca desconocida'
                                                : 'Marca desconocida',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '${auto['anio']} - ${auto['kilometraje']} km',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                auto['ubicacion'] != null
                                                  ? Ubicacion.getDisplayName(auto['ubicacion']) ?? 'Ubicación desconocida'
                                                  : 'Ubicación desconocida',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '\$${auto['precio']}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
