import 'package:flutter/material.dart';
import 'package:veterinaria_app/features/admin/widgets/tarjeta_registro_clinico.dart';
import 'package:veterinaria_app/features/auth/servicio_autenticacion.dart';
import 'package:veterinaria_app/features/data/repositorio_historial.dart';
import 'package:veterinaria_app/features/models/paciente.dart';
import 'package:veterinaria_app/features/models/registro_clinico.dart';

class PaginaHistorialPaciente extends StatelessWidget {
  const PaginaHistorialPaciente({super.key, required this.paciente});

  final Paciente paciente;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de ${paciente.nombre}'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: StreamBuilder<List<RegistroClinico>>(
              stream: RepositorioHistorial.deMascota(paciente.id),
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
                final registros = estado.data!;
                if (registros.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'Esta mascota todavía no tiene historia clínica.',
                      style: tema.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(24),
                  itemCount: registros.length,
                  separatorBuilder: (context, indice) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, indice) =>
                      TarjetaRegistroClinico(registro: registros[indice]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}