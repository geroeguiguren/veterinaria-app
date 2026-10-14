import 'package:flutter/material.dart';
import 'package:veterinaria_app/features/cliente/data/datos_ejemplo.dart';
import 'package:veterinaria_app/features/cliente/widgets/boton_acceso_rapido.dart';
import 'package:veterinaria_app/features/cliente/widgets/tarjeta_turno.dart';

class PaginaHomeCliente extends StatelessWidget {
  const PaginaHomeCliente({super.key});

  void _mostrarProximamente(BuildContext context, String seccion) {
    // Se reemplaza por la navegación real cuando exista cada pantalla.
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$seccion: próximamente')));
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
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
                Row(
                  children: [
                    Expanded(
                      child: BotonAccesoRapido(
                        etiqueta: 'Mis Mascotas',
                        icono: Icons.pets,
                        onPressed: () =>
                            _mostrarProximamente(context, 'Mis Mascotas'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: BotonAccesoRapido(
                        etiqueta: 'Reservar Turno',
                        icono: Icons.event_available_outlined,
                        onPressed: () =>
                            _mostrarProximamente(context, 'Reservar Turno'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: BotonAccesoRapido(
                        etiqueta: 'Mis Turnos',
                        icono: Icons.calendar_month_outlined,
                        onPressed: () =>
                            _mostrarProximamente(context, 'Mis Turnos'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Text('Próximos turnos', style: tema.titleLarge),
                const SizedBox(height: 12),
                for (final turno in turnosProximosEjemplo) ...[
                  TarjetaTurno(turno: turno),
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
