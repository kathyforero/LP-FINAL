import 'package:flutter/material.dart';

class SnackBarHelper {
  static bool _isSnackbarActive = false;

  /// Muestra un SnackBar con prioridad (elimina el anterior si existe).
  static void showSnackBar(BuildContext context, String message, Color backgroundColor) {
    final messenger = ScaffoldMessenger.of(context);

    if (_isSnackbarActive) return;

    // Cancela cualquier SnackBar activo
    messenger.hideCurrentSnackBar();
    
    _isSnackbarActive = true;
    // Muestra el nuevo SnackBar
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 2), // Duración del SnackBar
      ),
    ).closed.then((_) {
      // Marcar como inactivo cuando el SnackBar desaparezca
      _isSnackbarActive = false;
    });

  }
}
