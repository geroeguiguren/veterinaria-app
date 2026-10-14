import 'package:flutter/material.dart';
import 'package:veterinaria_app/app/theme/app_theme.dart';
import 'package:veterinaria_app/features/auth/widgets/auth_button.dart';
import 'package:veterinaria_app/features/cliente/data/datos_ejemplo.dart';
import 'package:veterinaria_app/features/cliente/models/veterinario.dart';
import 'package:veterinaria_app/features/cliente/pages/confirmacion_turno_page.dart';

class PaginaReservarTurnoHorario extends StatefulWidget {
  const PaginaReservarTurnoHorario({super.key, required this.veterinario});

  final Veterinario veterinario;

  @override
  State<PaginaReservarTurnoHorario> createState() =>
      _EstadoPaginaReservarTurnoHorario();
}

class _EstadoPaginaReservarTurnoHorario
    extends State<PaginaReservarTurnoHorario> {
  String? _horarioElegido;

  void _confirmarTurno() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => PaginaConfirmacionTurno(
          veterinario: widget.veterinario,
          fecha: fechaTurnoEjemplo,
          horario: _horarioElegido!,
        ),
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
                Text(widget.veterinario.nombre, style: tema.bodyLarge),
                const SizedBox(height: 4),
                Text(fechaTurnoEjemplo, style: tema.titleLarge),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (final horario in horariosEjemplo)
                      ChoiceChip(
                        label: Text(horario),
                        selected: _horarioElegido == horario,
                        selectedColor: ColoresAplicacion.principal,
                        labelStyle: TextStyle(
                          color: _horarioElegido == horario
                              ? Colors.white
                              : ColoresAplicacion.textoPrincipal,
                        ),
                        checkmarkColor: Colors.white,
                        onSelected: (_) {
                          setState(() => _horarioElegido = horario);
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 32),
                Opacity(
                  opacity: _horarioElegido == null ? 0.4 : 1,
                  child: BotonAutenticacion(
                    etiqueta: 'Confirmar turno',
                    onPressed: () {
                      if (_horarioElegido != null) {
                        _confirmarTurno();
                      }
                    },
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
