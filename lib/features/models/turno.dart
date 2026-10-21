import 'package:veterinaria_app/app/fechas.dart';

class Turno {
  const Turno({
    required this.mascota,
    required this.duenio,
    required this.fechaHora,
  });

  final String mascota;
  final String duenio;
  final DateTime fechaHora;

  String get fecha => fechaCorta(fechaHora);
  String get hora => horaTexto(fechaHora);
}