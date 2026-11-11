import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import 'app_button.dart';

/// Toda pantalla que carga datos usa LoadingView, EmptyState y ErrorState

/// Cargando
class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }
}

/// Lista vacía: ícono de 48, título, una línea de explicación y, si aplica, un botón
///
///   EmptyState(
///     icon: Icons.calendar_month_rounded,
///     title: 'No tienes citas próximas',
///     message: 'Reserva una cita con el especialista que necesites.',
///     actionLabel: 'Reservar cita',
///     onAction: () => Navigator.pushNamed(context, AppRoutes.doctors),
///   )
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return _CenteredMessage(
      icon: icon,
      iconColor: AppColors.textSecondary,
      title: title,
      message: message,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }
}

/// Error al cargar: mismo formato que EmptyState, con ícono rojo y botón "Reintentar".
class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    this.title = 'Algo salió mal',
    this.message = 'No pudimos cargar la información. Revisa tu conexión e inténtalo de nuevo.',
    this.onRetry,
  });

  final String title;
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return _CenteredMessage(
      icon: Icons.error_outline_rounded,
      iconColor: AppColors.error,
      title: title,
      message: message,
      actionLabel: onRetry == null ? null : 'Reintentar',
      onAction: onRetry,
    );
  }
}

class _CenteredMessage extends StatelessWidget {
  const _CenteredMessage({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xxl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: iconColor),
            const SizedBox(height: AppSpacing.md),
            Text(title, style: textTheme.titleMedium, textAlign: TextAlign.center),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                message!,
                style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.lg),
              AppButton(label: actionLabel!, onPressed: onAction, expand: false),
            ],
          ],
        ),
      ),
    );
  }
}
