import 'package:cloud_firestore/cloud_firestore.dart';

import 'enums.dart';
import 'firestore_converters.dart';

/// Datos que registra el médico al terminar: el campo `consultation` de `appointments`.
class Consultation {
  const Consultation({
    required this.diagnosis,
    this.notes = '',
    this.recommendations = const [],
    this.recordedAt,
  });

  final String diagnosis;
  final String notes;
  final List<String> recommendations;
  final DateTime? recordedAt;

  factory Consultation.fromMap(Map<String, dynamic> map) => Consultation(
        diagnosis: map['diagnosis'] as String? ?? '',
        notes: map['notes'] as String? ?? '',
        recommendations: stringListFromFirestore(map['recommendations']),
        recordedAt: dateFromFirestore(map['recordedAt']),
      );

  /// Si `recordedAt` es null, usa la hora del servidor.
  Map<String, dynamic> toMap() => {
        'diagnosis': diagnosis,
        'notes': notes,
        'recommendations': recommendations,
        'recordedAt': recordedAt == null
            ? FieldValue.serverTimestamp()
            : Timestamp.fromDate(recordedAt!),
      };
}

/// Documento de la colección `appointments`. El historial también sale de aquí.
class Appointment {
  const Appointment({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
    required this.specialtyName,
    required this.startAt,
    required this.durationMinutes,
    required this.modality,
    this.reason = '',
    this.status = AppointmentStatus.scheduled,
    this.cancelledBy,
    this.videoRoom,
    this.consultation,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String patientId;
  final String patientName;
  final String doctorId;
  final String doctorName;
  final String specialtyName;
  final DateTime startAt;
  final int durationMinutes;
  final AppointmentModality modality;
  final String reason;
  final AppointmentStatus status;

  /// Quién canceló: paciente o médico. Null si no está cancelada.
  final UserRole? cancelledBy;

  /// Nombre de la sala de Jitsi. Solo en citas por videollamada.
  final String? videoRoom;

  /// Solo existe cuando la cita está completada.
  final Consultation? consultation;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DateTime get endAt => startAt.add(Duration(minutes: durationMinutes));
  bool get isScheduled => status == AppointmentStatus.scheduled;
  bool get isCompleted => status == AppointmentStatus.completed;
  bool get isCancelled => status == AppointmentStatus.cancelled;
  bool get isVideoCall => modality == AppointmentModality.videoCall;

  factory Appointment.fromMap(String id, Map<String, dynamic> map) {
    final consultationMap = map['consultation'] as Map<String, dynamic>?;
    return Appointment(
      id: id,
      patientId: map['patientId'] as String? ?? '',
      patientName: map['patientName'] as String? ?? '',
      doctorId: map['doctorId'] as String? ?? '',
      doctorName: map['doctorName'] as String? ?? '',
      specialtyName: map['specialtyName'] as String? ?? '',
      startAt: dateFromFirestore(map['startAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
      durationMinutes: intFromFirestore(map['durationMinutes'], fallback: 30),
      modality: AppointmentModality.fromValue(map['modality'] as String?),
      reason: map['reason'] as String? ?? '',
      status: AppointmentStatus.fromValue(map['status'] as String?),
      cancelledBy: UserRole.tryFromValue(map['cancelledBy'] as String?),
      videoRoom: map['videoRoom'] as String?,
      consultation: consultationMap == null ? null : Consultation.fromMap(consultationMap),
      createdAt: dateFromFirestore(map['createdAt']),
      updatedAt: dateFromFirestore(map['updatedAt']),
    );
  }

  factory Appointment.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) =>
      Appointment.fromMap(doc.id, doc.data() ?? const {});

  /// Mapa para crear la cita. `createdAt` y `updatedAt` los pone el servidor.
  Map<String, dynamic> toMap() => {
        'patientId': patientId,
        'patientName': patientName,
        'doctorId': doctorId,
        'doctorName': doctorName,
        'specialtyName': specialtyName,
        'startAt': Timestamp.fromDate(startAt),
        'durationMinutes': durationMinutes,
        'modality': modality.value,
        'reason': reason,
        'status': status.value,
        'cancelledBy': cancelledBy?.value,
        'videoRoom': videoRoom,
        'consultation': consultation?.toMap(),
        'createdAt': createdAt == null
            ? FieldValue.serverTimestamp()
            : Timestamp.fromDate(createdAt!),
        'updatedAt': FieldValue.serverTimestamp(),
      };
}
