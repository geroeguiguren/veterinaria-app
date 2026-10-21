import 'package:flutter/foundation.dart';
import 'package:veterinaria_app/features/models/mascota.dart';
import 'package:veterinaria_app/features/models/turno.dart';
import 'package:veterinaria_app/features/models/cliente.dart';

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

const String fechaAgendaEjemplo = 'Miércoles 24 de septiembre';

const List<String> franjasAgendaEjemplo = [
  '09:00',
  '10:00',
  '11:00',
  '12:00',
  '13:00',
];

final ValueNotifier<List<Turno>> turnosHoy = ValueNotifier(const [
  Turno(mascota: 'Firulais', duenio: 'Juan Pérez', fecha: 'Mié 24/9', hora: '09:00'),
  Turno(mascota: 'Tyson', duenio: 'Ana Gómez', fecha: 'Mié 24/9', hora: '10:00'),
  Turno(mascota: 'Rocky', duenio: 'Maximiliano Perez', fecha: 'Mié 24/9', hora: '13:00'),
]);

void cancelarTurno(Turno turno) {
  turnosHoy.value = turnosHoy.value.where((t) => t != turno).toList();
}

Turno? turnoEnHora(String hora) {
  for (final turno in turnosHoy.value) {
    if (turno.hora == hora) return turno;
  }
  return null;
}