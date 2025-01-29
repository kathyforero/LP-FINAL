import 'package:flutter/material.dart';
import '../Widgets/SnackBarHelper.dart'; // Asegúrate de importar la clase SnackBarHelper

class VerificacionesHelper {
  static bool verificarDatos(
      BuildContext context, String placa, double? precio, int? anio, int? kilometraje, double? peso) {

    if(placa.isEmpty ||
        precio == null ||        
        anio == null ||
        kilometraje == null ||
        peso == null){
            SnackBarHelper.showSnackBar(context, 'Por favor completa todos los campos.', Colors.blueGrey);
            return false;
        }
    
    // 🔹 Validación de la placa (Formato: 3 letras mayúsculas + 4 números)
    RegExp placaRegex = RegExp(r'^[A-Z]{3}\d{3,4}$');
    if (!placaRegex.hasMatch(placa)) {
      SnackBarHelper.showSnackBar(context, "La placa debe tener 3 letras mayúsculas seguidas de 3 o 4 números (Ej: ABC1234).", Colors.red);
      return false;
    }

    // 🔹 Validación del precio (Debe ser mayor a 0)
    RegExp precioRegex = RegExp(r'^\d+$');
    if (precio <= 0) {
      SnackBarHelper.showSnackBar(context, "El precio debe ser mayor a 0.", Colors.red);
      return false;
    }

    // 🔹 Validación del año (Debe ser razonable, entre 1900 y el año actual +1)
    RegExp anioRegex = RegExp(r'^\d+$');
    int anioActual = DateTime.now().year;
    if (anio < 1900 || anio > anioActual + 1) {
      SnackBarHelper.showSnackBar(context, "El año debe estar entre 1900 y ${anioActual + 1}.", Colors.red);
      return false;
    }

    // 🔹 Validación del kilometraje (Debe ser 0 o mayor)
    RegExp kilometrajeRegex = RegExp(r'^\d+$');
    if (kilometraje < 0) {
      SnackBarHelper.showSnackBar(context, "El kilometraje no puede ser negativo.", Colors.red);
      return false;
    }

    // 🔹 Validación del peso (Debe ser mayor a 0)
    RegExp pesoRegex = RegExp(r'^\d+$');
    if (peso <= 0) {
      SnackBarHelper.showSnackBar(context, "El peso debe ser mayor a 0.", Colors.red);
      return false;
    }

    return true; // ✅ Todos los datos son válidos
  }
}