import 'package:flutter/material.dart';
import 'package:veterinaria_app/app/theme/app_theme.dart';
import 'package:veterinaria_app/features/auth/widgets/auth_button.dart';
import 'package:veterinaria_app/features/cliente/data/datos_ejemplo.dart';
import 'package:veterinaria_app/features/cliente/models/veterinario.dart';

class PaginaConfirmacionTurno extends StatelessWidget {
  const PaginaConfirmacionTurno({
    super.key,
    required this.veterinario,
    required this.fecha,
    required this.horario,
  });

  final Veterinario veterinario;
  final String fecha;
  final String horario;

  void _confirmar(BuildContext context) {
    final mensajes = ScaffoldMessenger.of(context);

    // Punto de reemplazo futuro: guardar el turno en MockAPI.
    Navigator.of(context).popUntil((ruta) => ruta.isFirst);
    mensajes
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Turno reservado')));
  }

  void _cancelar(BuildContext context) {
    Navigator.of(context).popUntil((ruta) => ruta.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).textTheme;
    // Por ahora el turno se reserva para la primera mascota de ejemplo.
    final mascota = mascotasEjemplo.first;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmar turno'),
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
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: ColoresAplicacion.superficie,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: ColoresAplicacion.borde),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mascota: ${mascota.nombre}',
                          style: tema.bodyLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Veterinario: ${veterinario.nombre}',
                          style: tema.bodyLarge,
                        ),
                        const SizedBox(height: 8),
                        Text('Fecha: $fecha', style: tema.bodyLarge),
                        const SizedBox(height: 8),
                        Text('Horario: $horario', style: tema.bodyLarge),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                BotonAutenticacion(
                  etiqueta: 'Confirmar',
                  onPressed: () => _confirmar(context),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => _cancelar(context),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(54),
                      foregroundColor: ColoresAplicacion.principal,
                      side: const BorderSide(
                        color: ColoresAplicacion.principal,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('Cancelar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
