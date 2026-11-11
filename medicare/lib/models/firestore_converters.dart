import 'package:cloud_firestore/cloud_firestore.dart';

/// Funciones de ayuda para leer y escribir tipos de Firestore en los modelos.

/// Convierte un Timestamp de Firestore en DateTime. Devuelve null si no hay valor.
DateTime? dateFromFirestore(Object? value) {
  if (value is Timestamp) return value.toDate();
  if (value is DateTime) return value;
  return null;
}

/// Convierte un DateTime en Timestamp para guardarlo. Devuelve null si no hay valor.
Timestamp? dateToFirestore(DateTime? value) =>
    value == null ? null : Timestamp.fromDate(value);

/// Lee una lista de textos (por ejemplo, `recommendations` o `blockedDates`).
List<String> stringListFromFirestore(Object? value) =>
    value is List ? value.whereType<String>().toList() : <String>[];

/// Lee una lista de números enteros (por ejemplo, `availability.days`).
List<int> intListFromFirestore(Object? value) =>
    value is List ? value.whereType<num>().map((n) => n.toInt()).toList() : <int>[];

/// Lee un número entero, aunque Firestore lo haya guardado como double.
int intFromFirestore(Object? value, {int fallback = 0}) =>
    value is num ? value.toInt() : fallback;

/// Saca las iniciales de un nombre para los avatares: "Laura Méndez" -> "LM".
/// Ignora los títulos "Dr." y "Dra.".
String initialsOf(String name) {
  final words = name
      .trim()
      .split(RegExp(r'\s+'))
      .where((w) => w.isNotEmpty && w != 'Dr.' && w != 'Dra.')
      .toList();
  if (words.isEmpty) return '?';
  final first = words.first[0];
  final last = words.length > 1 ? words.last[0] : '';
  return (first + last).toUpperCase();
}
