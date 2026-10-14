import 'package:flutter/material.dart';
import 'package:veterinaria_app/features/cliente/data/datos_ejemplo.dart';
import 'package:veterinaria_app/features/cliente/pages/mis_mascotas_page.dart';
import 'package:veterinaria_app/features/cliente/pages/mis_turnos_page.dart';
import 'package:veterinaria_app/features/cliente/pages/reservar_turno_veterinario_page.dart';
import 'package:veterinaria_app/features/cliente/widgets/boton_acceso_rapido.dart';
import 'package:veterinaria_app/features/cliente/widgets/tarjeta_turno.dart';

class PaginaHomeCliente extends StatelessWidget {
  const PaginaHomeCliente({super.key});

  void _abrirPagina(BuildContext context, Widget pagina) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (context) => pagina));
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
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: BotonAccesoRapido(
                          etiqueta: 'Mis Mascotas',
                          icono: Icons.pets,
                          onPressed: () =>
                              _abrirPagina(context, const PaginaMisMascotas()),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: BotonAccesoRapido(
                          etiqueta: 'Reservar Turno',
                          icono: Icons.event_available_outlined,
                          onPressed: () => _abrirPagina(
                            context,
                            const PaginaReservarTurnoVeterinario(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: BotonAccesoRapido(
                          etiqueta: 'Mis Turnos',
                          icono: Icons.calendar_month_outlined,
                          onPressed: () =>
                              _abrirPagina(context, const PaginaMisTurnos()),
                        ),
                      ),
                    ],
                  ),
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
