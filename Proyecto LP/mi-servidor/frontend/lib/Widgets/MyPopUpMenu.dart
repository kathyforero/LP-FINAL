import 'package:flutter/material.dart';
import '../Pantallas/MisAutosScreen.dart';
import '../Pantallas/LoginScreen.dart';

class MyPopupMenu extends StatefulWidget {
  const MyPopupMenu({super.key});

  @override
  _MyPopupMenuState createState() => _MyPopupMenuState();
}

class _MyPopupMenuState extends State<MyPopupMenu> {
  // Variables para almacenar los colores de cada item
  Color _backgroundColorAuto = Colors.white;
  Color _textColorAuto = Colors.black;

  Color _backgroundColorCerrar = Colors.white;
  Color _textColorCerrar = Colors.black;

  // Función para actualizar los colores al hacer hover
  void _onHover(String item, bool isHovering) {
    setState(() {
      if (item == 'misautos') {
        _backgroundColorAuto = isHovering ? Color(0xFF9576DA) : Colors.white;
        _textColorAuto = isHovering ? Colors.white : Colors.black;
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
              _resetColors(); // Restaurar colores al regresar
            });
          } else if (value == 'cerrarsesion') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            ).then((_) {
              _resetColors(); // Restaurar colores al regresar
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
