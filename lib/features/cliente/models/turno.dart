/// Turno reservado por un cliente para una de sus mascotas.
class Turno {
  const Turno({
    required this.mascota,
    required this.veterinario,
    required this.fechaHora,
  });

  final String mascota;
  final String veterinario;
  final String fechaHora;
}
