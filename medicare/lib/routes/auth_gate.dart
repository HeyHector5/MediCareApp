import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../core/widgets/placeholder_screen.dart';
import 'doctor_shell.dart';
import 'patient_shell.dart';

/// Primera pantalla de la app
/// - Sin sesión: inicio de sesión
/// - Con sesión: lee users/{uid}.role y abre el menú del paciente o del médico
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _Loading();
        }
        final user = snapshot.data;
        if (user == null) {
          // Reemplazar por la pantalla real de ANGEL
          return const PlaceholderScreen(title: 'Iniciar sesión', owner: 'ANGEL');
        }
        return _RoleRouter(key: ValueKey(user.uid), uid: user.uid);
      },
    );
  }
}

class _RoleRouter extends StatefulWidget {
  const _RoleRouter({super.key, required this.uid});

  final String uid;

  @override
  State<_RoleRouter> createState() => _RoleRouterState();
}

class _RoleRouterState extends State<_RoleRouter> {
  late final Future<DocumentSnapshot<Map<String, dynamic>>> _userDoc;

  @override
  void initState() {
    super.initState();
    // Cuando existan las constantes de colecciones, usar Collections.users
    _userDoc = FirebaseFirestore.instance.collection('users').doc(widget.uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: _userDoc,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const _Loading();
        }
        final role = snapshot.data?.data()?['role'];
        return switch (role) {
          'patient' => const PatientShell(),
          'doctor' => const DoctorShell(),
          _ => const _MissingProfile(),
        };
      },
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

/// Hay sesión pero no hay documento en users (o no tiene role)
/// Pasa si la cuenta se creó en Authentication sin su documento en Firestore
class _MissingProfile extends StatelessWidget {
  const _MissingProfile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline_rounded, size: 48),
                const SizedBox(height: 16),
                Text(
                  'No encontramos tu perfil',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Cierra sesión e inténtalo de nuevo. Si sigue pasando, contacta al equipo.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                OutlinedButton(
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  child: const Text('Cerrar sesión'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}