import 'package:flutter/material.dart';
import 'package:veterinaria_app/features/cliente/data/datos_ejemplo.dart';
import 'package:veterinaria_app/features/cliente/models/turno.dart';
import 'package:veterinaria_app/features/cliente/widgets/tarjeta_turno.dart';

class PaginaMisTurnos extends StatelessWidget {
  const PaginaMisTurnos({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mis Turnos'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Próximos'),
              Tab(text: 'Historial'),
            ],
          ),
        ),
        body: const SafeArea(
          child: TabBarView(
            children: [
              _ListaTurnos(turnos: turnosProximosEjemplo),
              _ListaTurnos(turnos: turnosHistorialEjemplo),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListaTurnos extends StatelessWidget {
  const _ListaTurnos({required this.turnos});

  final List<Turno> turnos;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          itemCount: turnos.length,
          separatorBuilder: (context, indice) => const SizedBox(height: 12),
          itemBuilder: (context, indice) {
            return TarjetaTurno(turno: turnos[indice]);
          },
        ),
      ),
    );
  }
}
