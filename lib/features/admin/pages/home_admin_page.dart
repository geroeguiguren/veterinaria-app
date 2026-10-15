import 'package:flutter/material.dart';
import 'package:veterinaria_app/features/admin/widgets/boton_acceso_rapido.dart';
import 'package:veterinaria_app/features/admin/pages/pacientes_page.dart';
import 'package:veterinaria_app/features/admin/pages/agenda_page.dart';
import 'package:veterinaria_app/features/admin/pages/mis_horarios_page.dart';
import 'package:veterinaria_app/features/admin/widgets/tarjeta_turno.dart';
import 'package:veterinaria_app/features/data/datos_ejemplo.dart';

class PaginaHomeAdmin extends StatelessWidget {
  const PaginaHomeAdmin({super.key});

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
                          etiqueta: 'Pacientes',
                          icono: Icons.pets,
                          onPressed: () =>
                              _abrirPagina(context, const PaginaPacientes()),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: BotonAccesoRapido(
                          etiqueta: 'Agenda',
                          icono: Icons.event_available_outlined,
                          onPressed: () => _abrirPagina(
                            context,
                            const PaginaAgenda(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: BotonAccesoRapido(
                          etiqueta: 'Mis Horarios',
                          icono: Icons.calendar_month_outlined,
                          onPressed: () =>
                              _abrirPagina(context, const MisHorarios()),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Text('Hoy', style: tema.titleLarge),
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