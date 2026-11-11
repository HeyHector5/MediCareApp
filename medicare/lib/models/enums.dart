/// Valores fijos del modelo de datos (ver docs/data-model.md, sección 3).
///
/// `value` es lo que se guarda en Firestore (en inglés).
/// `label` es lo que se muestra en pantalla (en español).

enum UserRole {
  patient('patient', 'Paciente'),
  doctor('doctor', 'Médico');

  const UserRole(this.value, this.label);

  final String value;
  final String label;

  static UserRole fromValue(String? value) =>
      values.firstWhere((e) => e.value == value, orElse: () => patient);

  /// Igual que [fromValue], pero devuelve null si el valor no existe.
  static UserRole? tryFromValue(String? value) {
    for (final role in values) {
      if (role.value == value) return role;
    }
    return null;
  }
}

enum AppointmentStatus {
  scheduled('scheduled', 'Programada'),
  completed('completed', 'Completada'),
  cancelled('cancelled', 'Cancelada');

  const AppointmentStatus(this.value, this.label);

  final String value;
  final String label;

  static AppointmentStatus fromValue(String? value) =>
      values.firstWhere((e) => e.value == value, orElse: () => scheduled);
}

enum AppointmentModality {
  inPerson('in_person', 'Presencial'),
  videoCall('video_call', 'Videollamada');

  const AppointmentModality(this.value, this.label);

  final String value;
  final String label;

  static AppointmentModality fromValue(String? value) =>
      values.firstWhere((e) => e.value == value, orElse: () => inPerson);
}

enum NotificationType {
  reminder('reminder'),
  appointmentBooked('appointment_booked'),
  appointmentCancelled('appointment_cancelled'),
  newMessage('new_message');

  const NotificationType(this.value);

  final String value;

  static NotificationType fromValue(String? value) =>
      values.firstWhere((e) => e.value == value, orElse: () => reminder);
}
