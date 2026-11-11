import 'package:flutter/material.dart';

import '../core/widgets/placeholder_screen.dart';

/// Contenedor del médico con el menú inferior:
/// Agenda, Pacientes, Mensajes, Perfil (en ese orden, según el branding.md)
///
/// Cuando alguien termine su pestaña, ELVIS cambia el PlaceholderScreen por la pantalla real
class DoctorShell extends StatefulWidget {
  const DoctorShell({super.key});

  @override
  State<DoctorShell> createState() => _DoctorShellState();
}

class _DoctorShellState extends State<DoctorShell> {
  int _index = 0;

  static const _tabs = <Widget>[
    PlaceholderScreen(title: 'Agenda', owner: 'ANGEL'),
    PlaceholderScreen(title: 'Pacientes', owner: 'ERIC'),
    PlaceholderScreen(title: 'Mensajes', owner: 'HECTOR'),
    PlaceholderScreen(title: 'Mi perfil', owner: 'HECTOR'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.calendar_month_rounded), label: 'Agenda'),
          NavigationDestination(icon: Icon(Icons.group_rounded), label: 'Pacientes'),
          NavigationDestination(icon: Icon(Icons.chat_bubble_rounded), label: 'Mensajes'),
          NavigationDestination(icon: Icon(Icons.person_rounded), label: 'Perfil'),
        ],
      ),
    );
  }
}