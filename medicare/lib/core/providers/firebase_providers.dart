import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/models.dart';

/// Providers base de la app
/// - Nunca usar FirebaseAuth.instance ni FirebaseFirestore.instance en una pantalla
///   Leer con ref.watch(firebaseAuthProvider) y ref.watch(firestoreProvider)
/// - Los providers de cada funcionalidad van en su carpeta, por ejemplo
///   lib/features/chat/providers/chat_providers.dart
/// - Nombres terminados en Provider: currentUserProvider, upcomingAppointmentsProvider
/// - Datos que cambian en tiempo real: StreamProvider. Datos de una sola lectura: FutureProvider

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final firestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

/// Usuario de Firebase Auth con sesión iniciada, o null si no hay sesión
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

/// uid del usuario con sesión iniciada, o null
final currentUidProvider = Provider<String?>((ref) {
  return ref.watch(authStateProvider).value?.uid;
});

/// Documento users/{uid} del usuario con sesión iniciada, en tiempo real
/// Es null si no hay sesión o si el documento no existe
final currentUserProvider = StreamProvider<AppUser?>((ref) {
  final uid = ref.watch(currentUidProvider);
  if (uid == null) return Stream.value(null);
  return ref
      .watch(firestoreProvider)
      .collection(Collections.users)
      .doc(uid)
      .snapshots()
      .map((doc) => doc.exists ? AppUser.fromFirestore(doc) : null);
});
