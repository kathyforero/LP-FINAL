import 'package:flutter/material.dart';
import '../Configuraciones/Usuario.dart';
import '../Configuraciones/ApiServicio.dart';
import "../Enums/Ubicacion.dart";
import "../Enums/MarcaDeAuto.dart";
import 'EditarAutoScreen.dart';

// Pantalla Mis Autos
class MisAutosScreen extends StatelessWidget {
  const MisAutosScreen({super.key});

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
                image: NetworkImage('https://i.postimg.cc/jqpcFJZj/Logo.png'),
                fit: BoxFit.contain,
              ),
            ),

            // Texto centrado
            Text(
              'Bienvenido al gestor de autos, ${Usuario.instancia.getNombre}!',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Calibri Light',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Título
          SizedBox(
            height: 50,
            width: 200,
            child: Image(
              image: NetworkImage('https://i.postimg.cc/CLshGBzr/MisAutos.png'),
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
          // Contenedor flexible para mostrar los autos
          Flexible(
            child: FutureBuilder<List<Map<String, dynamic>>?>(
              future: ApiServicio.obtenerAutosPorUsuario(Usuario.instancia.getCorreo!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || snapshot.data == null) {
                  return const Center(child: Text("Error al cargar los autos"));
                }

                final autos = snapshot.data!;

                if (autos.isNotEmpty) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      const double itemWidth = 250; // 🔹 Aumentado a 250
                      const double itemHeight = 325; // 🔹 Aumentado a 325
                      int crossAxisCount = (constraints.maxWidth / itemWidth).floor();

                      return GridView.builder(
                        padding: const EdgeInsets.all(16.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                    builder: (context) => EditarAutoScreen(auto: auto),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(12),
                                        ),
                                        child: SizedBox(
                                          height: 160, // 🔹 Ajustado para que la imagen sea más grande
                                          width: double.infinity,
                                          child: Image.network(
                                            '${auto['fotos'][0]}',
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child, loadingProgress) {
                                              if (loadingProgress == null) return child;
                                              return const Center(child: CircularProgressIndicator());
                                            },
                                            errorBuilder: (context, error, stackTrace) {
                                              return const Icon(Icons.error, size: 50, color: Colors.red);
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                auto['marca'] != null
                                                    ? MarcaDeAutoEnum.getDisplayName(auto['marca']) != null
                                                        ? "${MarcaDeAutoEnum.getDisplayName(auto['marca'])} ${auto['modelo']}"
                                                        : 'Marca desconocida'
                                                    : 'Marca desconocida',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '${auto['anio']} - ${auto['kilometraje']} km',
                                                style: const TextStyle(fontSize: 16, color: Colors.white),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                auto['ubicacion'] != null
                                                    ? Ubicacion.getDisplayName(auto['ubicacion']) ?? 'Ubicación desconocida'
                                                    : 'Ubicación desconocida',
                                                style: const TextStyle(fontSize: 16, color: Colors.white),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '\$${auto['precio']}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text(
                      'No hay autos para mostrar.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Calibri Light',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
