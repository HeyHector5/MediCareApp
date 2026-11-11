import 'package:flutter/material.dart';

import '../../models/enums.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Chip del estado de una cita
/// Lee el valor de Firestore (scheduled, completed, cancelled) y muestra el texto
/// en español. Si la cita está programada para hoy o mañana, muestra "Hoy" o "Mañana"
///
///   StatusChip(status: appointment.status, startAt: appointment.startAt)
class StatusChip extends StatelessWidget {
  const StatusChip({
    super.key,
    required this.status,
    this.startAt,
  });

  final AppointmentStatus status;

  /// Necesario para mostrar "Hoy" o "Mañana". Si es null, muestra "Programada"
  final DateTime? startAt;

  @override
  Widget build(BuildContext context) {
    final (label, foreground, background) = _style(DateTime.now());

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: foreground),
      ),
    );
  }

  (String, Color, Color) _style(DateTime now) {
    final soonLabel = _soonLabel(now);
    if (status == AppointmentStatus.scheduled && soonLabel != null) {
      return (soonLabel, AppColors.warning, AppColors.warningLight);
    }
    return switch (status) {
      AppointmentStatus.scheduled => (status.label, AppColors.info, AppColors.infoLight),
      AppointmentStatus.completed => (status.label, AppColors.success, AppColors.successLight),
      AppointmentStatus.cancelled => (status.label, AppColors.error, AppColors.errorLight),
    };
  }

  String? _soonLabel(DateTime now) {
    final date = startAt;
    if (date == null) return null;
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(date.year, date.month, date.day);
    final difference = day.difference(today).inDays;
    if (difference == 0) return 'Hoy';
    if (difference == 1) return 'Mañana';
    return null;
  }
}
