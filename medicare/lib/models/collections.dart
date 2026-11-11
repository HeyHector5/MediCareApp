/// Nombres de las colecciones de Firestore (ver docs/data-model.md).
///
/// Usa siempre estas constantes. Nunca escribas el nombre a mano:
/// un error de tipeo crearía una colección nueva sin dar ningún error.
class Collections {
  Collections._();

  static const users = 'users';
  static const specialties = 'specialties';
  static const doctors = 'doctors';
  static const appointments = 'appointments';
  static const bookedSlots = 'bookedSlots';
  static const conversations = 'conversations';

  /// Subcolección: users/{uid}/notifications
  static const notifications = 'notifications';

  /// Subcolección: conversations/{conversationId}/messages
  static const messages = 'messages';
}
