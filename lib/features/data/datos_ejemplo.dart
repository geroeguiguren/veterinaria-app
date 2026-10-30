import 'package:flutter/foundation.dart';
import 'package:veterinaria_app/app/fechas.dart';
import 'package:veterinaria_app/features/models/cliente.dart';
import 'package:veterinaria_app/features/models/mascota.dart';
import 'package:veterinaria_app/features/models/turno.dart';

const List<Mascota> mascotasEjemplo = [
  Mascota(nombre: 'Firulais', especie: 'Perro', raza: 'Labrador', edad: 3),
  Mascota(nombre: 'Tyson', especie: 'Perro', raza: 'Bulldog', edad: 5),
  Mascota(nombre: 'Rocky', especie: 'Perro', raza: 'Boxer', edad: 2),
];

const List<Cliente> clientesEjemplo = [
  Cliente(nombre: 'Juan Pérez'),
  Cliente(nombre: 'Ana Gómez'),
  Cliente(nombre: 'Maximiliano Perez'),
];

const Map<String, String> pacientesEjemplo = {
  'Firulais': 'Juan Pérez',
  'Tyson': 'Ana Gómez',
  'Rocky': 'Maximiliano Perez',
};

const List<String> franjasAgenda = [
  '09:00',
  '10:00',
  '11:00',
  '12:00',
  '13:00',
  '14:00',
  '15:00',
  '16:00',
  '17:00',
];

/// Turnos reservados del veterinario con sesión iniciada.
///
/// Lo alimenta en tiempo real `RepositorioTurnos` (Firestore); las pantallas
/// de agenda lo observan con `ValueListenableBuilder`.
final ValueNotifier<List<Turno>> turnosAgenda = ValueNotifier(const <Turno>[]);

List<Turno> turnosDelDia(DateTime dia) {
  final delDia = turnosAgenda.value
      .where((turno) => mismoDia(turno.fechaHora, dia))
      .toList();
  delDia.sort((a, b) => a.fechaHora.compareTo(b.fechaHora));
  return delDia;
}

Turno? turnoEn(DateTime dia, String hora) {
  for (final turno in turnosAgenda.value) {
    if (mismoDia(turno.fechaHora, dia) && turno.hora == hora) return turno;
  }
  return null;
}