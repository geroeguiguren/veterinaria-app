import 'package:flutter/material.dart';
import 'package:veterinaria_app/features/auth/servicio_autenticacion.dart';
import 'package:veterinaria_app/features/data/repositorio_historial.dart';
import 'package:veterinaria_app/features/models/turno.dart';

class PaginaHistorialTurno extends StatefulWidget {
  const PaginaHistorialTurno({super.key, required this.turno});

  final Turno turno;

  @override
  State<PaginaHistorialTurno> createState() => _EstadoPaginaHistorialTurno();
}

class _EstadoPaginaHistorialTurno extends State<PaginaHistorialTurno> {
  final _estadoGeneral = TextEditingController();
  final _diagnostico = TextEditingController();
  final _tratamientos = TextEditingController();
  final _estudios = TextEditingController();
  final _medicamentos = TextEditingController();
  final _observaciones = TextEditingController();
  bool _cargando = true;
  bool _guardando = false;

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  @override
  void dispose() {
    for (final c in [
      _estadoGeneral, _diagnostico, _tratamientos,
      _estudios, _medicamentos, _observaciones,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void _mostrar(String mensaje) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(mensaje)));
  }

  Future<void> _cargar() async {
    try {
      final registro = await RepositorioHistorial.obtener(widget.turno.id!);
      if (registro != null) {
        _estadoGeneral.text = registro.estadoGeneral;
        _diagnostico.text = registro.diagnostico;
        _tratamientos.text = registro.tratamientos;
        _estudios.text = registro.estudios;
        _medicamentos.text = registro.medicamentos;
        _observaciones.text = registro.observaciones;
      }
    } catch (error) {
      if (mounted) _mostrar(ServicioAutenticacion.mensajeDeError(error));
    }
    if (mounted) setState(() => _cargando = false);
  }

  Future<void> _guardar() async {
    setState(() => _guardando = true);
    try {
      await RepositorioHistorial.guardar(
        widget.turno,
        estadoGeneral: _estadoGeneral.text.trim(),
        diagnostico: _diagnostico.text.trim(),
        tratamientos: _tratamientos.text.trim(),
        estudios: _estudios.text.trim(),
        medicamentos: _medicamentos.text.trim(),
        observaciones: _observaciones.text.trim(),
      );
      if (!mounted) return;
      _mostrar('Historia clínica guardada');
      Navigator.of(context).pop();
    } catch (error) {
      if (!mounted) return;
      setState(() => _guardando = false);
      _mostrar(ServicioAutenticacion.mensajeDeError(error));
    }
  }

  Widget _campo(String etiqueta, TextEditingController controlador) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controlador,
        minLines: 2,
        maxLines: 6,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: etiqueta,
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final turno = widget.turno;
    return Scaffold(
      appBar: AppBar(title: const Text('Historia clínica'), centerTitle: true),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: _cargando
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(24),
                    children: [
                      Text(
                        '${turno.mascota} · ${turno.fecha} ${turno.hora}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      _campo('Estado general', _estadoGeneral),
                      _campo('Diagnóstico', _diagnostico),
                      _campo('Tratamientos', _tratamientos),
                      _campo('Estudios', _estudios),
                      _campo('Medicamentos', _medicamentos),
                      _campo('Observaciones', _observaciones),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: _guardando ? null : _guardar,
                        child: Text(_guardando ? 'Guardando…' : 'Guardar'),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}