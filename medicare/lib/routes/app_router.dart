import 'package:flutter/material.dart';

import '../core/widgets/placeholder_screen.dart';
import 'app_routes.dart';
import 'auth_gate.dart';
import 'doctor_shell.dart';
import 'patient_shell.dart';

/// Traduce cada nombre de ruta a su pantalla.
///
/// Mientras una pantalla no exista, se muestra un PlaceholderScreen con su
/// responsable. Cuando el responsable termine su pantalla, ELVIS cambia el
/// PlaceholderScreen por la pantalla real (una línea).
class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final id = settings.arguments is String ? settings.arguments as String : null;

    final Widget page = switch (settings.name) {
      AppRoutes.root => const AuthGate(),

      // Acceso
      AppRoutes.login => const PlaceholderScreen(title: 'Iniciar sesión', owner: 'ANGEL'),
      AppRoutes.register => const PlaceholderScreen(title: 'Registro', owner: 'ANGEL'),
      AppRoutes.forgotPassword =>
        const PlaceholderScreen(title: 'Recuperar contraseña', owner: 'ANGEL'),

      // Contenedores con menú inferior
      AppRoutes.patientHome => const PatientShell(),
      AppRoutes.doctorHome => const DoctorShell(),

      // Paciente
      AppRoutes.doctors => PlaceholderScreen(title: 'Buscar médico', owner: 'ERIC', argument: id),
      AppRoutes.doctorDetail => PlaceholderScreen(title: 'Médico', owner: 'ERIC', argument: id),
      AppRoutes.bookAppointment =>
        PlaceholderScreen(title: 'Reservar cita', owner: 'CARLA', argument: id),
      AppRoutes.bookingConfirmed =>
        PlaceholderScreen(title: 'Cita confirmada', owner: 'CARLA', argument: id),
      AppRoutes.appointmentDetail =>
        PlaceholderScreen(title: 'Detalle de la cita', owner: 'CARLA', argument: id),
      AppRoutes.history => const PlaceholderScreen(title: 'Historial', owner: 'ROBINSON'),
      AppRoutes.consultationDetail =>
        PlaceholderScreen(title: 'Detalle de la consulta', owner: 'ROBINSON', argument: id),
      AppRoutes.notifications =>
        const PlaceholderScreen(title: 'Notificaciones', owner: 'ROBINSON'),

      // Compartidas
      AppRoutes.chat => PlaceholderScreen(title: 'Chat', owner: 'HECTOR', argument: id),
      AppRoutes.videoCall => PlaceholderScreen(title: 'Videollamada', owner: 'ANGEL', argument: id),

      // Médico
      AppRoutes.doctorAppointmentDetail =>
        PlaceholderScreen(title: 'Detalle de la cita', owner: 'ANGEL', argument: id),
      AppRoutes.recordConsultation =>
        PlaceholderScreen(title: 'Registrar consulta', owner: 'ANGEL', argument: id),
      AppRoutes.availability => const PlaceholderScreen(title: 'Mi disponibilidad', owner: 'ERIC'),
      AppRoutes.patientDetail => PlaceholderScreen(title: 'Paciente', owner: 'ERIC', argument: id),

      _ => const PlaceholderScreen(title: 'Página no encontrada', owner: 'ELVIS'),
    };

    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }
}