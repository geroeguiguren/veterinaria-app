import 'package:flutter/material.dart';
import 'package:veterinaria_app/app/theme/app_theme.dart';


class _HorarioDia {
  _HorarioDia({required this.desde, required this.hasta});

  TimeOfDay desde;
  TimeOfDay hasta;
}

class PaginaDisponibilidad extends StatefulWidget {
  const PaginaDisponibilidad({super.key});

  @override
  State<PaginaDisponibilidad> createState() => _EstadoPaginaDisponibilidad();
}

class _EstadoPaginaDisponibilidad extends State<PaginaDisponibilidad> {
  static const List<String> _dias = [
    'Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sab', 'Dom',
  ];

  static const Map<String, String> _nombresCompletos = {
    'Lun': 'Lunes',
    'Mar': 'Martes',
    'Mie': 'Miércoles',
    'Jue': 'Jueves',
    'Vie': 'Viernes',
    'Sab': 'Sábado',
    'Dom': 'Domingo',
  };

  final Set<String> _diasSeleccionados = {
    'Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sab',
  };

 
  final Map<String, _HorarioDia> _horarios = {
    for (final dia in _dias)
      dia: _HorarioDia(
        desde: const TimeOfDay(hour: 9, minute: 0),
        hasta: dia == 'Sab'
            ? const TimeOfDay(hour: 13, minute: 0)
            : const TimeOfDay(hour: 18, minute: 0),
      ),
  };

  String _formatear(TimeOfDay hora) {
    final h = hora.hour.toString().padLeft(2, '0');
    final m = hora.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  int _enMinutos(TimeOfDay hora) => hora.hour * 60 + hora.minute;

  Future<void> _elegirHora(String dia, {required bool esDesde}) async {
    final horario = _horarios[dia]!;
    final elegida = await showTimePicker(
      context: context,
      initialTime: esDesde ? horario.desde : horario.hasta,
      helpText: '${_nombresCompletos[dia]} - ${esDesde ? 'Desde' : 'Hasta'}',
    );
    if (elegida == null || !mounted) return;

    final nuevoDesde = esDesde ? elegida : horario.desde;
    final nuevoHasta = esDesde ? horario.hasta : elegida;

    if (_enMinutos(nuevoDesde) >= _enMinutos(nuevoHasta)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El horario "Hasta" tiene que ser después de "Desde"'),
        ),
      );
      return;
    }

    setState(() {
      horario.desde = nuevoDesde;
      horario.hasta = nuevoHasta;
    });
  }

  void _guardar() {
    if (_diasSeleccionados.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Elegí al menos un día de atención')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Disponibilidad guardada')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).textTheme;
    final estiloTitulo = tema.bodyLarge?.copyWith(
      fontWeight: FontWeight.w700,
      color: ColoresAplicacion.textoPrincipal,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Disponibilidad'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text('Días de atención', style: estiloTitulo),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final dia in _dias)
                      FilterChip(
                        label: Text(dia),
                        showCheckmark: false,
                        selected: _diasSeleccionados.contains(dia),
                        selectedColor: ColoresAplicacion.principal,
                        backgroundColor: ColoresAplicacion.secundarioSuave,
                        side: BorderSide.none,
                        labelStyle: TextStyle(
                          color: _diasSeleccionados.contains(dia)
                              ? Colors.white
                              : ColoresAplicacion.textoSecundario,
                          fontWeight: FontWeight.w600,
                        ),
                        onSelected: (seleccionado) => setState(() {
                          if (seleccionado) {
                            _diasSeleccionados.add(dia);
                          } else {
                            _diasSeleccionados.remove(dia);
                          }
                        }),
                      ),
                  ],
                ),
                const SizedBox(height: 28),
                Text('Horario de atención', style: estiloTitulo),
                const SizedBox(height: 4),
                Text(
                  'Tocá la hora de cada día para cambiarla.',
                  style: tema.bodyMedium,
                ),
                const SizedBox(height: 12),
                if (_diasSeleccionados.isEmpty)
                  Text(
                    'No hay días seleccionados.',
                    style: tema.bodyMedium,
                  ),
                for (final dia in _dias)
                  if (_diasSeleccionados.contains(dia)) ...[
                    _TarjetaHorarioDia(
                      nombreDia: _nombresCompletos[dia]!,
                      desde: _formatear(_horarios[dia]!.desde),
                      hasta: _formatear(_horarios[dia]!.hasta),
                      onDesde: () => _elegirHora(dia, esDesde: true),
                      onHasta: () => _elegirHora(dia, esDesde: false),
                    ),
                    const SizedBox(height: 10),
                  ],
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: _guardar,
                  child: const Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Tarjeta con el nombre del día y sus botones Desde / Hasta.
class _TarjetaHorarioDia extends StatelessWidget {
  const _TarjetaHorarioDia({
    required this.nombreDia,
    required this.desde,
    required this.hasta,
    required this.onDesde,
    required this.onHasta,
  });

  final String nombreDia;
  final String desde;
  final String hasta;
  final VoidCallback onDesde;
  final VoidCallback onHasta;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColoresAplicacion.superficie,
        border: Border.all(color: ColoresAplicacion.borde),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nombreDia,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: ColoresAplicacion.textoPrincipal,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _BotonHora(texto: 'Desde: $desde', onPressed: onDesde),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _BotonHora(texto: 'Hasta: $hasta', onPressed: onHasta),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BotonHora extends StatelessWidget {
  const _BotonHora({required this.texto, required this.onPressed});

  final String texto;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColoresAplicacion.secundarioSuave,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Text(
              texto,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: ColoresAplicacion.textoPrincipal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}