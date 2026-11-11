import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

enum AppButtonVariant {
  /// Acción principal. Uno solo por pantalla
  primary,

  /// Acción alternativa: borde y texto primario
  secondary,

  /// Acción menor: solo texto
  text,

  /// Acción irreversible (cancelar cita, cerrar sesión): borde y texto rojo
  destructive,
}

/// Botón común de la app. Usa este en vez de ElevatedButton u OutlinedButton
///   AppButton(label: 'Reservar cita', onPressed: _book)
///   AppButton(label: 'Cancelar cita', variant: AppButtonVariant.destructive, onPressed: _cancel)
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.expand = true,
  });

  /// Verbo que dice lo que pasa: "Reservar cita", no "Aceptar"
  final String label;

  /// Si es null, el botón queda deshabilitado
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;

  /// Mientras es true, el botón se deshabilita y muestra un indicador de carga
  final bool isLoading;

  /// true: ocupa todo el ancho (formularios). false: ancho según el texto
  final bool expand;

  static const double _height = 48;
  static const double _loaderSize = 20;

  @override
  Widget build(BuildContext context) {
    final callback = isLoading ? null : onPressed;
    final minimumSize = expand
        ? const Size.fromHeight(_height)
        : const Size(_height, _height);

    final button = switch (variant) {
      AppButtonVariant.primary => ElevatedButton(
          onPressed: callback,
          style: ElevatedButton.styleFrom(minimumSize: minimumSize),
          child: _content(Colors.white),
        ),
      AppButtonVariant.secondary => OutlinedButton(
          onPressed: callback,
          style: OutlinedButton.styleFrom(minimumSize: minimumSize),
          child: _content(AppColors.primary),
        ),
      AppButtonVariant.text => TextButton(
          onPressed: callback,
          style: TextButton.styleFrom(minimumSize: minimumSize),
          child: _content(AppColors.primary),
        ),
      AppButtonVariant.destructive => OutlinedButton(
          onPressed: callback,
          style: OutlinedButton.styleFrom(
            minimumSize: minimumSize,
            foregroundColor: AppColors.error,
            side: const BorderSide(color: AppColors.error),
          ),
          child: _content(AppColors.error),
        ),
    };

    return button;
  }

  Widget _content(Color loaderColor) {
    if (isLoading) {
      return SizedBox(
        width: _loaderSize,
        height: _loaderSize,
        child: CircularProgressIndicator(strokeWidth: 2, color: loaderColor),
      );
    }
    if (icon == null) return Text(label);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: AppSpacing.sm),
        Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
