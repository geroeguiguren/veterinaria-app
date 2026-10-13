/// Validaciones compartidas por Login y Registro.
///
/// Más adelante, el envío de estos datos se reemplaza por llamadas a MockAPI.
/// Estas reglas se mantienen en el formulario, independientemente del backend.
class ValidadoresAutenticacion {
  const ValidadoresAutenticacion._();

  static final RegExp _patronEmail = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static String? validarNombre(String? valor) {
    final nombre = valor?.trim() ?? '';
    if (nombre.isEmpty) {
      return 'Ingresá tu nombre';
    }
    if (nombre.length < 2) {
      return 'El nombre debe tener al menos 2 caracteres';
    }
    return null;
  }

  static String? validarEmail(String? valor) {
    final correo = valor?.trim() ?? '';
    if (correo.isEmpty) {
      return 'Ingresá tu email';
    }
    if (!_patronEmail.hasMatch(correo)) {
      return 'Ingresá un email válido';
    }
    return null;
  }

  static String? validarContrasena(String? valor) {
    final contrasena = valor ?? '';
    if (contrasena.isEmpty) {
      return 'Ingresá tu contraseña';
    }
    if (contrasena.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  static String? validarConfirmarContrasena(String? valor, String contrasena) {
    if (valor == null || valor.isEmpty) {
      return 'Confirmá tu contraseña';
    }
    if (valor != contrasena) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }
}
