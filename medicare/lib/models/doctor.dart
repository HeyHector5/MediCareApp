import 'package:cloud_firestore/cloud_firestore.dart';

import 'enums.dart';
import 'firestore_converters.dart';

/// Horario de atención del médico: el campo `availability` de `doctors`.
class Availability {
  const Availability({
    this.days = const [1, 2, 3, 4, 5],
    this.startTime = '08:00',
    this.endTime = '16:00',
    this.slotMinutes = 30,
    this.blockedDates = const [],
  });

  /// 1 = lunes … 7 = domingo (igual que DateTime.weekday).
  final List<int> days;

  /// Formato "HH:mm" en 24 h.
  final String startTime;
  final String endTime;

  /// Duración de cada cita, en minutos.
  final int slotMinutes;

  /// Fechas sin atención, en formato "yyyy-MM-dd".
  final List<String> blockedDates;

  factory Availability.fromMap(Map<String, dynamic>? map) {
    if (map == null) return const Availability();
    return Availability(
      days: intListFromFirestore(map['days']),
      startTime: map['startTime'] as String? ?? '08:00',
      endTime: map['endTime'] as String? ?? '16:00',
      slotMinutes: intFromFirestore(map['slotMinutes'], fallback: 30),
      blockedDates: stringListFromFirestore(map['blockedDates']),
    );
  }

  Map<String, dynamic> toMap() => {
        'days': days,
        'startTime': startTime,
        'endTime': endTime,
        'slotMinutes': slotMinutes,
        'blockedDates': blockedDates,
      };

  Availability copyWith({
    List<int>? days,
    String? startTime,
    String? endTime,
    int? slotMinutes,
    List<String>? blockedDates,
  }) =>
      Availability(
        days: days ?? this.days,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        slotMinutes: slotMinutes ?? this.slotMinutes,
        blockedDates: blockedDates ?? this.blockedDates,
      );
}

/// Documento de la colección `doctors`. El ID es el mismo uid que en `users`.
class Doctor {
  const Doctor({
    required this.id,
    required this.name,
    required this.specialtyId,
    required this.specialtyName,
    this.description = '',
    this.yearsOfExperience = 0,
    this.modalities = const [AppointmentModality.inPerson],
    this.active = true,
    this.availability = const Availability(),
  });

  final String id;

  /// Con el título: "Dra. María Pérez".
  final String name;
  final String specialtyId;
  final String specialtyName;
  final String description;
  final int yearsOfExperience;
  final List<AppointmentModality> modalities;
  final bool active;
  final Availability availability;

  String get initials => initialsOf(name);
  bool get offersVideoCall => modalities.contains(AppointmentModality.videoCall);

  factory Doctor.fromMap(String id, Map<String, dynamic> map) => Doctor(
        id: id,
        name: map['name'] as String? ?? '',
        specialtyId: map['specialtyId'] as String? ?? '',
        specialtyName: map['specialtyName'] as String? ?? '',
        description: map['description'] as String? ?? '',
        yearsOfExperience: intFromFirestore(map['yearsOfExperience']),
        modalities: stringListFromFirestore(map['modalities'])
            .map(AppointmentModality.fromValue)
            .toList(),
        active: map['active'] as bool? ?? true,
        availability: Availability.fromMap(map['availability'] as Map<String, dynamic>?),
      );

  factory Doctor.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) =>
      Doctor.fromMap(doc.id, doc.data() ?? const {});

  Map<String, dynamic> toMap() => {
        'name': name,
        'specialtyId': specialtyId,
        'specialtyName': specialtyName,
        'description': description,
        'yearsOfExperience': yearsOfExperience,
        'modalities': modalities.map((m) => m.value).toList(),
        'active': active,
        'availability': availability.toMap(),
      };

  Doctor copyWith({
    String? description,
    int? yearsOfExperience,
    List<AppointmentModality>? modalities,
    bool? active,
    Availability? availability,
  }) =>
      Doctor(
        id: id,
        name: name,
        specialtyId: specialtyId,
        specialtyName: specialtyName,
        description: description ?? this.description,
        yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
        modalities: modalities ?? this.modalities,
        active: active ?? this.active,
        availability: availability ?? this.availability,
      );
}
