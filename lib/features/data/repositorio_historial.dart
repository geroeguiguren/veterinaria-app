import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:veterinaria_app/features/models/registro_clinico.dart';
import 'package:veterinaria_app/features/models/turno.dart';

/// Fichas clínicas en la colección `historial` (una por turno, ID = turnoId).
class RepositorioHistorial {
  const RepositorioHistorial._();

  static final CollectionReference<Map<String, dynamic>> _coleccion =
      FirebaseFirestore.instance.collection('historial');

  /// La ficha de un turno, o `null` si todavía no se creó.
  static Future<RegistroClinico?> obtener(String turnoId) async {
    final documento = await _coleccion.doc(turnoId).get();
    final datos = documento.data();
    return datos == null ? null : RegistroClinico.desdeMapa(documento.id, datos);
  }

  /// Todas las fichas de una mascota, la más reciente primero.
  static Stream<List<RegistroClinico>> deMascota(String mascotaId) {
    return _coleccion
        .where('mascotaId', isEqualTo: mascotaId)
        .snapshots()
        .map((consulta) {
      final lista = [
        for (final documento in consulta.docs)
          RegistroClinico.desdeMapa(documento.id, documento.data()),
      ];
      lista.sort((a, b) => b.fechaTurno.compareTo(a.fechaTurno));
      return lista;
    });
  }

  /// Crea la ficha o la actualiza (mismo método para las dos cosas).
  static Future<void> guardar(
    Turno turno, {
    required String estadoGeneral,
    required String diagnostico,
    required String tratamientos,
    required String estudios,
    required String medicamentos,
    required String observaciones,
  }) async {
    final veterinario = FirebaseAuth.instance.currentUser;
    if (veterinario == null) throw StateError('No hay una sesión iniciada');

    await _coleccion.doc(turno.id).set({
      'turnoId': turno.id,
      'mascotaId': turno.mascotaId,
      'mascotaNombre': turno.mascota,
      'clienteUid': turno.clienteUid,
      'veterinarioUid': veterinario.uid,
      'veterinarioNombre': turno.veterinarioNombre,
      'fechaTurno': Timestamp.fromDate(turno.fechaHora),
      'estadoGeneral': estadoGeneral,
      'diagnostico': diagnostico,
      'tratamientos': tratamientos,
      'estudios': estudios,
      'medicamentos': medicamentos,
      'observaciones': observaciones,
      'actualizadoEn': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}