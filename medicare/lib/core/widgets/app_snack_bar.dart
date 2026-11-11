import 'package:flutter/material.dart';

/// Muestra un aviso corto abajo, por 4 segundos
///   showAppSnackBar(context, 'Tus cambios se guardaron.');
void showAppSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 4),
      ),
    );
}
