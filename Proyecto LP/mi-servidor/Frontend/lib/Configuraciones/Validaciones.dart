class Validaciones {
  static bool valUsuario(String email) {
    return email.length > 5;
  }

  static bool valPassword(String password) {
    return password.length > 5;
  }

  static bool valNoVacio(String value) {
    return value.isNotEmpty;
  }

  static bool valPasswordConf(String value1, String value2) {
    return value1 == value2;
  }

  static bool valAlfabetico(String value) {
    final RegExp regex = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ]+( [a-zA-ZáéíóúÁÉÍÓÚñÑ]+)*$');
    return regex.hasMatch(value);
  }
}
