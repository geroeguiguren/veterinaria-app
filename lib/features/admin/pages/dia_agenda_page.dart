import 'package:flutter/material.dart';
import 'package:veterinaria_app/app/fechas.dart';
import 'package:veterinaria_app/app/theme/app_theme.dart';
import 'package:veterinaria_app/features/admin/pages/detalle_turno_page.dart';
import 'package:veterinaria_app/features/admin/widgets/tarjeta_turno.dart';
import 'package:veterinaria_app/features/data/datos_ejemplo.dart';
import 'package:veterinaria_app/features/models/turno.dart';

class PaginaDiaAgenda extends StatelessWidget {
  const PaginaDiaAgenda({super.key, required this.dia});

  final DateTime dia;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi agenda'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: ValueListenableBuilder<List<Turno>>(
              valueListenable: turnosAgenda,
              builder: (context, todos, _) {
                // Franjas fijas + cualquier horario con turno fuera de ellas.
                final horas = {
                  ...franjasAgenda,
                  for (final turno in turnosDelDia(dia)) turno.hora,
                }.toList()
                  ..sort();
                return ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    Text(fechaLarga(dia), style: tema.titleLarge),
                    const SizedBox(height: 16),
                    for (final hora in horas) ...[
                      _FranjaHoraria(dia: dia, hora: hora),
                      const SizedBox(height: 10),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _FranjaHoraria extends StatelessWidget {
  const _FranjaHoraria({required this.dia, required this.hora});

  final DateTime dia;
  final String hora;

  @override
  Widget build(BuildContext context) {
    final turno = turnoEn(dia, hora);

    if (turno != null) {
      return TarjetaTurno(
        turno: turno,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => PaginaDetalleTurno(turno: turno),
          ),
        ),
      );
    }

    return Container(
      height: 64,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: ColoresAplicacion.superficie,
        border: Border.all(color: ColoresAplicacion.borde),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(hora, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}