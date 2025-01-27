import 'package:flutter/material.dart';
import 'CrearAutoScreen.dart';
import '../Widgets/MyPopUpMenu.dart';

// Pantalla principal (nueva)
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

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

              // Texto centrado
              Text(
                'Bienvenido, usuario!',
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
                                value: 'tipo1',
                                child: Text('Sedán',
                                    style: TextStyle(
                                        color: Colors.white)), // Texto blanco
                              ),
                              DropdownMenuItem(
                                value: 'tipo2',
                                child: Text('SUV',
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
