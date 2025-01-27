import 'package:flutter/material.dart';

// Pantalla Mis Favoritos
class MisFavoritosScreen extends StatelessWidget {
  const MisFavoritosScreen({super.key});

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
                'Bienvenido a tus favoritos, usuario!',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Calibri Light',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
      body: Column(
        children: [
          // Título
          SizedBox(
            height: 50, // Altura máxima
            width: 270,
            child: Image(
                image: NetworkImage(
                    'https://i.postimg.cc/0NdF3D1h/misfavoritos.png'),
                fit: BoxFit.contain,
                alignment: Alignment.center),
          ),
          // Vehicle grid
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Ancho deseado por ítem
                const double itemWidth = 200;
                const double itemHeight = 265;
                // Calcular número de columnas basado en el ancho disponible
                int crossAxisCount = (constraints.maxWidth / itemWidth).floor();

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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Marca y Modelo',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white, // Texto blanco
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Año - Kilometraje',
                                      style: TextStyle(
                                          color: Colors.white), // Texto blanco
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Ubicación',
                                      style: TextStyle(
                                          color: Colors.white), // Texto blanco
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Precio',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white, // Texto blanco
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
    );
  }
}