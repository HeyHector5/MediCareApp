import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_converters.dart';

/// Documento de la colección `specialties`. El ID es legible: `cardiology`.
class Specialty {
  const Specialty({
    required this.id,
    required this.name,
    required this.icon,
    required this.order,
  });

  final String id;

  /// Texto visible, en español: "Cardiología".
  final String name;

  /// Nombre del ícono Material Rounded: "favorite_rounded".
  final String icon;

  /// Posición en la lista.
  final int order;

  factory Specialty.fromMap(String id, Map<String, dynamic> map) => Specialty(
        id: id,
        name: map['name'] as String? ?? '',
        icon: map['icon'] as String? ?? 'medical_services_rounded',
        order: intFromFirestore(map['order']),
      );

  factory Specialty.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) =>
      Specialty.fromMap(doc.id, doc.data() ?? const {});

  Map<String, dynamic> toMap() => {
        'name': name,
        'icon': icon,
        'order': order,
      };
}
