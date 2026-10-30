import 'package:flutter/material.dart';
import 'package:veterinaria_app/app/fechas.dart';
import 'package:veterinaria_app/features/admin/pages/agenda_page.dart';
import 'package:veterinaria_app/features/admin/pages/detalle_turno_page.dart';
import 'package:veterinaria_app/features/admin/pages/disponibilidad_page.dart';
import 'package:veterinaria_app/features/admin/pages/pacientes_page.dart';
import 'package:veterinaria_app/features/admin/widgets/boton_acceso_rapido.dart';
import 'package:veterinaria_app/features/admin/widgets/tarjeta_turno.dart';
import 'package:veterinaria_app/features/auth/pages/login_page.dart';
import 'package:veterinaria_app/features/auth/servicio_autenticacion.dart';
import 'package:veterinaria_app/features/data/datos_ejemplo.dart';
import 'package:veterinaria_app/features/data/repositorio_turnos.dart';
import 'package:veterinaria_app/features/models/turno.dart';

class PaginaHomeAdmin extends StatefulWidget {
  const PaginaHomeAdmin({super.key});

  @override
  State<PaginaHomeAdmin> createState() => _EstadoPaginaHomeAdmin();
}

class _EstadoPaginaHomeAdmin extends State<PaginaHomeAdmin> {
  @override
  void initState() {
    super.initState();
    // Los turnos reales llegan en tiempo real mientras haya sesión.
    RepositorioTurnos.escuchar();
  }

  void _abrirPagina(BuildContext context, Widget pagina) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (context) => pagina));
  }

  Future<void> _cerrarSesion(BuildContext context) async {
    await RepositorioTurnos.detener();
    await ServicioAutenticacion.cerrarSesion();
    if (!context.mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (context) => const PaginaLogin()),
      (ruta) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).textTheme;
    final hoy = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const Icon(Icons.logout),
            onPressed: () => _cerrarSesion(context),
          ),
        ],
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
                          onPressed: () =>
                              _abrirPagina(context, const PaginaAgenda()),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: BotonAccesoRapido(
                          etiqueta: 'Disponibilidad',
                          icono: Icons.schedule_outlined,
                          onPressed: () => _abrirPagina(
                            context,
                            const PaginaDisponibilidad(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Text('Hoy', style: tema.titleLarge),
                const SizedBox(height: 2),
                Text(fechaLarga(hoy), style: tema.bodyMedium),
                const SizedBox(height: 12),
                ValueListenableBuilder<List<Turno>>(
                  valueListenable: turnosAgenda,
                  builder: (context, todos, _) {
                    final turnosHoy = turnosDelDia(hoy);
                    if (turnosHoy.isEmpty) {
                      return Text(
                        'No hay turnos para hoy',
                        style: tema.bodyMedium,
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (final turno in turnosHoy) ...[
                          TarjetaTurno(
                            turno: turno,
                            onTap: () => _abrirPagina(
                              context,
                              PaginaDetalleTurno(turno: turno),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}