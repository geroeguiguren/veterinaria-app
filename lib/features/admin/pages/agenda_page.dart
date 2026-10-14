import 'package:flutter/material.dart';

class PaginaAgenda extends StatelessWidget {
  const PaginaAgenda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Contenido de la página de Agenda'),
      ),
    );
  }
}
