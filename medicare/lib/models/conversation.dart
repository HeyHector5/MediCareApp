import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_converters.dart';

/// Documento de la colección `conversations`.
/// El ID se arma con [Conversation.buildId]: "patientId_doctorId".
class Conversation {
  const Conversation({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.patientName,
    required this.doctorName,
    this.lastMessage = '',
    this.lastMessageAt,
    this.lastSenderId,
    this.unreadCount = const {},
  });

  final String id;
  final String patientId;
  final String doctorId;
  final String patientName;
  final String doctorName;
  final String lastMessage;
  final DateTime? lastMessageAt;
  final String? lastSenderId;

  /// Mensajes sin leer por persona: { uid: cantidad }.
  final Map<String, int> unreadCount;

  List<String> get participants => [patientId, doctorId];

  static String buildId({required String patientId, required String doctorId}) =>
      '${patientId}_$doctorId';

  /// Mensajes sin leer para el usuario indicado.
  int unreadFor(String uid) => unreadCount[uid] ?? 0;

  /// Nombre de la otra persona de la conversación.
  String otherNameFor(String uid) => uid == patientId ? doctorName : patientName;

  factory Conversation.fromMap(String id, Map<String, dynamic> map) {
    final rawUnread = map['unreadCount'] as Map<String, dynamic>? ?? const {};
    return Conversation(
      id: id,
      patientId: map['patientId'] as String? ?? '',
      doctorId: map['doctorId'] as String? ?? '',
      patientName: map['patientName'] as String? ?? '',
      doctorName: map['doctorName'] as String? ?? '',
      lastMessage: map['lastMessage'] as String? ?? '',
      lastMessageAt: dateFromFirestore(map['lastMessageAt']),
      lastSenderId: map['lastSenderId'] as String?,
      unreadCount: rawUnread.map((key, value) => MapEntry(key, intFromFirestore(value))),
    );
  }

  factory Conversation.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) =>
      Conversation.fromMap(doc.id, doc.data() ?? const {});

  /// Mapa para crear la conversación (antes del primer mensaje).
  Map<String, dynamic> toMap() => {
        'participants': participants,
        'patientId': patientId,
        'doctorId': doctorId,
        'patientName': patientName,
        'doctorName': doctorName,
        'lastMessage': lastMessage,
        'lastMessageAt': dateToFirestore(lastMessageAt),
        'lastSenderId': lastSenderId,
        'unreadCount': unreadCount,
      };
}
