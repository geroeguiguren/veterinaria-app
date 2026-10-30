import 'package:flutter/material.dart';
import 'package:veterinaria_app/app/theme/app_theme.dart';
import 'package:veterinaria_app/features/auth/servicio_autenticacion.dart';
import 'package:veterinaria_app/features/data/repositorio_pacientes.dart';
import 'package:veterinaria_app/features/models/paciente.dart';

class PaginaPacientes extends StatefulWidget {
  const PaginaPacientes({super.key});

  @override
  State<PaginaPacientes> createState() => _EstadoPaginaPacientes();
}

class _EstadoPaginaPacientes extends State<PaginaPacientes> {
  late final Stream<List<Paciente>> _pacientes = RepositorioPacientes.pacientes();

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pacientes'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: StreamBuilder<List<Paciente>>(
              stream: _pacientes,
              builder: (context, estado) {
                if (estado.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      ServicioAutenticacion.mensajeDeError(estado.error!),
                      style: tema.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                if (!estado.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final pacientes = estado.data!;
                if (pacientes.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'Todavía no hay pacientes registrados.',
                      style: tema.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(24),
                  itemCount: pacientes.length,
                  separatorBuilder: (context, indice) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, indice) =>
                      _TarjetaPaciente(paciente: pacientes[indice]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _TarjetaPaciente extends StatelessWidget {
  const _TarjetaPaciente({required this.paciente});

  final Paciente paciente;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).textTheme;
    final detalle = [
      if (paciente.especie.isNotEmpty) paciente.especie,
      if (paciente.raza.isNotEmpty) paciente.raza,
      '${paciente.edad} ${paciente.edad == 1 ? 'año' : 'años'}',
    ].join(' · ');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: ColoresAplicacion.secundarioSuave,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            paciente.nombre,
            style: tema.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: ColoresAplicacion.textoPrincipal,
            ),
          ),
          const SizedBox(height: 4),
          Text(detalle, style: tema.bodyMedium),
          const SizedBox(height: 4),
          Text(
            'Cliente: ${paciente.duenioNombre.isEmpty ? '—' : paciente.duenioNombre}',
            style: tema.bodyMedium,
          ),
          if (paciente.observaciones.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(paciente.observaciones, style: tema.bodyMedium),
          ],
        ],
      ),
    );
  }
}
