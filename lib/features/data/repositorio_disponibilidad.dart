import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Horario de atención de un día, con horas en formato "HH:mm".
class HorarioAtencion {
  const HorarioAtencion({
    required this.activo,
    required this.desde,
    required this.hasta,
  });

  final bool activo;
  final String desde;
  final String hasta;
}

/// Disponibilidad del veterinario con sesión iniciada.
///
/// Se guarda en `disponibilidad/{uid}` con esta forma:
/// `{ veterinarioUid, duracionMin: 60, dias: { lun: {activo, desde, hasta} } }`
/// Las claves de `dias` son: lun, mar, mie, jue, vie, sab, dom.
class RepositorioDisponibilidad {
  const RepositorioDisponibilidad._();

  /// Duración fija de cada turno, en minutos.
  static const int duracionMin = 60;

  static DocumentReference<Map<String, dynamic>> _documento() {
    final usuario = FirebaseAuth.instance.currentUser;
    if (usuario == null) throw StateError('No hay una sesión iniciada');
    return FirebaseFirestore.instance
        .collection('disponibilidad')
        .doc(usuario.uid);
  }

  /// Devuelve la disponibilidad guardada, o `null` si todavía no definió una.
  static Future<Map<String, HorarioAtencion>?> cargar() async {
    final documento = await _documento().get();
    final datos = documento.data();
    if (datos == null) return null;

    final dias = (datos['dias'] as Map?) ?? const {};
    final resultado = <String, HorarioAtencion>{};
    for (final entrada in dias.entries) {
      final valor = entrada.value;
      if (valor is! Map) continue;
      resultado[entrada.key as String] = HorarioAtencion(
        activo: valor['activo'] == true,
        desde: (valor['desde'] as String?) ?? '09:00',
        hasta: (valor['hasta'] as String?) ?? '18:00',
      );
    }
    return resultado;
  }

  static Future<void> guardar(Map<String, HorarioAtencion> dias) async {
    final usuario = FirebaseAuth.instance.currentUser!;
    await _documento().set({
      'veterinarioUid': usuario.uid,
      'duracionMin': duracionMin,
      'dias': {
        for (final entrada in dias.entries)
          entrada.key: {
            'activo': entrada.value.activo,
            'desde': entrada.value.desde,
            'hasta': entrada.value.hasta,
          },
      },
      'actualizadoEn': FieldValue.serverTimestamp(),
    });
  }
}
