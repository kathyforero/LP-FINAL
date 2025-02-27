import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiServicio {
  //static String urlBase='https://mi-backend-106452854733.us-central1.run.app/api/';

  static String urlBase = 'http://localhost:8080/api/';

  static Future<bool> crearUsuario(
      String nombre, String apellido, String correo, String contrasena) async {
    final url = Uri.parse('${urlBase}usuarios'); // Endpoint para crear usuarios

    try {
      // Realizar el POST
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "nombre": nombre,
          "apellido": apellido,
          "correo": correo,
          "contrasena": contrasena,
          "favoritos": []
        }),
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

  static Future<bool> autenticarUsuario(
      String correo, String contrasena) async {
    final url = Uri.parse(
        '${urlBase}usuarios/autenticar'); // Reemplaza con la URL de tu backend

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
        return data
            .cast<String>(); // Convertir la lista dinámica a lista de Strings
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
        return data
            .cast<String>(); // Convertir la lista dinámica a lista de Strings
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
        return data
            .cast<String>(); // Convertir la lista dinámica a lista de Strings
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
        return data
            .cast<String>(); // Convertir la lista dinámica a lista de Strings
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
        return data
            .cast<String>(); // Convertir la lista dinámica a lista de Strings
      } else {
        throw Exception(
            'Error al obtener las transmisiones: ${response.statusCode}');
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
        return data
            .cast<String>(); // Convertir la lista dinámica a lista de Strings
      } else {
        throw Exception(
            'Error al obtener las ubicaciones: ${response.statusCode}');
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
        return data
            .cast<String>(); // Convertir la lista dinámica a lista de Strings
      } else {
        throw Exception('Error al obtener los estados: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception('Error al conectarse con el servidor');
    }
  }

  static Future<bool> crearAuto(Map<String, dynamic> autoData) async {
    try {
      print('JSON enviado al backend: ${jsonEncode(autoData)}');

      final response = await http.post(
        Uri.parse('${urlBase}autos'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(autoData),
      );

      if (response.statusCode == 200) {
        print('Auto guardado exitosamente.');
        return true;
      } else {
        print('Error ${response.statusCode}: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>?> obtenerTodosLosAutos() async {
    final url = Uri.parse("${urlBase}autos"); // Construir la URL

      try {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          // Decodifica el JSON y retorna los datos
          final List<dynamic> listaAutos = json.decode(response.body);
          return List<Map<String, dynamic>>.from(listaAutos);      
        } else {
          return null;
        }
      } catch (e) {
        return null;
      }
  }

  static Future<List<Map<String, dynamic>>?> obtenerAutosPorUsuario(
      String usuario) async {
    final url =
        Uri.parse("${urlBase}autos/usuario/${usuario}"); // Construir la URL

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Decodifica el JSON y retorna los datos
        final List<dynamic> listaAutos = json.decode(response.body);
        return List<Map<String, dynamic>>.from(listaAutos);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<bool> actualizarAuto(Map<String, dynamic> autoData) async {
    try {
      print('JSON enviado al backend: ${jsonEncode(autoData)}');

      final response = await http.put(
        Uri.parse('${urlBase}autos'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(autoData),
      );

      if (response.statusCode == 200) {
        print('Auto actualizado exitosamente.');
        return true;
      } else {
        print('Error ${response.statusCode}: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      return false;
    }
  }

  static Future<bool> eliminarAuto(String placa) async {
    try {
      // Crear la URL de la solicitud, incluyendo la placa
      final url =
          Uri.parse('${urlBase}autos/${placa}'); // Se pasa la placa en la URL

      // Realizar la solicitud DELETE al backend
      final response = await http.delete(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      // Verificar si la respuesta fue exitosa
      if (response.statusCode == 200) {
        print('Auto eliminado exitosamente.');
        return true;
      } else {
        print('Error ${response.statusCode}: ${response.body}');
        return false;
      }
    } catch (e) {
      // Captura de cualquier error
      print('Error en la solicitud: $e');
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>?> obtenerAutosFiltrados({
      String? marca,
      int? kilometrajeMin,
      int? kilometrajeMax,
      double? precioMin,
      double? precioMax,
      String? tipo,
    }) async {
    try {
      // Construir la URL con los filtros dinámicos
      Uri uri = Uri.parse("${urlBase}autos/filtrar").replace(queryParameters: {
        if (marca != null) "marca": marca,
        if (kilometrajeMin != null) "kilometrajeMin": kilometrajeMin.toString(),
        if (kilometrajeMax != null) "kilometrajeMax": kilometrajeMax.toString(),
        if (precioMin != null) "precioMin": precioMin.toString(),
        if (precioMax != null) "precioMax": precioMax.toString(),
        if (tipo != null) "tipo": tipo,
      });

      // Realizar la petición HTTP
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(json.decode(response.body));
      } else {
        print("Error ${response.statusCode}: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error en la solicitud de autos filtrados: $e");
      return null;
    }
  }
}

