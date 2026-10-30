import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:veterinaria_app/app/fechas.dart';

class Turno {
  const Turno({
    this.id,
    required this.mascota,
    required this.duenio,
    required this.fechaHora,
    this.clave = '',
  });

  /// Id del documento en `turnos` de Firestore.
  final String? id;
  final String mascota;

  /// Nombre del cliente dueño de la mascota.
  final String duenio;
  final DateTime fechaHora;

  /// Clave del horario ("aaaaMMdd_HHmm"), usada para liberarlo al cancelar.
  final String clave;

  String get fecha => fechaCorta(fechaHora);
  String get hora => horaTexto(fechaHora);

  factory Turno.desdeMapa(String id, Map<String, dynamic> datos) {
    return Turno(
      id: id,
      mascota: (datos['mascotaNombre'] as String?) ?? '',
      duenio: (datos['clienteNombre'] as String?) ?? '',
      fechaHora:
          (datos['fechaHora'] as Timestamp?)?.toDate() ?? DateTime.now(),
      clave: (datos['clave'] as String?) ?? '',
    );
  }
}
