import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medicare/core/theme/app_theme.dart';
import 'package:medicare/firebase_options.dart';

import 'screens/patient_profile_screen.dart';

// flutter run -t lib/features/profiles/profile_preview.dart
//   --dart-define=TEST_EMAIL=<email> --dart-define=TEST_PASSWORD=<password>
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  const email = String.fromEnvironment('TEST_EMAIL');
  const password = String.fromEnvironment('TEST_PASSWORD');
  if (email.isEmpty || password.isEmpty) {
    throw StateError('Missing --dart-define=TEST_EMAIL and/or TEST_PASSWORD.');
  }
  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

  runApp(const ProviderScope(child: ProfilePreviewApp()));
}

class ProfilePreviewApp extends StatelessWidget {
  const ProfilePreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediCare',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const PatientProfileScreen(),
    );
  }
}
