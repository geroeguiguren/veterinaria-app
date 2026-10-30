import 'package:flutter/material.dart';
import 'package:veterinaria_app/app/theme/app_theme.dart';
import 'package:veterinaria_app/features/auth/servicio_autenticacion.dart';
import 'package:veterinaria_app/features/data/repositorio_turnos.dart';
import 'package:veterinaria_app/features/models/turno.dart';

class PaginaDetalleTurno extends StatelessWidget {
  const PaginaDetalleTurno({super.key, required this.turno});

  final Turno turno;

  Future<void> _cancelarTurno(BuildContext context) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (contextoDialogo) => AlertDialog(
        title: const Text('¿Cancelar turno?'),
        content: Text(
          'Se cancelará el turno de ${turno.mascota} '
          'del ${turno.fecha} a las ${turno.hora}.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(contextoDialogo).pop(false),
            child: const Text('Volver'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: ColoresAplicacion.error,
            ),
            onPressed: () => Navigator.of(contextoDialogo).pop(true),
            child: const Text('Cancelar turno'),
          ),
        ],
      ),
    );

    if (confirmado == true && context.mounted) {
      final mensajes = ScaffoldMessenger.of(context);
      final navegador = Navigator.of(context);
      try {
        await RepositorioTurnos.cancelar(turno);
        mensajes.showSnackBar(
          const SnackBar(content: Text('Turno cancelado')),
        );
        navegador.pop();
      } catch (error) {
        mensajes.showSnackBar(
          SnackBar(content: Text(ServicioAutenticacion.mensajeDeError(error))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).textTheme;
    final estiloNegrita = tema.bodyLarge?.copyWith(
      fontWeight: FontWeight.w700,
      color: ColoresAplicacion.textoPrincipal,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de turno'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ColoresAplicacion.secundarioSuave,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mascota: ${turno.mascota}', style: estiloNegrita),
                      const SizedBox(height: 8),
                      Text('Cliente: ${turno.duenio}', style: estiloNegrita),
                      const SizedBox(height: 8),
                      Text('Fecha: ${turno.fecha}', style: tema.bodyMedium),
                      const SizedBox(height: 4),
                      Text('Horario: ${turno.hora}', style: tema.bodyMedium),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ColoresAplicacion.error,
                    side: const BorderSide(color: ColoresAplicacion.error),
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => _cancelarTurno(context),
                  child: const Text('Cancelar turno'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}