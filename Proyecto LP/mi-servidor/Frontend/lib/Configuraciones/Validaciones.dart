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

}