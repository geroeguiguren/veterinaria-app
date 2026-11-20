import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:veterinaria_app/features/models/horario_atencion.dart';

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

  static Future<Map<String, HorarioAtencion>?> cargar() async {

    final datos = (await _documento().get()).data();

    if (datos == null) return null;

    final dias = (datos['dias'] as Map?) ?? const {};
    return _convertirDias(dias);
  }

  static Map<String, HorarioAtencion> _convertirDias(Map dias) {
    final resultado = <String, HorarioAtencion>{};

    for (final entrada in dias.entries) {
      final valor = entrada.value;
      if (valor is! Map) continue;
      resultado[entrada.key as String] =
          HorarioAtencion.desdeMapa(Map<String, dynamic>.from(valor));
    }

    return resultado;
  }

  static Future<void> guardar(Map<String, HorarioAtencion> dias) async {
    final documento = _documento();
    await documento.set({
      'veterinarioUid': documento.id,
      'duracionMin': duracionMin,
      'dias': {
        for (final entrada in dias.entries)
          entrada.key: entrada.value.aMapa(),
      },
      'actualizadoEn': FieldValue.serverTimestamp(),
    });
  }
}
