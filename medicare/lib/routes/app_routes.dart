/// Solo ELVIS agrega o cambia rutas. Si necesitan una, pídansela.
/// Para navegar, usra siempre estas constantes, nunca el texto a mano:
///   Navigator.pushNamed(context, AppRoutes.doctorDetail, arguments: doctorId);
class AppRoutes {
  AppRoutes._();

  static const root = '/';

  // ---- Acceso (ANGEL) ----
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';

  // ---- Contenedores con menú inferior (ELVIS) ----
  static const patientHome = '/patient';
  static const doctorHome = '/doctor';

  // ---- Paciente ----
  // ERIC
  static const doctors = '/doctors'; // argumento opcional: specialtyId
  static const doctorDetail = '/doctors/detail'; // argumento: doctorId
  // CARLA
  static const bookAppointment = '/book'; // argumento: doctorId
  static const bookingConfirmed = '/book/confirmed'; // argumento: appointmentId
  static const appointmentDetail = '/appointments/detail'; // argumento: appointmentId
  // ROBINSON
  static const history = '/history';
  static const consultationDetail = '/history/detail'; // argumento: appointmentId
  static const notifications = '/notifications';

  // ---- Compartidas por los dos roles ----
  static const chat = '/chat'; // argumento: conversationId (HECTOR)
  static const videoCall = '/video-call'; // argumento: appointmentId (ANGEL)

  // ---- Médico ----
  // ANGEL
  static const doctorAppointmentDetail = '/doctor/appointment'; // argumento: appointmentId
  static const recordConsultation = '/doctor/consultation'; // argumento: appointmentId
  // ERIC
  static const availability = '/doctor/availability';
  static const patientDetail = '/doctor/patient'; // argumento: patientId
}