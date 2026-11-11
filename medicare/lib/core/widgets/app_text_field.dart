import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Usar dentro de un Form. La validación se muestra al salir del campo o al enviar, no mientras se escribe
///   AppTextField(label: 'Correo electrónico', controller: _email,
///     keyboardType: TextInputType.emailAddress, prefixIcon: Icons.mail_rounded)
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.controller,
    this.hint,
    this.helperText,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.prefixIcon,
    this.isPassword = false,
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.maxLines = 1,
  });

  final String label;
  final TextEditingController? controller;
  final String? hint;
  final String? helperText;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final IconData? prefixIcon;

  /// Oculta el texto y agrega el botón de mostrar u ocultar.
  final bool isPassword;
  final bool enabled;

  /// Para campos que abren un selector (por ejemplo, fecha) con [onTap].
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final int maxLines;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscured = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.label,
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUnfocus,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscureText: _obscured,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          style: textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: widget.hint,
            helperText: widget.helperText,
            prefixIcon: widget.prefixIcon == null
                ? null
                : Icon(widget.prefixIcon, size: 20, color: AppColors.textSecondary),
            suffixIcon: widget.isPassword
                ? IconButton(
                    tooltip: _obscured ? 'Mostrar contraseña' : 'Ocultar contraseña',
                    icon: Icon(
                      _obscured ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                      size: 20,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () => setState(() => _obscured = !_obscured),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
