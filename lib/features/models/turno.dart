/// Turno reservado por un cliente para una de sus mascotas.
class Turno {
  const Turno({
    required this.mascota,
    required this.duenio,
    required this.fechaHora,
  });

  final String mascota;
  final String duenio;
  final String fechaHora;
}
