import 'package:flutter/material.dart';
import 'package:veterinaria_app/app/theme/app_theme.dart';
import 'package:veterinaria_app/features/data/datos_ejemplo.dart';

class PaginaPacientes extends StatelessWidget {
  const PaginaPacientes({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).textTheme;
    const pacientes = pacientesEjemplo;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pacientes'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                for (final paciente in pacientes.entries) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: ColoresAplicacion.secundarioSuave,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          paciente.key,
                          style: tema.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: ColoresAplicacion.textoPrincipal,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Cliente: ${paciente.value}',
                          style: tema.bodyMedium,
                        ),
                      ],
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