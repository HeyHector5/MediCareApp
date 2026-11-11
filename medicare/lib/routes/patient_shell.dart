import 'package:flutter/material.dart';

import '../core/widgets/placeholder_screen.dart';

/// Contenedor del paciente con el menú inferior:
/// Inicio, Mis citas, Mensajes, Perfil (en ese orden, según el branding.md)
///
/// Cuando alguien termine su pestaña, ELVIS cambia el PlaceholderScreen por la pantalla real
class PatientShell extends StatefulWidget {
  const PatientShell({super.key});

  @override
  State<PatientShell> createState() => _PatientShellState();
}

class _PatientShellState extends State<PatientShell> {
  int _index = 0;

  static const _tabs = <Widget>[
    PlaceholderScreen(title: 'Inicio', owner: 'SIN ASIGNAR'),
    PlaceholderScreen(title: 'Mis citas', owner: 'CARLA'),
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
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Inicio'),
          NavigationDestination(icon: Icon(Icons.calendar_month_rounded), label: 'Mis citas'),
          NavigationDestination(icon: Icon(Icons.chat_bubble_rounded), label: 'Mensajes'),
          NavigationDestination(icon: Icon(Icons.person_rounded), label: 'Perfil'),
        ],
      ),
    );
  }
}