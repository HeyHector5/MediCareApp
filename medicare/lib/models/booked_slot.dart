import 'package:cloud_firestore/cloud_firestore.dart';

/// Documento de la colección `bookedSlots`. Bloquea un horario de un médico.
/// El ID se arma con [BookedSlot.buildId]: "doctorId_2026-11-04_10:30".
class BookedSlot {
  const BookedSlot({
    required this.doctorId,
    required this.date,
    required this.time,
    required this.appointmentId,
  });

  final String doctorId;

  /// Formato "yyyy-MM-dd".
  final String date;

  /// Formato "HH:mm" en 24 h.
  final String time;
  final String appointmentId;

  String get id => buildId(doctorId: doctorId, date: date, time: time);

  static String buildId({
    required String doctorId,
    required String date,
    required String time,
  }) =>
      '${doctorId}_${date}_$time';

  /// Fecha en formato "yyyy-MM-dd".
  static String formatDate(DateTime dateTime) =>
      '${dateTime.year.toString().padLeft(4, '0')}-'
      '${dateTime.month.toString().padLeft(2, '0')}-'
      '${dateTime.day.toString().padLeft(2, '0')}';

  /// Hora en formato "HH:mm".
  static String formatTime(DateTime dateTime) =>
      '${dateTime.hour.toString().padLeft(2, '0')}:'
      '${dateTime.minute.toString().padLeft(2, '0')}';

  factory BookedSlot.fromMap(Map<String, dynamic> map) => BookedSlot(
        doctorId: map['doctorId'] as String? ?? '',
        date: map['date'] as String? ?? '',
        time: map['time'] as String? ?? '',
        appointmentId: map['appointmentId'] as String? ?? '',
      );

  factory BookedSlot.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) =>
      BookedSlot.fromMap(doc.data() ?? const {});

  Map<String, dynamic> toMap() => {
        'doctorId': doctorId,
        'date': date,
        'time': time,
        'appointmentId': appointmentId,
      };
}
