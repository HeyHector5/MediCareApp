import 'package:cloud_firestore/cloud_firestore.dart';

import 'enums.dart';
import 'firestore_converters.dart';

/// Documento de la colección `users`. El ID es el uid de Firebase Auth
class AppUser {
  const AppUser({
    required this.id,
    required this.role,
    required this.name,
    required this.email,
    this.phone = '',
    this.birthDate,
    this.createdAt,
  });

  final String id;
  final UserRole role;
  final String name;
  final String email;
  final String phone;
  final DateTime? birthDate;
  final DateTime? createdAt;

  bool get isDoctor => role == UserRole.doctor;
  bool get isPatient => role == UserRole.patient;
  String get initials => initialsOf(name);

  factory AppUser.fromMap(String id, Map<String, dynamic> map) => AppUser(
        id: id,
        role: UserRole.fromValue(map['role'] as String?),
        name: map['name'] as String? ?? '',
        email: map['email'] as String? ?? '',
        phone: map['phone'] as String? ?? '',
        birthDate: dateFromFirestore(map['birthDate']),
        createdAt: dateFromFirestore(map['createdAt']),
      );

  factory AppUser.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) =>
      AppUser.fromMap(doc.id, doc.data() ?? const {});

  /// Mapa para guardar en Firestore. Si `createdAt` es null, usa la hora del servidor.
  Map<String, dynamic> toMap() => {
        'role': role.value,
        'name': name,
        'email': email,
        'phone': phone,
        'birthDate': dateToFirestore(birthDate),
        'createdAt': createdAt == null
            ? FieldValue.serverTimestamp()
            : Timestamp.fromDate(createdAt!),
      };

  /// Solo los campos que el usuario puede editar desde su perfil.
  Map<String, dynamic> toProfileUpdateMap() => {
        'name': name,
        'phone': phone,
        'birthDate': dateToFirestore(birthDate),
      };

  AppUser copyWith({
    String? name,
    String? phone,
    DateTime? birthDate,
  }) =>
      AppUser(
        id: id,
        role: role,
        name: name ?? this.name,
        email: email,
        phone: phone ?? this.phone,
        birthDate: birthDate ?? this.birthDate,
        createdAt: createdAt,
      );
}
