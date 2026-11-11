import 'package:flutter/material.dart';

/// Pantalla provisional para rutas que todavía no tienen su pantalla real.
/// Muestra el título, el responsable y el argumento recibido (si hay).
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    super.key,
    required this.title,
    required this.owner,
    this.argument,
  });

  final String title;
  final String owner;
  final String? argument;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.construction_rounded, size: 48),
                const SizedBox(height: 16),
                Text(title, style: textTheme.titleMedium),
                const SizedBox(height: 8),
                Text('Pantalla pendiente · Responsable: $owner', style: textTheme.bodyMedium),
                if (argument != null) ...[
                  const SizedBox(height: 8),
                  Text('Argumento: $argument', style: textTheme.bodySmall),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}