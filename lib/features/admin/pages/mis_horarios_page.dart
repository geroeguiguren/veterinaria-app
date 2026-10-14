import 'package:flutter/material.dart';

class MisHorarios extends StatelessWidget {
  const MisHorarios({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis horarios'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Contenido de la página de Mis horarios'),
      ),
    );
  }
}