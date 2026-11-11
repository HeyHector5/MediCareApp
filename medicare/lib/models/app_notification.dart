import 'package:cloud_firestore/cloud_firestore.dart';

import 'enums.dart';
import 'firestore_converters.dart';

/// Documento de la subcolección `users/{uid}/notifications`
/// Se llama AppNotification para no chocar con la clase Notification de Flutter
class AppNotification {
  const AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    this.appointmentId,
    this.read = false,
    this.createdAt,
  });

  final String id;
  final NotificationType type;

  final String title;
  final String body;

  /// Para abrir la cita al tocar la notificación
  final String? appointmentId;
  final bool read;
  final DateTime? createdAt;

  factory AppNotification.fromMap(String id, Map<String, dynamic> map) => AppNotification(
        id: id,
        type: NotificationType.fromValue(map['type'] as String?),
        title: map['title'] as String? ?? '',
        body: map['body'] as String? ?? '',
        appointmentId: map['appointmentId'] as String?,
        read: map['read'] as bool? ?? false,
        createdAt: dateFromFirestore(map['createdAt']),
      );

  factory AppNotification.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) =>
      AppNotification.fromMap(doc.id, doc.data() ?? const {});

  /// Mapa para crear la notificación. La hora la pone el servidor
  Map<String, dynamic> toMap() => {
        'type': type.value,
        'title': title,
        'body': body,
        'appointmentId': appointmentId,
        'read': read,
        'createdAt': FieldValue.serverTimestamp(),
      };
}
