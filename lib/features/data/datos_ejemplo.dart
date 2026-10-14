import 'package:veterinaria_app/features/models/mascota.dart';
import 'package:veterinaria_app/features/models/turno.dart';
import 'package:veterinaria_app/features/models/veterinario.dart';


const List<Mascota> mascotasEjemplo = [
  Mascota(nombre: 'Firulais', especie: 'Perro', raza: 'Labrador', edad: 3),
  Mascota(nombre: 'Tyson', especie: 'Perro', raza: 'Bulldog', edad: 5),
];

const List<Veterinario> veterinariosEjemplo = [
  Veterinario(nombre: 'Dr. González', especialidad: 'Clínica general'),
  Veterinario(nombre: 'Dra. Díaz', especialidad: 'Clínica general'),
  Veterinario(nombre: 'Dra. Fernández', especialidad: 'Clínica general'),
];

const String fechaTurnoEjemplo = 'Miércoles 24 de septiembre';

const List<String> horariosEjemplo = [
  '09:00',
  '09:30',
  '10:00',
  '10:30',
  '11:00',
  '11:30',
];

const List<Turno> turnosProximosEjemplo = [
  Turno(
    mascota: 'Firulais',
    veterinario: 'Dr. González',
    fechaHora: 'Mié 24/9 · 10:30',
  ),
  Turno(
    mascota: 'Tyson',
    veterinario: 'Dra. Díaz',
    fechaHora: 'Jue 25/9 · 10:15',
  ),
];

const List<Turno> turnosHistorialEjemplo = [
  Turno(
    mascota: 'Firulais',
    veterinario: 'Dr. González',
    fechaHora: 'Lun 8/9 · 09:00',
  ),
  Turno(
    mascota: 'Tyson',
    veterinario: 'Dra. Fernández',
    fechaHora: 'Vie 29/8 · 11:00',
  ),
];
