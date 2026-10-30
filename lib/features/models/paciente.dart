/// Mascota registrada por un cliente, vista como paciente por el veterinario.
class Paciente {
  const Paciente({
    required this.id,
    required this.nombre,
    required this.especie,
    required this.raza,
    required this.edad,
    required this.duenioNombre,
    this.observaciones = '',
  });

  final String id;
  final String nombre;
  final String especie;
  final String raza;
  final int edad;
  final String duenioNombre;
  final String observaciones;

  factory Paciente.desdeMapa(String id, Map<String, dynamic> datos) {
    return Paciente(
      id: id,
      nombre: (datos['nombre'] as String?) ?? '',
      especie: (datos['especie'] as String?) ?? '',
      raza: (datos['raza'] as String?) ?? '',
      edad: (datos['edad'] as num?)?.toInt() ?? 0,
      duenioNombre: (datos['duenioNombre'] as String?) ?? '',
      observaciones: (datos['observaciones'] as String?) ?? '',
    );
  }
}
