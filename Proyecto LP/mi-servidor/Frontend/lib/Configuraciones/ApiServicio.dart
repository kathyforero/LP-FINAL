import 'package:http/http.dart' as http;
import 'dart:convert';


class ApiServicio {
    //static String urlBase='https://mi-backend-106452854733.us-central1.run.app/api/';

  static String urlBase='http://localhost:8080/api/';
  

    static Future<bool> crearUsuario(String nombre, String apellido, String correo, String contrasena) async {
      final url = Uri.parse('${urlBase}usuarios'); // Endpoint para crear usuarios

      try {
        // Realizar el POST
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({"nombre": nombre, "apellido": apellido, "correo": correo, "contrasena": contrasena, "favoritos": []}),
        );

        // Verificar respuesta
        if (response.statusCode == 200) {
          // Usuario creado exitosamente
          return true;
        } else {
          // Error al crear usuario
          print('Error al crear usuario: ${response.body}');
          return false;
        }
      } catch (e) {
        print('Error al conectarse con el servidor: $e');
        return false;
      }
    }
    
    static Future<bool> autenticarUsuario(String correo, String contrasena) async {

      final url = Uri.parse('${urlBase}usuarios/autenticar'); // Reemplaza con la URL de tu backend

      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'correo': correo, 'contrasena': contrasena}),
        );

        if (response.statusCode == 200) {
          // El backend retornó éxito


          return true;
        } else if (response.statusCode == 404) {
          
          // Credenciales incorrectas
          return false;
        } else {
          // Otro error
          return false;
        }
      } catch (e) {
        print(e);
        // Error en la conexión
        throw Exception('No se pudo conectar con el servidor');
      }
    }

  static Future<Map<String, dynamic>?> obtenerUsuario(String usuario) async {
    final url = Uri.parse("${urlBase}usuarios/$usuario"); // Construir la URL

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Decodifica el JSON y retorna los datos
        final Map<String, dynamic> datosUsuario = json.decode(response.body);
        return datosUsuario; // Retorna el JSON como un mapa
      } else if (response.statusCode == 404) {
        return null;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
}

  static Future<List<String>> obtenerModelos(String marca) async {
    final url = Uri.parse('${urlBase}enums/modelos/$marca');
    
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Decodificar la respuesta JSON
        final List<dynamic> data = json.decode(response.body);
        return data.cast<String>(); // Convertir la lista dinámica a lista de Strings
      } else {
        throw Exception('Error al obtener los modelos: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception('Error al conectarse con el servidor');
    }
  }

  static Future<List<String>> obtenerMarcas() async {
    final url = Uri.parse('${urlBase}enums/marcas');
    
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Decodificar la respuesta JSON
        final List<dynamic> data = json.decode(response.body);
        return data.cast<String>(); // Convertir la lista dinámica a lista de Strings
      } else {
        throw Exception('Error al obtener las marcas: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception('Error al conectarse con el servidor');
    }
  }

  static Future<List<String>> obtenerTipos() async {
    final url = Uri.parse('${urlBase}enums/tipos');
    
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Decodificar la respuesta JSON
        final List<dynamic> data = json.decode(response.body);
        return data.cast<String>(); // Convertir la lista dinámica a lista de Strings
      } else {
        throw Exception('Error al obtener los tipos: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception('Error al conectarse con el servidor');
    }
  }

  static Future<List<String>> obtenerMotor() async {
    final url = Uri.parse('${urlBase}enums/motor');
    
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Decodificar la respuesta JSON
        final List<dynamic> data = json.decode(response.body);
        return data.cast<String>(); // Convertir la lista dinámica a lista de Strings
      } else {
        throw Exception('Error al obtener los motores: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception('Error al conectarse con el servidor');
    }
  }

  static Future<List<String>> obtenerTransmision() async {
    final url = Uri.parse('${urlBase}enums/transmision');
    
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Decodificar la respuesta JSON
        final List<dynamic> data = json.decode(response.body);
        return data.cast<String>(); // Convertir la lista dinámica a lista de Strings
      } else {
        throw Exception('Error al obtener las transmisiones: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception('Error al conectarse con el servidor');
    }
  }

  static Future<List<String>> obtenerUbicacion() async {
    final url = Uri.parse('${urlBase}enums/ubicacion');
    
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Decodificar la respuesta JSON
        final List<dynamic> data = json.decode(response.body);
        return data.cast<String>(); // Convertir la lista dinámica a lista de Strings
      } else {
        throw Exception('Error al obtener las ubicaciones: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception('Error al conectarse con el servidor');
    }
  }

  static Future<List<String>> obtenerEstados() async {
    final url = Uri.parse('${urlBase}enums/estados');
    
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Decodificar la respuesta JSON
        final List<dynamic> data = json.decode(response.body);
        return data.cast<String>(); // Convertir la lista dinámica a lista de Strings
      } else {
        throw Exception('Error al obtener los estados: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception('Error al conectarse con el servidor');
    }
  }




 
}