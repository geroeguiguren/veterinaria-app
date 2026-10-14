class Mascota {
  const Mascota({
    required this.nombre,
    required this.especie,
    required this.raza,
    required this.edad,
    this.observaciones = '',
  });

  final String nombre;
  final String especie;
  final String raza;
  final int edad;
  final String observaciones;
}
