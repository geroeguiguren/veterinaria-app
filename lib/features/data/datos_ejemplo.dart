import 'package:veterinaria_app/features/models/mascota.dart';
import 'package:veterinaria_app/features/models/turno.dart';
import 'package:veterinaria_app/features/models/cliente.dart';


const List<Mascota> mascotasEjemplo = [
  Mascota(nombre: 'Firulais', especie: 'Perro', raza: 'Labrador', edad: 3),
  Mascota(nombre: 'Tyson', especie: 'Perro', raza: 'Bulldog', edad: 5),
];

const List<Cliente> clientesEjemplo = [
  Cliente(nombre: 'Juan Perez'),
  Cliente(nombre: 'Ana Gomez'),
  Cliente(nombre: 'Dra. Fernández'),
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
    duenio: 'Juan Pérez',
    fechaHora: 'Mié 24/9 · 10:30',
  ),
  Turno(
    mascota: 'Tyson',
    duenio: 'Ana Gomez',
    fechaHora: 'Mié 24/9 · 11:00',
  ),
  Turno(
    mascota: 'Matecito',
    duenio: 'Andrea M. S.',
    fechaHora: 'Mié 24/9 · 13:00',
  ),
];

const List<Turno> turnosHistorialEjemplo = [
  Turno(
    mascota: 'Firulais',
    duenio: 'Juan Pérez',
    fechaHora: 'Lun 8/9 · 09:00',
  ),
  Turno(
    mascota: 'Tyson',
    duenio: 'Ana Gomez',
    fechaHora: 'Vie 29/8 · 11:00',
  ),
];
