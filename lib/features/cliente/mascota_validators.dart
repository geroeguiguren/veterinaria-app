/// Validaciones del formulario de alta de mascota.
class ValidadoresMascota {
  const ValidadoresMascota._();

  static String? validarNombre(String? valor) {
    final nombre = valor?.trim() ?? '';
    if (nombre.isEmpty) {
      return 'Ingresá el nombre de la mascota';
    }
    return null;
  }

  static String? validarEspecie(String? valor) {
    final especie = valor?.trim() ?? '';
    if (especie.isEmpty) {
      return 'Ingresá la especie';
    }
    return null;
  }

  static String? validarRaza(String? valor) {
    final raza = valor?.trim() ?? '';
    if (raza.isEmpty) {
      return 'Ingresá la raza';
    }
    return null;
  }

  static String? validarEdad(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) {
      return 'Ingresá la edad';
    }
    final edad = int.tryParse(texto);
    if (edad == null || edad < 0 || edad > 40) {
      return 'Ingresá una edad válida';
    }
    return null;
  }
}
