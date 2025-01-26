import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GuayacoCar',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 255, 226, 235),
        scaffoldBackgroundColor: const Color(0xFF0D050E),
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 600, // Ancho de la imagen
                height: 35, // Alto de la imagen
                child: Image(
                  image: NetworkImage(
                      'https://i.postimg.cc/3r491Zj6/Conduce-el-auto-de-tus.gif'),
                  fit: BoxFit.contain, // Asegura que la imagen cubra el área
                ),
              ),
              const SizedBox(height: 30),
              const SizedBox(
                width: 200, // Ancho de la imagen
                height: 120, // Alto de la imagen
                child: Image(
                  image: NetworkImage('https://i.postimg.cc/jqpcFJZj/Logo.png'),
                  fit: BoxFit.contain, // Asegura que la imagen cubra el área
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 300, // Ajusta el ancho a tu gusto
                child: TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Correo/Usuario',
                    labelStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 255, 226, 235)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 255, 226, 235)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Navegar a la nueva ventana
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 253, 114, 90),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'INICIAR SESIÓN',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  print('Crear cuenta presionado');
                },
                child: const MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    '¿No tienes una cuenta en GuayacoCar?\nCrear una cuenta',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 211, 208),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyPopupMenu extends StatefulWidget {
  const MyPopupMenu({super.key});

  @override
  _MyPopupMenuState createState() => _MyPopupMenuState();
}

class _MyPopupMenuState extends State<MyPopupMenu> {
  // Variables para almacenar los colores de cada item
  Color _backgroundColorAuto = Colors.white;
  Color _textColorAuto = Colors.black;
  
  Color _backgroundColorFavoritos = Colors.white;
  Color _textColorFavoritos = Colors.black;
  
  Color _backgroundColorCerrar = Colors.white;
  Color _textColorCerrar = Colors.black;

  // Función para actualizar los colores al hacer hover
  void _onHover(String item, bool isHovering) {
    setState(() {
      if (item == 'misautos') {
        _backgroundColorAuto = isHovering ? Color(0xFF9576DA) : Colors.white;
        _textColorAuto = isHovering ? Colors.white : Colors.black;
      } else if (item == 'misfavoritos') {
        _backgroundColorFavoritos = isHovering ? Color(0xFF9576DA) : Colors.white;
        _textColorFavoritos = isHovering ? Colors.white : Colors.black;
      } else if (item == 'cerrarsesion') {
        _backgroundColorCerrar = isHovering ? Color(0xFF9576DA) : Colors.white;
        _textColorCerrar = isHovering ? Colors.white : Colors.black;
      }
    });
  }

  // Función que reseteará los colores a su estado original al abrir el menú
  void _resetColors() {
    setState(() {
      _backgroundColorAuto = Colors.white;
      _textColorAuto = Colors.black;
      
      _backgroundColorFavoritos = Colors.white;
      _textColorFavoritos = Colors.black;
      
      _backgroundColorCerrar = Colors.white;
      _textColorCerrar = Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuTheme(
      data: PopupMenuThemeData(
        color: Colors.white, // Color de fondo general del menú
        textStyle: TextStyle(color: Colors.black), // Color de texto por defecto
        elevation: 8,
      ),
      child: PopupMenuButton<String>(
        icon: const Icon(Icons.menu, color: Colors.white),
        onSelected: (value) {
          if (value == 'misautos') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MisAutosScreen()),
            ).then((_) {
              _resetColors();  // Restaurar colores al regresar
            });
          } else if (value == 'misfavoritos') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MisFavoritosScreen()),
            ).then((_) {
              _resetColors();  // Restaurar colores al regresar
            });
          } else if (value == 'cerrarsesion') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            ).then((_) {
              _resetColors();  // Restaurar colores al regresar
            });
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'misautos',
            child: MouseRegion(
              onEnter: (_) => _onHover('misautos', true),
              onExit: (_) => _onHover('misautos', false),
              child: Container(
                color: _backgroundColorAuto,
                child: Text(
                  'Mis autos',
                  style: TextStyle(color: _textColorAuto),
                ),
              ),
            ),
          ),
          PopupMenuItem(
            value: 'misfavoritos',
            child: MouseRegion(
              onEnter: (_) => _onHover('misfavoritos', true),
              onExit: (_) => _onHover('misfavoritos', false),
              child: Container(
                color: _backgroundColorFavoritos,
                child: Text(
                  'Mis Favoritos',
                  style: TextStyle(color: _textColorFavoritos),
                ),
              ),
            ),
          ),
          PopupMenuItem(
            value: 'cerrarsesion',
            child: MouseRegion(
              onEnter: (_) => _onHover('cerrarsesion', true),
              onExit: (_) => _onHover('cerrarsession', false),
              child: Container(
                color: _backgroundColorCerrar,
                child: Text(
                  'Cerrar Sesión',
                  style: TextStyle(color: _textColorCerrar),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Pantalla principal (nueva)
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

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
                        MaterialPageRoute(builder: (context) => CrearAutoScreen()), // Reemplaza NuevaPantalla con tu clase de pantalla
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

// Pantalla Mis Autos
class MisAutosScreen extends StatelessWidget {
  const MisAutosScreen({super.key});

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
                'Bienvenido al gestor de autos, usuario!',
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
            width: 200,
            child: Image(
                image:
                    NetworkImage('https://i.postimg.cc/CLshGBzr/MisAutos.png'),
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

// Pantalla Mis Autos
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