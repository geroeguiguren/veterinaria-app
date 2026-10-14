import 'package:flutter/material.dart';
import 'package:veterinaria_app/features/client_dashboard/widgets/home_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('INICIO'),
        centerTitle: true
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // Margen alrededor
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribuye el espacio entre ellos
          children: [
            
            Expanded(
              child: BotonInicio(
                etiqueta: 'Mis Mascotas',
                onPressed: () => print('Mis Mascotas'),
              ),
            ),
            
            const SizedBox(width: 8), // Espacio de separación horizontal
            
            Expanded(
              child: BotonInicio(
                etiqueta: 'Mis Turnos',
                onPressed: () => print('Mis Turnos'),
              ),
            ),
            
            const SizedBox(width: 8), 
            
            Expanded(
              child: BotonInicio(
                etiqueta: 'Reservar Turno',
                onPressed: () => print('Reservar Turno'),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}