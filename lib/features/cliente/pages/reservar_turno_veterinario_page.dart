import 'package:flutter/material.dart';
import 'package:veterinaria_app/app/theme/app_theme.dart';
import 'package:veterinaria_app/features/cliente/data/datos_ejemplo.dart';
import 'package:veterinaria_app/features/cliente/models/veterinario.dart';
import 'package:veterinaria_app/features/cliente/pages/reservar_turno_horario_page.dart';

class PaginaReservarTurnoVeterinario extends StatelessWidget {
  const PaginaReservarTurnoVeterinario({super.key});

  void _elegirVeterinario(BuildContext context, Veterinario veterinario) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) =>
            PaginaReservarTurnoHorario(veterinario: veterinario),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservar Turno'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              children: [
                Text('Elegí un veterinario', style: tema.titleLarge),
                const SizedBox(height: 16),
                for (final veterinario in veterinariosEjemplo) ...[
                  Material(
                    color: ColoresAplicacion.superficie,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => _elegirVeterinario(context, veterinario),
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: ColoresAplicacion.borde),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    veterinario.nombre,
                                    style: tema.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: ColoresAplicacion.textoPrincipal,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    veterinario.especialidad,
                                    style: tema.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              color: ColoresAplicacion.textoSecundario,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
