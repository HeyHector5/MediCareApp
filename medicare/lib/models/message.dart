import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_converters.dart';

/// Documento de la subcolección `conversations/{id}/messages`.
class Message {
  const Message({
    required this.id,
    required this.senderId,
    required this.text,
    this.sentAt,
    this.read = false,
  });

  final String id;
  final String senderId;
  final String text;

  /// Puede ser null un instante, mientras el servidor pone la hora.
  final DateTime? sentAt;
  final bool read;

  bool isMine(String uid) => senderId == uid;

  factory Message.fromMap(String id, Map<String, dynamic> map) => Message(
        id: id,
        senderId: map['senderId'] as String? ?? '',
        text: map['text'] as String? ?? '',
        sentAt: dateFromFirestore(map['sentAt']),
        read: map['read'] as bool? ?? false,
      );

  factory Message.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) =>
      Message.fromMap(doc.id, doc.data() ?? const {});

  /// Mapa para enviar el mensaje. La hora la pone el servidor.
  Map<String, dynamic> toMap() => {
        'senderId': senderId,
        'text': text,
        'sentAt': FieldValue.serverTimestamp(),
        'read': read,
      };
}
