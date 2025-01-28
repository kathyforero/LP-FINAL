import 'package:flutter/material.dart';
import '../Configuraciones/Usuario.dart';
import 'CrearAutoScreen.dart';
import '../Widgets/MyPopUpMenu.dart';
import '../Configuraciones/ApiServicio.dart';

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

  @override
  void initState() {
    super.initState();
    cargarUsuario();
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
                  FutureBuilder<List<String>>(
                    // FutureBuilder para obtener los modelos desde la API
                    future: ApiServicio
                        .obtenerMarcas(), // Llamada al método obtenerModelos
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Mostrar indicador de carga mientras se esperan los datos
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        // Mostrar mensaje de error si ocurre un problema
                        return const Text(
                          'Error al cargar marcas',
                          style: TextStyle(color: Colors.white),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        // Manejar caso donde no hay datos
                        return const Text(
                          'No hay marcas disponibles',
                          style: TextStyle(color: Colors.white),
                        );
                      }

                      // Crear lista de DropdownMenuItem con los modelos obtenidos
                      List<DropdownMenuItem<String>> items = snapshot.data!
                          .map((marca) => DropdownMenuItem(
                                value: marca,
                                child: Text(
                                  marca,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ))
                          .toList();
                      return DropdownButtonFormField(
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
                            color:
                                Colors.white), // Color del texto seleccionado
                        value: _marcaSeleccionada,
                        items: items,
                        onChanged: (value) {
                          setState(() {
                            _marcaSeleccionada = value;
                            _modeloSeleccionado = null;
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  if (_marcaSeleccionada != null)
                    FutureBuilder<List<String>>(
                      // FutureBuilder para obtener los modelos desde la API
                      future: ApiServicio.obtenerModelos(
                          _marcaSeleccionada!), // Llamada al método obtenerModelos
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // Mostrar indicador de carga mientras se esperan los datos
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          // Mostrar mensaje de error si ocurre un problema
                          return const Text(
                            'Error al cargar modelos',
                            style: TextStyle(color: Colors.white),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          // Manejar caso donde no hay datos
                          return const Text(
                            'No hay modelos disponibles',
                            style: TextStyle(color: Colors.white),
                          );
                        }

                        // Crear lista de DropdownMenuItem con los modelos obtenidos
                        List<DropdownMenuItem<String>> items = snapshot.data!
                            .map((modelo) => DropdownMenuItem(
                                  value: modelo,
                                  child: Text(
                                    modelo,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ))
                            .toList();
                        return DropdownButtonFormField(
                          decoration: const InputDecoration(
                            labelText: 'Modelo',
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
                          dropdownColor:
                              const Color(0xFF2B193E), // Fondo del desplegable
                          style: const TextStyle(
                              color:
                                  Colors.white), // Color del texto seleccionado
                          value: _modeloSeleccionado,
                          items: items,
                          onChanged: (value) {
                            setState(() {
                              _modeloSeleccionado = value;
                            });
                          },
                        );
                      },
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
                  FutureBuilder<List<String>>(
                    // FutureBuilder para obtener los modelos desde la API
                    future: ApiServicio
                        .obtenerTipos(), // Llamada al método obtenerModelos
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Mostrar indicador de carga mientras se esperan los datos
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        // Mostrar mensaje de error si ocurre un problema
                        return const Text(
                          'Error al cargar tipos',
                          style: TextStyle(color: Colors.white),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        // Manejar caso donde no hay datos
                        return const Text(
                          'No hay tipos disponibles',
                          style: TextStyle(color: Colors.white),
                        );
                      }

                      // Crear lista de DropdownMenuItem con los modelos obtenidos
                      List<DropdownMenuItem<String>> items = snapshot.data!
                          .map((tipos) => DropdownMenuItem(
                                value: tipos,
                                child: Text(
                                  tipos,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ))
                          .toList();
                      return DropdownButtonFormField(
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
                            color:
                                Colors.white), // Color del texto seleccionado
                        items: items,
                        value: _tipoSeleccionado,
                        onChanged: (value) {
                          setState(() {
                            _tipoSeleccionado = value;
                          });
                        },
                      );
                    },
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
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Ancho deseado por ítem
                      const double itemWidth = 200;
                      const double itemHeight = 265;
                      // Calcular número de columnas basado en el ancho disponible
                      int crossAxisCount =
                          (constraints.maxWidth / itemWidth).floor();

                      return GridView.builder(
                        padding: const EdgeInsets.all(16.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: itemWidth /
                              itemHeight, // Proporción del ancho y alto del ítem
                        ),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return SizedBox(
                              height: itemHeight,
                              child: Card(
                                color: const Color(
                                    0xFF2B193E), // Fondo del card igual al fondo general
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(12)),
                                      child: SizedBox(
                                        height: 120, // Altura máxima
                                        width: double
                                            .infinity, // Ancho completo del card
                                        child: Image(
                                            image: NetworkImage(
                                                'https://i.postimg.cc/MpJ6R06Q/Fondo-Gris.png'),
                                            fit: BoxFit.contain,
                                            alignment: Alignment.center),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Marca y Modelo',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color:
                                                  Colors.white, // Texto blanco
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'Año - Kilometraje',
                                            style: TextStyle(
                                                color: Colors
                                                    .white), // Texto blanco
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'Ubicación',
                                            style: TextStyle(
                                                color: Colors
                                                    .white), // Texto blanco
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'Precio',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color:
                                                  Colors.white, // Texto blanco
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
