import "ApiServicio.dart";

class Usuario {
  static final Usuario _instancia = Usuario._interno();
  Usuario._interno();

  static Usuario get instancia => _instancia;

  String? id;
  String? nombre;
  String? correo;

  void establecerUsuario({required String id}) async{
    final usuario = await ApiServicio.obtenerUsuario(id);

    if (usuario != null) {
    this.id = id;
    nombre = "${usuario['nombre']} ${usuario['apellido']}"; // Uso de interpolación
    correo = usuario['correo']; // Obtén el correo del JSON
    print("$nombre $correo");
    } else {
      print("Usuario no encontrado");
    }
  }

  void limpiarUsuario() {
    id = null;
    nombre = null;
    correo = null;
  }

  String? get getId => id;

  String? get getNombre => nombre;

  String? get getCorreo => correo;

}