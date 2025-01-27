import 'package:http/http.dart' as http;


class ApiServicio {
    //static String urlBase='https://mi-backend-106452854733.us-central1.run.app/api/';

  static String urlBase='http://localhost:8080/api/';
  

    static Future<bool> autenticarUsuario(String correo, String contrasena) async {
    final url = Uri.parse(urlBase + 'usuarios/autenticar?correo=$correo&contrasena=$contrasena');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      print(response.statusCode);
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


}