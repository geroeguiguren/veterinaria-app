import 'package:flutter/material.dart';

class PaginaPacientes extends StatelessWidget {
  const PaginaPacientes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pacientes'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Contenido de la página de Pacientes'),
      ),
    );
  }
}